//
//  TSCircleView.h
//
//  Created by Tomasz Szulc  on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//  http://github.com/tomkowz/TSCircleView
//

#import <MapKit/MapKit.h>

@interface TSCircleView : MKCircleView

/**
 Specifies radius of circle view. First value is equal a radius of circle pass in `initWithCircle:` method.
 */
@property (nonatomic, assign) CLLocationDistance radius;

/**
 Spciefies coordinate of circle view.
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/**
 Specifies if `backgroundView` should be visible when animation is stopped. Default to NO.
 */
@property (nonatomic, assign) BOOL shouldShowBackgroundViewOnStop;

/**
 Specifies if view is animating.
 */
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;

/**
 Specifies if view is paused.
 */
@property (nonatomic, readonly, getter = isPaused) BOOL paused;

/**
 A background view. Use to subclass.
 */
@property (nonatomic, strong, readonly) UIView *backgroundView;

/**
 Subclass to use non-default animation. Default is changing opacity and scale.
 */
@property (nonatomic, strong, readonly) id animation;

/**
 Starts animating
 */
- (void)startAnimating;

/**
 Stops animating
 */
- (void)stopAnimating;

/**
 Pause animation
 */
- (void)pauseAnimation;

/**
 Resume animation
 */
- (void)resumeAnimation;

@end
