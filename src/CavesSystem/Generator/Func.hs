module CavesSystem.Generator.Func ( generate, generateBySteps ) where

---------------------------------------------------------------------------------------------------
import System.Random ( StdGen, randomRs )
import Data.List.Infinite ( map, Infinite, drop, head )
import Data.Matrix ( fromList )
import Prelude hiding  ( map, drop, head )

---------------------------------------------------------------------------------------------------
import CellularAutomaton.Universe.Type ( Size(..) )
import CellularAutomaton.Universe.NextStep ( nextStep, allSteps )
import CavesSystem.Generator.Settings.Type ( GeneratorSettings(..) )
import CavesSystem.Type ( CavesSystem, toUniverse, fromUniverse )
import CellularAutomaton.Universe.Random ( randomUniverse, SpawnChance(..) )

---------------------------------------------------------------------------------------------------
generate :: GeneratorSettings -> StdGen -> CavesSystem
generate generator_settings = head . drop (stepsCount generator_settings) . generateBySteps generator_settings

generateBySteps :: GeneratorSettings -> StdGen -> Infinite CavesSystem
generateBySteps generator_settings = map fromUniverse . 
    allSteps (stepRules generator_settings) . toUniverse . randomCavesSystem generator_settings

---------------------------------------------------------------------------------------------------
randomCavesSystem :: GeneratorSettings -> StdGen -> CavesSystem
randomCavesSystem generator_settings = fromUniverse . 
    randomUniverse (size generator_settings) (spawnChance generator_settings)

---------------------------------------------------------------------------------------------------