# State of Rust

[![Build Status](https://travis-ci.com/mssun/state-of-rust.svg?branch=master)](https://travis-ci.com/mssun/state-of-rust)

State of Rust is a project to automatically summarize various stable/unstable
features of Rust including compiler features and library features. There is a
daily job to check the master branch of Rust repository and update the state of
Rust including:

  - compiler features information
  - the stable library features and their minimal Rust versions
  - library features will be stabilized in next few releases
  - unstable library features and related issue numbers on GitHub
  - the first commit and the latest commit time of library features
  - RFCs

Currently, the information is listed in the following files:

  - compiler features: [`compiler_feature.txt`](compiler_feature.txt)
  - stable library features: [`stable_library_feature.txt`](stable_library_feature.txt)
  - unstable library features: [`unstable_library_feature.txt`](unstable_library_feature.txt)
  - RFCs and corresponding feature names: [`rfc_feature_name.txt `](rfc_feature_name.txt)

These unstable features are described in [The Unstable Book](https://doc.rust-lang.org/nightly/unstable-book/).
You can also read related issues of unstable features by issue numbers with this link:
[https://github.com/rust-lang/rust/issues/\[issue number\]](https://github.com/rust-lang/rust/issues/)

Our daily [Travis CI jobs](https://travis-ci.com/mssun/state-of-rust) will
update these lists.

## License

State of Rust is distributed under the terms of both the MIT license and the Apache
License (Version 2.0).

See [LICENSE-APACHE](LICENSE-APACHE) and [LICENSE-MIT](LICENSE-MIT) for details.
