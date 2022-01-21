module RGB.TestRGB (testBasics) where

import Test.Tasty ( testGroup )
import Test.Tasty.HUnit ( testCase, (@?=) )
import RGB

color = RGB 17 37 42 :: RGB Int

testApplicativeFunctor = testGroup "Applicative functor"
  [ testCase "Functor" $ fmap succ color @?= RGB 18 38 43
  , testCase "Applicative" $ RGB (+1) (+2) (*2) <*> color @?= RGB 18 39 84
  ]

testListConversion = testGroup "List conversion"
  [ testCase "RGB to list" $ toList color @?= [17, 37, 42]
  , testCase "List to RGB: two elements" $ fromList [17, 42] @?= Nothing
  , testCase "List to RGB: three elements" $ fromList [17, 37, 42] @?= Just color
  ]

testStringConversion = testGroup "String conversion"
  [ testCase "Show instance" $ show color @?= "RGB {red = 17, green = 37, blue = 42}"
  , testCase "Show hex" $ showHex color @?= "#11252a"
  , testCase "Read hex: crap" $ parseRGB "crap" @?= Nothing
  , testCase "Read hex: correct" $ parseRGB "#11252a" @?= Just color
  ]

image = [ [ RGB 1 2 3, RGB 4 5 6 ]
        , [ RGB 7 8 9, RGB 0 4 2 ]
        ]

imageL =  [ [ [1,2,3], [4,5,6] ]
          , [ [7,8,9], [0,4,2] ]
          ]

testImages = testGroup "Image handling"
  [ testCase "Image to list" $ toImageList image @?= imageL
  , testCase "List to image with nothing" $ fromImageList (imageL ++ [[[42]]]) @?= Nothing
  , testCase "List to image" $ fromImageList imageL @?= Just image
  ]

testBasics = testGroup "Basic tests"
  [ testApplicativeFunctor
  , testListConversion
  , testStringConversion
  , testImages
  ]
