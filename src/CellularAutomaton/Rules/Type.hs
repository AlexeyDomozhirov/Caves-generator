{-# LANGUAGE DeriveGeneric #-}
module CellularAutomaton.Rules.Type ( StepRules(..) ) where

---------------------------------------------------------------------------------------------------
import Data.Aeson ( FromJSON )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Rules.BorderProcessMode.Type ( BorderProcessMode )
import CellularAutomaton.Rules.BSRule.Type ( SaveRule, BornRule )
import CellularAutomaton.Rules.Locality.Type ( Locality )

---------------------------------------------------------------------------------------------------
data StepRules = StepRules { bornRule :: BornRule,
                             saveRule :: SaveRule,
                             locality :: Locality,
                             borderProcessMode :: BorderProcessMode } deriving( Generic, Show )

---------------------------------------------------------------------------------------------------
instance FromJSON StepRules where

---------------------------------------------------------------------------------------------------