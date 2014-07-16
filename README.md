TSCircleView
============

It's a subclass of *MKCircleView* which supports scaling and animating.

See demo [tscircleview.gif](https://raw.githubusercontent.com/tomkowz/TSCircleView/master/tscircleview.gif).


There is no easy way to use system *MKCircle* and draw it inside *MKCircleView* and have ability to change its radius or to animate this view. If you want to do so only one way is to make subclass of *MKCircleView* and override `- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)ctx` method.

The subclass gives the ability to create animatable and resizable circle on map which respects zooming on map. You can change radius and you can start, stop, pause, and resume animation of this view, so... its more powerful than system's one.

API
=======
The API is simple

`radius` property allows to set radius of a circle. After setting this you're responsible to call `setNeedsDisplay` on this view because calling this is a costly operation and it's doin on main thread consider to calculate and cache your background view if possible.

`shouldShowBackgroundViewOnStop` specifies if `backgroundView` should be visible when view is not animating. Default is set to NO.

### Subclassing

You should consider subclassing if you want to:
- change animation or animation properties
- change background view

Class is oriented to caching as much as possible so `animation` and `backgroundView` properties are readonly. I added `TSCustomCircleView` to example project to shouw you how subclassing is easy.

### Animations
The last thing is animation. There are methods like `stopAnimation`, `startAnimation`, `pauseAnimation` and `resumeAnimation`. These methods are modifying properties `animating` and `paused`.

Following checks are supported by class:
- If animation is not started or stopped you can start it, but not pause or resume
- If animation is started you can stop it or pause, but not resume
- If animation is paused you can resume, pause or start it again
