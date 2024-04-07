module CellularAutomaton.Universe.NextStep ( nextStep, allSteps ) where

---------------------------------------------------------------------------------------------------
import Data.Matrix ( matrix, nrows, ncols, getElem, safeGet )
import Data.List.Infinite ( Infinite, iterate )
import Prelude hiding ( iterate )

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Universe.Type ( Universe(..), Cell(..), Size(..), Coord(..) )
import CellularAutomaton.Rules.Type ( StepRules(..) )
import CellularAutomaton.Rules.BSRule.Type ( isBorn, isSave, LivingNeighborCellsCount(..) )
import CellularAutomaton.Rules.Locality.Type ( Locality(..) )
import CellularAutomaton.Rules.BorderProcessMode.Type ( BorderProcessMode(..) )

---------------------------------------------------------------------------------------------------
allSteps :: StepRules -> Universe -> Infinite Universe
allSteps step_rules = iterate (nextStep step_rules)

nextStep :: StepRules -> Universe -> Universe
nextStep rules universe = matrix (nrows universe) (ncols universe) $ \(row, col) ->
    cellNewState rules (countAliveCells' (row, col)) (getElem row col universe)
    where countAliveCells' = countAliveCells (locality rules) (borderProcessMode rules) universe

---------------------------------------------------------------------------------------------------
cellNewState :: StepRules -> LivingNeighborCellsCount -> Cell -> Cell
cellNewState step_rules live_neighbors_count Dead =
    if isBorn live_neighbors_count (bornRule step_rules) then Alive else Dead
cellNewState step_rules live_neighbors_count Alive =
    if isSave live_neighbors_count (saveRule step_rules) then Alive else Dead

---------------------------------------------------------------------------------------------------
countAliveCells :: Locality -> BorderProcessMode -> Universe -> Coord -> LivingNeighborCellsCount
countAliveCells locality border_process_mode universe (row, col) = length . filter pred $
    map (\(r, c) -> safeGet r c universe) $ getCoordsFromLocality (row, col) locality
    where pred cell = case cell of
           Nothing -> border_process_mode == CountAsAlive
           Just Alive -> True
           _ -> False

---------------------------------------------------------------------------------------------------
getCoordsFromLocality :: Coord -> Locality -> [Coord]

getCoordsFromLocality (row, col) Moore =
    [(row + 1, col - 1), (row + 1, col),  (row + 1, col + 1), (row, col - 1),
     (row, col + 1), (row - 1, col - 1), (row - 1, col),  (row - 1, col + 1)]

getCoordsFromLocality (row, col) VonNeumann =
    [(row + 1, col), (row, col - 1), (row, col + 1), (row - 1, col)]

---------------------------------------------------------------------------------------------------
