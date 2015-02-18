//
//  SpringAnimation.swift
//  https://github.com/MengTo/Spring
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Meng To (meng@designcode.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

// MARK: Basic Animation with Duration

public func spring(duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: nil,
        animations: animations,
        completion: nil
    )
}

// MARK: Basic Animation with Delay

public func springWithDelay(duration: NSTimeInterval, delay: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: delay,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: nil,
        animations: animations,
        completion: nil
    )
}

// MARK: Basic Animation with Completion Handle

public func springWithCompletion(duration: NSTimeInterval, animations: (() -> Void)!, completion: ((Bool) -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: nil,
        animations: animations,
        completion: { finished in completion(true) }
    )
}

// MARK: Basic Animation with Linear Timing

public func springLinear(duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        options: .CurveLinear,
        animations: animations,
        completion: nil
    )
}

// MARK: Basic Animation with Ease-In Timing

public func springEaseIn(duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        options: .CurveEaseIn,
        animations: animations,
        completion: nil
    )
}

// MARK: Basic Animation with Ease-Out Timing

public func springEaseOut(duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        options: .CurveEaseOut,
        animations: animations,
        completion: nil
    )
}

// MARK: Basic Animation with Ease-In-Out Timing

public func springEaseInOut(duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(
        duration,
        delay: 0,
        options: .CurveEaseInOut,
        animations: animations,
        completion: nil
    )
}