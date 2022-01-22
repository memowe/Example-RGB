# Example Library: RGB

**Ultra-simple library for [RGB color][rgb-wiki] representation in [Haskell][haskell], inspired by a special [Codewars][codewars] kata about a [simple greyscale conversion][kata].**

[![Build and test][test-badge-image]][test-badge-url]
[![Publish API docs][apigen-badge-image]][apigen-badge-url]
[![Haddock documentation][haddock-badge-image]][haddock-badge-url]
[![Codewars profile][codewars-badge-image]][codewars-badge-url]

## Details

This tiny library features

- Flexible types for colors and *"images"*.
- The color type has an [Applicative Functor instance][applicative] ([Read more][applicative-wiki]) that allows for component-wise modifications via *RGB functions*
- A continuous test suite with unit and property tests, covering the basics and codewars tests for greyscale images.
- Automatic [API docs][api-docs] generation via GitHub actions, hosted on GitHub pages.

## Contributors

[![Contributor Covenant 2.0][coco-badge-image]][coco-badge-url]

- Mirko Westermeier ([@memowe][memowe-gh])

## Author and License

Copyright (c) 2022 Mirko Westermeier

Released under the MIT license. See [LICENSE](LICENSE) for details.

[rgb-wiki]: https://en.wikipedia.org/wiki/RGB_color_model
[haskell]: https://www.haskell.org/
[codewars]: https://www.codewars.com/
[kata]: https://www.codewars.com/kata/590ee3c979ae8923bf00095b
[applicative]: https://hackage.haskell.org/package/base/docs/Control-Applicative.html#t:Applicative
[applicative-wiki]: https://en.wikipedia.org/wiki/Applicative_functor
[api-docs]: https://mirko.westermeier.de/Example-RGB/RGB.html
[memowe-gh]: https://github.com/memowe

[test-badge-image]: https://github.com/memowe/Example-RGB/actions/workflows/test.yml/badge.svg
[test-badge-url]: https://github.com/memowe/Example-RGB/actions/workflows/test.yml
[apigen-badge-image]: https://github.com/memowe/Example-RGB/actions/workflows/haddock-pages.yml/badge.svg
[apigen-badge-url]: https://github.com/memowe/Example-RGB/actions/workflows/haddock-pages.yml
[haddock-badge-image]: https://img.shields.io/badge/Haddock-Documentation-8a80a8?style=flat&logo=haskell&logoColor=lightgray
[haddock-badge-url]: https://mirko.westermeier.de/Example-RGB/RGB.html
[codewars-badge-image]: https://www.codewars.com/users/memowe/badges/micro?theme=light
[codewars-badge-url]: https://www.codewars.com/users/memowe
[coco-badge-image]: https://img.shields.io/badge/Code%20of%20Conduct-Contributor%20Covenant%202.0-8f761b.svg?style=flat&logo=adguard&logoColor=lightgray
[coco-badge-url]: CODE_OF_CONDUCT.md
