//
//  Spring.swift
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

// MARK: - Springable Protocol

@objc public protocol Springable {

    // MARK: Advanced Values

    var animation: String { get set }
    var curve: String { get set }
    var autostart: Bool { get set }
    var autohide: Bool { get set }
    var delay: CGFloat { get set }
    var duration: CGFloat { get set }
    var force: CGFloat { get set }
    var damping: CGFloat { get set }
    var velocity: CGFloat { get set }
    var rotateDegrees: CGFloat { get set }
    var repeatCount: Float { get set }

    // MARK: Basic Values

    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var scaleX: CGFloat { get set }
    var scaleY: CGFloat { get set }
    var rotate: CGFloat { get set }
    var opacity: CGFloat { get set }
    var animateFrom: Bool { get set }

    // MARK: UIView

    var layer: CALayer { get }
    var transform: CGAffineTransform { get set }
    var alpha: CGFloat { get set }

    // MARK: Methods

    func animate()
    func animateNext(completion: () -> ())
    func animateTo()
    func animateToNext(completion: () -> ())
}

// MARK: - Spring Class

public class Spring: NSObject {

    // MARK: Object Lifecycle

    private unowned var view : Springable
    private var shouldAnimateAfterActive = false

    init(_ view: Springable) {
        self.view = view
        super.init()
        commonInit()
    }

    func commonInit() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActiveNotification:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }

    func didBecomeActiveNotification(notification: NSNotification) {
        if shouldAnimateAfterActive {
            alpha = 0
            animate()
            shouldAnimateAfterActive = false
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
    }

    // MARK: - Animation Values

    // MARK: Advanced Values

    private var animation: String { set { self.view.animation = newValue } get { return self.view.animation }}
    private var curve: String { set { self.view.curve = newValue } get { return self.view.curve }}
    private var autostart: Bool { set { self.view.autostart = newValue } get { return self.view.autostart }}
    private var autohide: Bool { set { self.view.autohide = newValue } get { return self.view.autohide }}
    private var delay: CGFloat { set { self.view.delay = newValue } get { return self.view.delay }}
    private var duration: CGFloat { set { self.view.duration = newValue } get { return self.view.duration }}
    private var force: CGFloat { set { self.view.force = newValue } get { return self.view.force }}
    private var damping: CGFloat { set { self.view.damping = newValue } get { return self.view.damping }}
    private var velocity: CGFloat { set { self.view.velocity = newValue } get { return self.view.velocity }}
    private var rotateDegrees: CGFloat { set { self.view.rotateDegrees = newValue } get { return self.view.rotateDegrees }}
    private var repeatCount: Float { set { self.view.repeatCount = newValue } get { return self.view.repeatCount }}

    // MARK: Basic Values

    private var x: CGFloat { set { self.view.x = newValue } get { return self.view.x }}
    private var y: CGFloat { set { self.view.y = newValue } get { return self.view.y }}
    private var scaleX: CGFloat { set { self.view.scaleX = newValue } get { return self.view.scaleX }}
    private var scaleY: CGFloat { set { self.view.scaleY = newValue } get { return self.view.scaleY }}
    private var rotate: CGFloat { set { self.view.rotate = newValue } get { return self.view.rotate }}
    private var opacity: CGFloat { set { self.view.opacity = newValue } get { return self.view.opacity }}
    private var animateFrom: Bool { set { self.view.animateFrom = newValue } get { return self.view.animateFrom }}

    // MARK: UIView

    private var layer : CALayer { return view.layer }
    private var transform : CGAffineTransform { get { return view.transform } set { view.transform = newValue }}
    private var alpha: CGFloat { get { return view.alpha } set { view.alpha = newValue } }

    // MARK: - Animation Preset Values

    func animatePreset() {
        if animation == "" {
            return
        }

        switch animation {

            // MARK: - Sliding Animations

            // MARK: Slide Left Animation
            case "slideLeft":
                x = 300*force

            // MARK: Slide Right Animation
            case "slideRight":
                x = -300*force

            // MARK: Slide Down Animation
            case "slideDown":
                y = -300*force

            // MARK: Slide Up Animation
            case "slideUp":
                y = 300*force

            // MARK: - Squeezing Animations

            // MARK: Squeeze Left Animation
            case "squeezeLeft":
                x = 300
                scaleX = 3*force

            // MARK: Squeeze Right Animation
            case "squeezeRight":
                x = -300
                scaleX = 3*force

            // MARK: Squeeze Down Animation
            case "squeezeDown":
                y = -300
                scaleY = 3*force

            // MARK: Squeeze Up Animation
            case "squeezeUp":
                y = 300
                scaleY = 3*force
                scaleY = 2*force

            // MARK: - Zooming Animations

            // MARK: Zoom In Animation
            case "zoomIn":
                opacity = 0
                scaleX = 2*force
                scaleY = 2*force

            // MARK: Zoom Out Animation
            case "zoomOut":
                animateFrom = false
                opacity = 0
                scaleX = 2*force
                scaleY = 2*force

            // MARK: - Fading Animations

            // MARK: Fade In Animation
            case "fadeIn":
                opacity = 0

            // MARK: Fade Out Animation
            case "fadeOut":
                animateFrom = false
                opacity = 0

            // MARK: Fade In Left Animation
            case "fadeInLeft":
                opacity = 0
                x = 300*force

            // MARK: Fade In Right Animation
            case "fadeInRight":
                x = -300*force
                opacity = 0

            // MARK: Fade In Down Animation
            case "fadeInDown":
                y = -300*force
                opacity = 0

            // MARK: Fade In Up Animation
            case "fadeInUp":
                y = 300*force
                opacity = 0

            // MARK: - Falling Exit Animation
            case "fall":
                animateFrom = false
                rotate = 15 * CGFloat(M_PI/180)
                y = 600*force

            // MARK: - Advanced Animations

            // MARK: Rotating Animation
            case "rotate":
                let animation = CABasicAnimation()
                animation.keyPath = "transform.rotation"
                animation.fromValue = degreesToRadians(0)
                animation.toValue = degreesToRadians(rotateDegrees)
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "rotate")

            // MARK: Heart Beat Animation
            case "heartBeat":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.scale"
                animation.values = [-0.3, -0.3, -0.1, -0.3, 0.1, -0.3].map({$0*self.force})
                animation.keyTimes = [0, 0.2, 0.25, 0.35, 0.4, 1]
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "pulseHeart")

            // MARK: Pulse Animation
            case "pulse":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.scale"
                animation.values = [-0.2, 0, 0.2, 0, -0.2].map({$0*self.force})
                animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "pulse")

            // MARK: Shake Animation
            case "shake":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "position.x"
                animation.values = [0, 30, -30, 30, 0].map({$0*self.force})
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "shake")

            // MARK: Pop Animation
            case "pop":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.scale"
                animation.values = [0, 0.2, -0.2, 0.2, 0].map({$0*self.force})
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "pop")

            // MARK: Swing Animation
            case "swing":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.rotation"
                animation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "swing")

            // MARK: Morph Animation
            case "morph":
                let morphX = CAKeyframeAnimation()
                morphX.keyPath = "transform.scale.x"
                morphX.values = [1, 1.3*force, 0.7, 1.3*force, 1]
                morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphX.timingFunction = getTimingFunction(curve)
                morphX.duration = CFTimeInterval(duration)
                morphX.repeatCount = repeatCount
                morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(morphX, forKey: "morphX")

                let morphY = CAKeyframeAnimation()
                morphY.keyPath = "transform.scale.y"
                morphY.values = [1, 0.7, 1.3*force, 0.7, 1]
                morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphY.timingFunction = getTimingFunction(curve)
                morphY.duration = CFTimeInterval(duration)
                morphY.repeatCount = repeatCount
                morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(morphY, forKey: "morphY")

            // MARK: Squeeze Animation
            case "squeeze":
                let morphX = CAKeyframeAnimation()
                morphX.keyPath = "transform.scale.x"
                morphX.values = [1, 1.5*force, 0.5, 1.5*force, 1]
                morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphX.timingFunction = getTimingFunction(curve)
                morphX.duration = CFTimeInterval(duration)
                morphX.repeatCount = repeatCount
                morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(morphX, forKey: "morphX")

                let morphY = CAKeyframeAnimation()
                morphY.keyPath = "transform.scale.y"
                morphY.values = [1, 0.5, 1, 0.5, 1]
                morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphY.timingFunction = getTimingFunction(curve)
                morphY.duration = CFTimeInterval(duration)
                morphY.repeatCount = repeatCount
                morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(morphY, forKey: "morphY")

            // MARK: Wobble Animation
            case "wobble":
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.rotation"
                animation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.duration = CFTimeInterval(duration)
                animation.additive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "wobble")

                let x = CAKeyframeAnimation()
                x.keyPath = "position.x"
                x.values = [0, 30*force, -30*force, 30*force, 0]
                x.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                x.timingFunction = getTimingFunction(curve)
                x.duration = CFTimeInterval(duration)
                x.additive = true
                x.repeatCount = repeatCount
                x.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(x, forKey: "x")

            // MARK: Flash Animation
            case "flash":
                let animation = CABasicAnimation()
                animation.keyPath = "opacity"
                animation.fromValue = 1
                animation.toValue = 0
                animation.duration = CFTimeInterval(duration)
                animation.repeatCount = repeatCount * 2.0
                animation.autoreverses = true
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "flash")

            // MARK: Flip X Animation
            case "flipX":
                var perspective = CATransform3DIdentity
                perspective.m34 = -1.0 / layer.frame.size.width / 2

                let animation = CABasicAnimation()
                animation.keyPath = "transform"
                animation.fromValue = NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 0))
                animation.toValue = NSValue(CATransform3D: CATransform3DConcat(perspective, CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)))
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "3d")

            // MARK: Flip Y Animation
            case "flipY":
                var perspective = CATransform3DIdentity
                perspective.m34 = -1.0 / layer.frame.size.width/2

                let animation = CABasicAnimation()
                animation.keyPath = "transform"
                animation.fromValue = NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 0))
                animation.toValue = NSValue(CATransform3D: CATransform3DConcat(perspective, CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0)))
                animation.timingFunction = getTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.addAnimation(animation, forKey: "3d")

            default:
                x = 300
        }
    }

    // MARK: - Timing and Animation Methods

    func getTimingFunction(curve: String) -> CAMediaTimingFunction {
        switch curve {
            case "easeIn":
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case "easeOut":
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case "easeInOut":
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case "linear":
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case "spring":
                return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + Float(force / 3), 1, 1)
            default:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        }
    }

    func getAnimationOptions(curve: String) -> UIViewAnimationOptions {
        switch curve {
            case "easeIn":
                return .CurveEaseIn
            case "easeOut":
                return .CurveEaseOut
            case "easeInOut":
                return .CurveEaseInOut
            case "linear":
                return .CurveLinear
            case "spring":
                return .CurveLinear
            default:
                return .CurveLinear
        }
    }

    // MARK: - Animation Methods

    public func animate() {
        animateFrom = true
        animatePreset()
        setView {}
    }

    public func animateNext(completion: () -> ()) {
        animateFrom = true
        animatePreset()
        setView {
            completion()
        }
    }

    public func animateTo() {
        animateFrom = false
        animatePreset()
        setView {}
    }

    public func animateToNext(completion: () -> ()) {
        animateFrom = false
        animatePreset()
        setView {
            completion()
        }
    }

    // MARK: - Set the View

    func setView(completion: () -> ()) {
        if animateFrom {
            let translate = CGAffineTransformMakeTranslation(self.x, self.y)
            let scale = CGAffineTransformMakeScale(self.scaleX, self.scaleY)
            let rotate = CGAffineTransformMakeRotation(self.rotate)
            let translateAndScale = CGAffineTransformConcat(translate, scale)
            self.transform = CGAffineTransformConcat(rotate, translateAndScale)
            self.alpha = self.opacity
        }

        UIView.animateWithDuration(NSTimeInterval(duration),
            delay: NSTimeInterval(delay),
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            options: getAnimationOptions(curve),
            animations: {[weak self] in
                if let _self = self {
                    if _self.animateFrom {
                        _self.transform = CGAffineTransformIdentity
                        _self.alpha = 1
                    } else {
                        let translate = CGAffineTransformMakeTranslation(_self.x, _self.y)
                        let scale = CGAffineTransformMakeScale(_self.scaleX, _self.scaleY)
                        let rotate = CGAffineTransformMakeRotation(_self.rotate)
                        let translateAndScale = CGAffineTransformConcat(translate, scale)
                        _self.transform = CGAffineTransformConcat(rotate, translateAndScale)
                        _self.alpha = _self.opacity
                    }
                }
            }, {[weak self] finished in
                completion()
                self?.resetAll()
            }
        )
    }

    // MARK: - Custom Initializer Methods

    public func customAwakeFromNib() {
        if autohide {
            alpha = 0
        }
    }

    public func customDidMoveToWindow() {
        if autostart {
            if UIApplication.sharedApplication().applicationState != .Active {
                shouldAnimateAfterActive = true
                return
            }
            alpha = 0
            animate()
        }
    }

    // MARK: Reset Values to Default

    func resetAll() {

        // Advanced Values

        animation = ""
        curve = ""
        autostart = false
        autohide = false
        delay = 0
        duration = 0.7
        force = 1
        damping = 0.7
        velocity = 0.7
        rotateDegrees = 0
        repeatCount = 1

        // Basic Values

        x = 0
        y = 0
        scaleX = 1
        scaleY = 1
        rotate = 0
        opacity = 1
    }
}