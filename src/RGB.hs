{-|
Module      : RGB
Description : RGB color handling library
Copyright   : (c) 2022 Mirko Westermeier
License     : MIT

RGB color handling library
-}

module RGB
  (
  -- * The RGB color type
    RGB(RGB, red, green, blue)
  -- * Utilty functions
  , toList
  , fromList
  , showHex
  , parseRGB
  -- * /Images/
  , Image
  , ImageList
  , toImageList
  , fromImageList
  -- * Codewars greyscale conversion
  , greyScale
  -- ** Greyscale images
  , color2grey
  , color2grey'
  ) where

import Data.Char ( digitToInt )
import Data.Maybe ( fromJust, listToMaybe )
import Text.Printf( printf, PrintfArg )
import Text.ParserCombinators.ReadP

-- | A triple type representing the three color components of RGB color values.
-- Since most systems expect component values from 0 to 255, unsigned integer
-- types like @'RGB' 'Word'@ or @'RGB' 'Int'@ are most useful for color values.
-- But keeping it parameterized here allows for a useful 'Applicative' instance
-- (see below).
data RGB a = RGB  { red   :: a -- ^ Red color value
                  , green :: a -- ^ Green color value
                  , blue  :: a -- ^ Blue color value
                  }
  deriving
    ( Eq
    -- ^ Default 'Eq' instance. Two 'RGB' values are equal /iff/ all components
    -- 'red', 'green', 'blue' are equal.
    , Show
    -- ^ Default 'Show' instance. Example: @"RGB {red = 17, green = 37, blue = 42}"@.
    -- See 'showHex' for a compressed hexadecimal stringification.
    )

-- | Application of a given function to all color components:
--
-- prop> fmap (*2) (RGB 2 7 21)  ==  RGB 4 14 42
instance Functor RGB where
  fmap = (<*>) . pure

-- | The 'Applicative' instance of 'RGB' can act as a component-wise application:
--
-- prop> (RGB (+5) (`div` 2) (*6)  <*>  RGB 12 74 7)  ==  RGB 17 37 42
instance Applicative RGB where
  pure v = RGB v v v
  (RGB fr fg fb) <*> (RGB r g b) = RGB (fr r) (fg g) (fb b)

-- | Creates a three element list of 'RGB' color components:
--
-- prop> toList (RGB 17 37 42)  ==  [17, 37, 42]
toList :: RGB a -> [a]
toList (RGB r g b) = [r, g, b]

-- | Tries to create a color from a list of values, assuming exactly three values:
--
-- prop> fromJust (fromList [17, 37, 42])  ==  RGB 17 37 42
fromList :: [a] -> Maybe (RGB a)
fromList [r, g, b]  = Just $ RGB r g b
fromList _          = Nothing

-- | Hexadecimal color representation for 'printf'able components. For
-- @'RGB' 'Int'@ it is the inverse of 'parseRGB' (modulo 'Maybe'):
--
-- prop> showHex (fromJust $ parseRGB $ "#11252a")  ==  "#11252a"
showHex :: PrintfArg a => RGB a -> String
showHex (RGB r g b) = printf "#%x%x%x" r g b

-- | Parse @'RGB' 'Int'@ values from hexadecimal strings like @#aabbcc@.
--
-- prop> fromJust (parseRGB $ showHex $ RGB 17 37 42)  ==  RGB 17 37 42
parseRGB :: String -> Maybe (RGB Int)
parseRGB = fmap fst . listToMaybe . reverse . readP_to_S parse
  where parse = do  char '#'
                    r <- comp
                    g <- comp
                    b <- comp
                    return $ RGB r g b
        comp =  do  d1 <- digit
                    d2 <- digit
                    return $ d1 * 16 + d2
        digit = do  digChar <- satisfy (`elem` "0123456789abcdef")
                    return $ digitToInt digChar

-- | Super-simple image representation as a two-dimensional list of /pixels/
-- of type @'RGB' a@.
type Image = [[RGB Int]]

-- | Super-oversimplified image representation as a three-dimensional list
-- of color components of type 'Int'.
type ImageList = [[[Int]]]

-- | Creates an 'ImageList' from an 'Image'.
toImageList :: Image -> ImageList
toImageList = map $ map toList

-- | Tries to create an 'Image' from an 'ImageList' using 'fromList'.
fromImageList :: ImageList -> Maybe Image
fromImageList = mapM $ mapM fromList

-- | Simple greyscale conversion of a @'RGB' 'Int'@ color according to the
-- [Codewars](https://codewars.com) kata
-- __[Convert Color image to greyscale](https://www.codewars.com/kata/590ee3c979ae8923bf00095b)__:
--
-- @
-- greyScale (RGB r g b)  ==  RGB ((r+g+b)\/3) ((r+g+b)\/3) ((r+g+b)\/3)
-- @
-- but using 'Fractional' arithmetics.
greyScale :: RGB Int -> RGB Int
greyScale (RGB r g b) = let compSum = fromIntegral (r+g+b)
                            average = round (compSum / 3)
                        in  RGB average average average

-- | Application of 'greyScale' to each @'RGB' 'Int'@ pixel of an 'Image'
color2grey :: Image -> Image
color2grey = map $ map greyScale

-- | Application of 'greyScale' to each @'RGB' 'Int'@ pixel of an 'ImageList'
color2grey' :: ImageList -> Maybe ImageList
color2grey' = fmap (toImageList . color2grey) . fromImageList
