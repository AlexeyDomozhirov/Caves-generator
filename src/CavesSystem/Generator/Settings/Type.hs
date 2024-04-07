{-# LANGUAGE DeriveGeneric #-}
module CavesSystem.Generator.Settings.Type
(
    StepsCount(..), GeneratorSettings( stepRules, size, stepsCount, spawnChance )
) where

---------------------------------------------------------------------------------------------------
import Data.Aeson ( FromJSON(..), genericParseJSON, defaultOptions )
import Data.Aeson.Types ( parseFail )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Rules.Type ( StepRules )
import CellularAutomaton.Universe.Type ( Size(..) )
import CellularAutomaton.Universe.Random ( SpawnChance(..) )

---------------------------------------------------------------------------------------------------
type StepsCount = Int

---------------------------------------------------------------------------------------------------
data GeneratorSettings = GeneratorSettings { 
                            stepRules :: StepRules,
                            size :: Size,
                            stepsCount :: StepsCount,
                            spawnChance :: SpawnChance } deriving( Generic, Show )

---------------------------------------------------------------------------------------------------
checkGeneratorSettings :: GeneratorSettings -> Either String GeneratorSettings
checkGeneratorSettings (GeneratorSettings step_rules size@(x, y) steps chance) 
    | x < 0 || y < 0 = Left "negative size"
    | steps < 0  = Left "negative count of steps"
    | not (0 <= chance && chance <= 1) = Left "spawn chance not in range [0; 1]"
    | otherwise = Right (GeneratorSettings step_rules size steps chance)

---------------------------------------------------------------------------------------------------
instance FromJSON GeneratorSettings where
    parseJSON value = 
        checkGeneratorSettings <$> (genericParseJSON defaultOptions value) >>= either parseFail return

---------------------------------------------------------------------------------------------------