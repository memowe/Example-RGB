{-# LANGUAGE FlexibleInstances #-}
module RGB.Test where

import Test.QuickCheck ( choose, Arbitrary(..) )
import RGB

instance Arbitrary (RGB Int) where
  arbitrary = RGB <$> i256 <*> i256 <*> i256
    where i256 = choose (0, 255)
