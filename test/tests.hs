import Test.Tasty ( defaultMain, testGroup )

import RGB.TestRGB ( testBasics )
import RGB.TestCodewars ( testCodewars )

unitTests = testGroup "RGB tests"
  [ testBasics
  , testCodewars
  ]

main = defaultMain $ testGroup "Tests" [unitTests]
