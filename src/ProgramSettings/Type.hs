{-# LANGUAGE DeriveGeneric #-}
module ProgramSettings.Type ( ProgramSettings(..) ) where

---------------------------------------------------------------------------------------------------
import Data.Aeson ( FromJSON )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
import CavesSystem.Generator.Settings.Type ( GeneratorSettings )
import CavesSystem.Draw.Settings.Type ( DrawSettings )

---------------------------------------------------------------------------------------------------
data ProgramSettings = ProgramSettings {
        generatorSettings :: GeneratorSettings, 
        drawSettings :: DrawSettings, 
        useInteractiveGeneration :: Bool } deriving( Generic )

---------------------------------------------------------------------------------------------------
instance FromJSON ProgramSettings

---------------------------------------------------------------------------------------------------