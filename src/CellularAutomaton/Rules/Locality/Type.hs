{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BlockArguments #-}
module CellularAutomaton.Rules.Locality.Type ( Locality(..) ) where

---------------------------------------------------------------------------------------------------
import Data.Aeson ( FromJSON )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
data Locality = Moore | VonNeumann deriving( Generic, Show )

---------------------------------------------------------------------------------------------------
instance FromJSON Locality where

---------------------------------------------------------------------------------------------------