# Change Log
All notable changes to this project will be documented in this file.
`CITPincode` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases
- `1.2.x` Releases - [1.2.0](#120) | [1.2.1](#121) | [1.2.2](#122) | [1.2.3](#123) | [1.2.4](#124) | [1.2.5](#125) | [1.2.6](#126) | [1.2.7](#127) | [1.2.8](#128)
- `1.1.x` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.0](#100)

#### 1.2.8

- Add ability to align all elements at once instead of just the resendButton.
- Add ability to set vertical spacing between elements (pincode cells -> resendButton -> errorLabel)
- Add option to make pincode cells all have red borders and keep numbers in input on error (this will become the default behavior in a future version)
- Add smaller default font for error label.
- Add Commons Clause to MIT license, read LICENSE file for specific details.

#### 1.2.7

- Updated README to new standard.

#### 1.2.6

- Fix releases hotlinks by removing `anchor-` prefix.

#### 1.2.5

- Add row of 4 gifs to the README.

#### 1.2.4

- Update license in every file header to mention MIT License with full description.

#### 1.2.3

- Adjust readme to be more accurate.

#### 1.2.2

- Resolve Aroma team feedback on example code.
- Update README to match latest example and usage of CITPincode.

#### 1.2.1

- Make the example project Xcode 13 stable release compatible.

#### 1.2.0

- Add an example app built-in to the CITPincode package.
- Code improvements by the Aroma team.
- Limit the width of pincode cells so the PincodeView does not exceed screen width.
- Dropped support for iOS 13 to resolve SwiftUIX dependency for backwards compatible use of `onChange(of:)`.
- Vastly improve README and code documentation.

#### 1.1.0

- Limit codeInputField interaction to paste only.
- Refactor away Introspect dependency.
- Remove unused documentation catalog and tests.
- Restructure folders.
- Localize and expose texts.
- Clean up code.

#### 1.0.0

- Setup CITPincodeView, add customization & documentation.
