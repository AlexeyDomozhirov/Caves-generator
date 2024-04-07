{-# LANGUAGE LambdaCase #-}
module Main where

---------------------------------------------------------------------------------------------------
import System.Random ( newStdGen )
import Control.Exception ( IOException, catch )
import Data.ByteString.Lazy ( readFile )
import Data.Aeson ( FromJSON, eitherDecode )
import Data.List.Infinite ( Infinite, head, tail )
import Prelude hiding ( readFile, head, tail )

---------------------------------------------------------------------------------------------------
import CavesSystem.Draw.Func ( draw )
import CavesSystem.Type ( CavesSystem )
import CavesSystem.Generator.Func ( generate, generateBySteps )
import ProgramSettings.Type ( ProgramSettings(..) )
import System.Console.ANSI ( setCursorPosition, clearScreen )
import CavesSystem.Generator.Settings.Type ( StepsCount(..) )

---------------------------------------------------------------------------------------------------
askFilePathFromUser :: IO FilePath
askFilePathFromUser = putStrLn "Enter filepath to program settings" >> getLine

programSettingsFromFile :: FilePath -> IO (Either String ProgramSettings)
programSettingsFromFile file_path = (eitherDecode <$> readFile file_path) `catch` handleEx
    where handleEx :: IOException -> IO (Either String ProgramSettings)
          handleEx _ = return $ Left "cant read content from file"

---------------------------------------------------------------------------------------------------
askProgramSettingsUntilItsCorrect :: IO ProgramSettings
askProgramSettingsUntilItsCorrect =
    askFilePathFromUser >>= programSettingsFromFile >>= \case
        (Left error) -> putStrLn error >> askProgramSettingsUntilItsCorrect
        (Right program_settings) -> return program_settings

---------------------------------------------------------------------------------------------------
generateAndDrawCavesSystem :: ProgramSettings -> IO ()
generateAndDrawCavesSystem program_settings = newStdGen >>= 
    draw (drawSettings program_settings) . generate (generatorSettings program_settings)

---------------------------------------------------------------------------------------------------
interactiveGeneration :: ProgramSettings -> IO ()
interactiveGeneration program_settings = newStdGen >>=
    interactiveGeneration' 0 program_settings . generateBySteps (generatorSettings program_settings)

interactiveGeneration' :: StepsCount -> ProgramSettings -> Infinite CavesSystem -> IO ()
interactiveGeneration' steps_count program_settings caves = do
    clearScreen
    setCursorPosition 0 0
    draw (drawSettings program_settings) (head caves)
    putStrLn $ "Current step: " ++ show steps_count
    putStrLn "Enter (stop) to stop or something else to continue:"
    getLine >>= \case
        "stop" -> return ()
        _ -> interactiveGeneration' (steps_count + 1) program_settings (tail caves)

---------------------------------------------------------------------------------------------------
main :: IO ()
main = do
    program_settings <- askProgramSettingsUntilItsCorrect
    if useInteractiveGeneration program_settings then
        interactiveGeneration program_settings
    else
        generateAndDrawCavesSystem program_settings
    main


---------------------------------------------------------------------------------------------------
