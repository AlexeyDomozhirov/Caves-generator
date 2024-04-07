{-# LANGUAGE DeriveGeneric #-}
module CellularAutomaton.Rules.BorderProcessMode.Type ( BorderProcessMode(..) ) where

---------------------------------------------------------------------------------------------------
import Data.Aeson ( FromJSON )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
data BorderProcessMode = CountAsDead | CountAsAlive deriving( Generic, Show, Eq )

---------------------------------------------------------------------------------------------------
instance FromJSON BorderProcessMode where

---------------------------------------------------------------------------------------------------