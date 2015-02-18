## Custom Fork
This is a lightweight version of Meng To's [Spring](https://github.com/MengTo/Spring) animation library with just the necessary files for animations and easy drop-in for any Swift project.

![](http://cl.ly/image/3a1r1d3l3D1j/spring-logo.jpg)

## Installation
Drop in the `Spring` folder to your Xcode project.

## Usage with Storyboard
In Identity Inspector, connect the UIView to SpringView Class and set the animation properties in Attribute Inspector.

![](http://cl.ly/image/241o0G1G3S36/download/springsetup.jpg)

## Usage with Code
    layer.animation = "squeezeDown"
    layer.animate()

## Chaining Animations
    layer.y = -50
    animateToNext {
      layer.animation = "fall"
      layer.animateTo()
    }

## Functions
    animate()
    animateNext { ... }
    animateTo()
    animateToNext { ... }

## Animations
    slideLeft
    slideRight
    slideDown
    slideUp
    squeezeLeft
    squeezeRight
    squeezeDown
    squeezeUp
    zoomIn
    zoomOut
    fadeIn
    fadeOut
    fadeInLeft
    fadeInRight
    fadeInDown
    fadeInUp
    fall
    rotate
    heartBeat
    pulse
    shake
    pop
    swing
    morph
    squeeze
    wobble
    flash
    flipX
    flipY

## Curves
    spring
    linear 
    easeIn 
    easeOut 
    easeInOut

## Properties
    animation
    curve
    autostart
    autohide
    delay
    duration
    force
    damping
    velocity
    rotateDegrees
    repeatCount
    x
    y
    scaleX
    scaleY
    rotate

\* Not all properties work together. Play with the demo app.

## Autostart
Allows you to animate without code. Don't need to use this is if you plan to start the animation in code.

## Autohide
Saves you the hassle of adding a line "layer.alpha = 0" in viewDidLoad().

## Known issue
Animations won't autostart when view is reached via performSegueWithIdentifier.

Animations using IBInspectables are currently not working in iOS 7. iOS 8 is supported. We're looking for a fix. Animations in code works for both iOS 7 and 8.

## Tutorials
- Tutorials available on [Design+Code](https://designcode.io/swiftapp).
- [Integrate Spring to existing Objective-C projects](https://medium.com/ios-apprentice/using-swift-in-objective-c-projects-f7e7a09f8be)

## ChangeLog
- At [ChangeLog](https://github.com/MengTo/Spring/wiki/CHANGELOG) wiki page

## License

Spring is released under the MIT license. See LICENSE for details.

