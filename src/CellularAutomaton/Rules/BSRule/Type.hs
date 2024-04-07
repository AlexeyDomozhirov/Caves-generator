module CellularAutomaton.Rules.BSRule.Type 
(
    LivingNeighborCellsCount(..), BornRule, toBornRule, isBorn, SaveRule, toSaveRule, isSave, optimizeRule,
) where

---------------------------------------------------------------------------------------------------
import Data.Set ( toList, fromList )
import Data.Aeson ( FromJSON(..) )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
type LivingNeighborCellsCount = Int

---------------------------------------------------------------------------------------------------
newtype BornRule = BornRule [LivingNeighborCellsCount] deriving( Show, Eq )

toBornRule :: [LivingNeighborCellsCount] -> BornRule
toBornRule = BornRule . optimizeRule

isBorn :: LivingNeighborCellsCount -> BornRule -> Bool
isBorn count (BornRule born_rule) = count `elem` born_rule

---------------------------------------------------------------------------------------------------
instance FromJSON BornRule where
    parseJSON val = toBornRule <$> parseJSON val

---------------------------------------------------------------------------------------------------
newtype SaveRule = SaveRule [LivingNeighborCellsCount] deriving( Show, Eq )

toSaveRule :: [LivingNeighborCellsCount] -> SaveRule
toSaveRule = SaveRule . optimizeRule

isSave :: LivingNeighborCellsCount -> SaveRule -> Bool
isSave count (SaveRule save_rule) = count `elem` save_rule

---------------------------------------------------------------------------------------------------
instance FromJSON SaveRule where
    parseJSON val = toSaveRule <$> parseJSON val

---------------------------------------------------------------------------------------------------
optimizeRule :: [LivingNeighborCellsCount] -> [LivingNeighborCellsCount]
optimizeRule = toList . fromList

---------------------------------------------------------------------------------------------------