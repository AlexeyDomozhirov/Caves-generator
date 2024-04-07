module CellularAutomaton.Universe.Random ( SpawnChance(..), randomUniverse ) where

---------------------------------------------------------------------------------------------------
import System.Random ( randomRs, StdGen )
import Data.Matrix ( fromList )
import Data.Bool ( bool )

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Universe.Type ( Universe(..), Cell(..), Size(..) )

---------------------------------------------------------------------------------------------------
type SpawnChance = Float

randomUniverse :: Size -> SpawnChance -> StdGen -> Universe
randomUniverse (rows, cols) spawn_chance =
    fromList rows cols . map chance_to_cell . randomRs ((0, 1) :: (Float, Float))
    where chance_to_cell = bool Alive Dead . (<) spawn_chance

---------------------------------------------------------------------------------------------------
