module RGB.TestCodewars (testCodewars) where

import Test.Tasty ( testGroup )
import Test.Tasty.HUnit ( testCase, (@?=) )
import Test.Tasty.QuickCheck ( testProperty )
import RGB.Test
import RGB

testSampleTests = testGroup "Sample tests"
  [ testCase "1" $ color2grey' [[[48,36,124],[201,23,247],[150,162,177]]] @?= Just [[[69,69,69],[157,157,157],[163,163,163]]]
  , testCase "2" $ color2grey' [[[49,106,224],[95,150,206]],[[88,57,134],[40,183,144]],[[36,134,174],[125,27,51]],[[33,89,186],[160,39,244]],[[249,127,245],[201,233,72]],[[78,247,124],[79,245,145]]] @?= Just [[[126,126,126],[150,150,150]],[[93,93,93],[122,122,122]],[[115,115,115],[68,68,68]],[[103,103,103],[148,148,148]],[[207,207,207],[169,169,169]],[[150,150,150],[156,156,156]]]
  , testCase "3" $ color2grey' [[[181,215,243],[162,0,15],[114,38,243],[129,118,177]],[[248,118,87],[253,154,175],[158,213,168],[34,96,50]],[[184,220,48],[72,248,221],[65,74,53],[121,70,113]],[[213,63,33],[243,180,114],[137,50,11],[232,87,139]],[[222,135,77],[15,116,51],[143,193,238],[231,187,198]],[[50,145,56],[10,145,240],[185,219,179],[217,104,82]],[[233,44,86],[207,232,43],[90,225,221],[212,81,244]],[[31,72,228],[217,212,112],[225,38,94],[245,161,59]]] @?= Just [[[213,213,213],[59,59,59],[132,132,132],[141,141,141]],[[151,151,151],[194,194,194],[180,180,180],[60,60,60]],[[151,151,151],[180,180,180],[64,64,64],[101,101,101]],[[103,103,103],[179,179,179],[66,66,66],[153,153,153]],[[145,145,145],[61,61,61],[191,191,191],[205,205,205]],[[84,84,84],[132,132,132],[194,194,194],[134,134,134]],[[121,121,121],[161,161,161],[179,179,179],[179,179,179]],[[110,110,110],[180,180,180],[119,119,119],[155,155,155]]]
  , testCase "4" $ color2grey' [[[64,145,158],[242,117,31],[44,176,104],[154,72,201],[170,58,146]],[[173,12,177],[59,160,180],[100,11,96],[179,115,51],[46,149,252]],[[227,211,100],[87,135,185],[49,57,239],[150,67,55],[156,13,217]],[[178,173,59],[84,107,34],[182,41,93],[205,16,51],[30,129,216]],[[217,107,112],[31,240,11],[166,211,106],[91,107,89],[187,23,141]],[[194,191,242],[27,59,121],[138,191,129],[75,70,148],[163,244,150]],[[171,9,2],[70,17,255],[80,134,104],[150,215,59],[232,177,212]]] @?= Just [[[122,122,122],[130,130,130],[108,108,108],[142,142,142],[125,125,125]],[[121,121,121],[133,133,133],[69,69,69],[115,115,115],[149,149,149]],[[179,179,179],[136,136,136],[115,115,115],[91,91,91],[129,129,129]],[[137,137,137],[75,75,75],[105,105,105],[91,91,91],[125,125,125]],[[145,145,145],[94,94,94],[161,161,161],[96,96,96],[117,117,117]],[[209,209,209],[69,69,69],[153,153,153],[98,98,98],[186,186,186]],[[61,61,61],[114,114,114],[106,106,106],[141,141,141],[207,207,207]]]
  , testCase "5" $ color2grey' [[[230,26,161],[30,123,138],[83,90,173],[114,36,186],[109,215,130]],[[23,25,149],[60,134,191],[220,120,113],[85,94,3],[85,137,249]],[[124,159,226],[248,32,241],[130,111,112],[155,178,200],[19,65,115]],[[195,83,134],[202,178,248],[138,144,232],[84,182,33],[106,101,249]],[[227,59,3],[101,237,48],[70,98,73],[78,133,234],[124,117,98]],[[251,255,230],[229,205,48],[0,28,126],[87,28,92],[187,124,43]]] @?= Just [[[139,139,139],[97,97,97],[115,115,115],[112,112,112],[151,151,151]],[[66,66,66],[128,128,128],[151,151,151],[61,61,61],[157,157,157]],[[170,170,170],[174,174,174],[118,118,118],[178,178,178],[66,66,66]],[[137,137,137],[209,209,209],[171,171,171],[100,100,100],[152,152,152]],[[96,96,96],[129,129,129],[80,80,80],[148,148,148],[113,113,113]],[[245,245,245],[161,161,161],[51,51,51],[69,69,69],[118,118,118]]]
  ]

expectedGrey :: Image -> Image
expectedGrey          = map greyLine
  where greyLine      = map greyPixel
        greyPixel col = pure $ round $ sum $ map (comp . ($ col)) components
        comp          = (/3) . fromIntegral
        components    = [red, green, blue]

testRandomTests = testGroup "Random image tests"
  [ testProperty "Grey scale images" $ \img ->
      color2grey img == expectedGrey img
  ]

testCodewars = testGroup "Codewars tests"
  [ testSampleTests
  , testRandomTests
  ]
