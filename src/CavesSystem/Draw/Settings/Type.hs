{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE StandaloneDeriving #-}
module CavesSystem.Draw.Settings.Type ( DrawSettings(..), ColorSettings(..) ) where

---------------------------------------------------------------------------------------------------
import System.Console.ANSI.Types ( ColorIntensity(..), Color(..) )
import Data.Aeson ( FromJSON )
import GHC.Generics ( Generic )

---------------------------------------------------------------------------------------------------
deriving instance Generic Color

instance FromJSON Color

---------------------------------------------------------------------------------------------------
deriving instance Generic ColorIntensity

instance FromJSON ColorIntensity

---------------------------------------------------------------------------------------------------
data ColorSettings = ColorSettings { color :: Color, 
                                     intensity :: ColorIntensity } deriving( Generic, Show )

---------------------------------------------------------------------------------------------------
instance FromJSON ColorSettings

---------------------------------------------------------------------------------------------------
data DrawSettings = DrawSettings { wallSymbol :: Char,
                                   wallColorSettings :: Maybe ColorSettings,
                                   airSymbol :: Char,
                                   airColorSettings :: Maybe ColorSettings,
                                   useSeparators :: Bool } deriving( Generic, Show )

---------------------------------------------------------------------------------------------------
instance FromJSON DrawSettings

---------------------------------------------------------------------------------------------------