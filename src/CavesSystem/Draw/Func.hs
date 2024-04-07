{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}
module CavesSystem.Draw.Func ( draw ) where

---------------------------------------------------------------------------------------------------
import System.Console.ANSI ( setSGR, SGR(..), ConsoleLayer(..) )
import Data.Matrix ( toLists )

---------------------------------------------------------------------------------------------------
import CavesSystem.Draw.Settings.Type ( DrawSettings(..), ColorSettings(..) )
import CavesSystem.Type ( CavesSystem, toUniverse )
import CellularAutomaton.Universe.Type ( Cell(..) )

---------------------------------------------------------------------------------------------------
draw :: DrawSettings -> CavesSystem -> IO ()
draw draw_settings = mapM_ (\line -> printLine line >> putStrLn "") . toLists . toUniverse
    where printLine = mapM_ \case
              Alive -> drawWallSymbol draw_settings >> drawSeparator
              Dead -> drawAirSymbol draw_settings >> drawSeparator
          drawSeparator = if useSeparators draw_settings then putChar ' ' else return ()

---------------------------------------------------------------------------------------------------
drawSymbol :: Maybe ColorSettings -> Char -> IO ()
drawSymbol (Just color_settings) symbol = do
  setSGR $ [SetColor Foreground (intensity color_settings) (color color_settings)] 
  putChar symbol
  setSGR [SetDefaultColor Foreground]
drawSymbol Nothing symbol = putChar symbol

---------------------------------------------------------------------------------------------------
drawWallSymbol :: DrawSettings -> IO ()
drawWallSymbol draw_settings = drawSymbol (wallColorSettings draw_settings) (wallSymbol draw_settings)

drawAirSymbol :: DrawSettings -> IO ()
drawAirSymbol draw_settings = drawSymbol (airColorSettings draw_settings) (airSymbol draw_settings)

---------------------------------------------------------------------------------------------------