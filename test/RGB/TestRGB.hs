module RGB.TestRGB (testBasics) where

import Test.Tasty ( testGroup )
import Test.Tasty.HUnit ( testCase, (@?=) )
import Test.Tasty.QuickCheck ( testProperty )
import RGB.Test
import RGB

color = RGB 17 37 42 :: RGB Int

testApplicativeFunctor = testGroup "Applicative functor"
  [ testCase "Functor" $ fmap succ color @?= RGB 18 38 43
  , testCase "Applicative" $ RGB (+1) (+2) (*2) <*> color @?= RGB 18 39 84
  ]

testListConversion = testGroup "List conversion"
  [ testProperty "RGB to list" $ \col@(RGB r g b) ->
      [r, g, b] == (toList col :: [Int])
  , testProperty "List to RGB: three elements" $ \col@(RGB r g b) ->
      fromList [r, g, b] == Just (col :: RGB Int)
  , testCase "List to RGB: two elements" $ fromList [17, 42] @?= Nothing
  ]

testStringConversion = testGroup "String conversion"
  [ testCase "Show instance" $ show color @?= "RGB {red = 17, green = 37, blue = 42}"
  , testCase "Show hex" $ showHex color @?= "#11252a"
  , testCase "Read hex: crap" $ parseRGB "crap" @?= Nothing
  , testCase "Read hex: correct" $ parseRGB "#11252a" @?= Just color
  , testProperty "parse . hex roundtrip" $ \col ->
      parseRGB (showHex col) == Just (col :: RGB Int)
  ]

testImages = testGroup "Image handling"
  [ testProperty "Image to list" $ \img ->
      toImageList img == map (map toList) img
  , testProperty "List to image" $ \img ->
      fromImageList (map (map toList) img) == Just img
  ]

testBasics = testGroup "Basic tests"
  [ testApplicativeFunctor
  , testListConversion
  , testStringConversion
  , testImages
  ]
