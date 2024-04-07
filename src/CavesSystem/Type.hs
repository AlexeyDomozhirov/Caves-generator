module CavesSystem.Type ( CavesSystem, fromUniverse, toUniverse ) where

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Universe.Type ( Universe )

---------------------------------------------------------------------------------------------------
newtype CavesSystem = CavesSystem Universe

---------------------------------------------------------------------------------------------------
fromUniverse :: Universe -> CavesSystem
fromUniverse = CavesSystem

toUniverse :: CavesSystem -> Universe
toUniverse (CavesSystem universe) = universe

---------------------------------------------------------------------------------------------------