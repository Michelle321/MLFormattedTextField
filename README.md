# MLFormattedTextField

UITextField subclass that allows number or letter input in a predefined format using swift. Used for phone numbers, creditcard and social insurance number or healthcard number with both letters and numbers . 

[![CI Status](http://img.shields.io/travis/Michelle/MLFormattedTextField.svg?style=flat)](https://travis-ci.org/Michelle/MLFormattedTextField)
[![Version](https://img.shields.io/cocoapods/v/MLFormattedTextField.svg?style=flat)](http://cocoapods.org/pods/MLFormattedTextField)
[![License](https://img.shields.io/cocoapods/l/MLFormattedTextField.svg?style=flat)](http://cocoapods.org/pods/MLFormattedTextField)
[![Platform](https://img.shields.io/cocoapods/p/MLFormattedTextField.svg?style=flat)](http://cocoapods.org/pods/MLFormattedTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To use in storyboard, change your UITextField to MLFormattedTextField

when you predefine the numbers, using "X", predefine letters, using "L".
eg. (416)  332-3333, it should be like (XXX) XXX-XXXX
eg. 2323-3234-4355F, it should be like XXXX-XXXX-XXXX-XXXXL

## Requirements

## Installation

MLFormattedTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MLFormattedTextField'
```

## Author

Michelle, yunjuan.li@gmail.com, thanks to Roman Efimov  https://github.com/romaonthego https://twitter.com/romaonthego romefimov@gmail.com for his original objective C REFormattedNumberField idea

## License

MLFormattedTextField is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2017 Michelle <yunjuan.li@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
