//
//  TSCircleView.m
//
//  Created by Tomasz Szulc  on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//  http://github.com/tomkowz/TSCircleView
//

#import "TSCircleView.h"

@implementation TSCircleView

- (id)initWithCircle:(MKCircle *)circle {
    self = [super initWithCircle:circle];
    if (self) {
        _radius = circle.radius;
        _animating = NO;
        _paused = NO;
        _coordinate = circle.coordinate;
        
        self.shouldShowBackgroundViewOnStop = NO;
        [self addSubview:self.backgroundView];
    }
    return self;
}

- (void)startAnimating {
    if (self.isAnimating) {
        return;
    }
    
    [self _removeAnimation];
    [self.backgroundView setHidden:NO];
    [self.backgroundView.layer addAnimation:self.animation forKey:@"animation"];
    _animating = YES;
    _paused = NO;
}

- (void)stopAnimating {
    _animating = NO;
    _paused = NO;
    [self _removeAnimation];
    [self.backgroundView setHidden:!self.shouldShowBackgroundViewOnStop];
}

- (void)pauseAnimation {
    if (!self.isAnimating || self.isPaused) {
        return;
    }
    
    _animating = NO;
    _paused = YES;
    CFTimeInterval pausedTime = [self.backgroundView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.backgroundView.layer.speed = 0.0;
    self.backgroundView.layer.timeOffset = pausedTime;
}

- (void)resumeAnimation {
    if (!self.isPaused) {
        return;
    }
    
    _animating = YES;
    _paused = NO;
    CFTimeInterval pausedTime = [self.backgroundView.layer timeOffset];
    [self _resetLayer];
    CFTimeInterval timeSincePause = [self.backgroundView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.backgroundView.layer.beginTime = timeSincePause;
}

- (void)_removeAnimation {
    [self _resetLayer];
    [self.backgroundView.layer removeAllAnimations];
}

- (void)_resetLayer {
    self.backgroundView.layer.speed = 1.0;
    self.backgroundView.layer.timeOffset = 0.0;
    self.backgroundView.layer.beginTime = 0.0;
}

- (void)setShouldShowBackgroundViewOnStop:(BOOL)shouldShowBackgroundViewOnStop {
    _shouldShowBackgroundViewOnStop = shouldShowBackgroundViewOnStop;
    [self.backgroundView setHidden:!_shouldShowBackgroundViewOnStop];
}

@synthesize animation = _animation;
- (id)animation {
    if (!_animation) {
        static CGFloat const duration = 0.8;
        static CGFloat const repeatCount = HUGE_VALF;
        
        /// animate opacity
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.duration = duration;
        opacityAnimation.repeatCount = repeatCount;
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.025];

        /// animate resizing
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        transformAnimation.duration = duration;
        transformAnimation.repeatCount = repeatCount;
        transformAnimation.fromValue = [NSNumber numberWithFloat:0.6];
        transformAnimation.toValue = [NSNumber numberWithFloat:1.1];
        
        /// group them
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        [group setAnimations:@[opacityAnimation, transformAnimation]];
        group.duration = duration;
        group.repeatCount = repeatCount;
        
        _animation = group;
    }
    
    return _animation;
}

@synthesize backgroundView = _backgroundView;
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
    }
    return _backgroundView;
}

#pragma mark - Drawing
- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)ctx {
    MKMapPoint circleCenter = MKMapPointForCoordinate(self.coordinate);
    
    double radius = self.radius;
    double mapRadius = radius * MKMapPointsPerMeterAtLatitude(self.coordinate.latitude);
    
    /// calculate rect on map
    MKMapRect recalculatedRect = MKMapRectMake(circleCenter.x - mapRadius, circleCenter.y - mapRadius, mapRadius * 2, mapRadius * 2);
    
    /// calculate normal rect
    CGRect rect = [self rectForMapRect:recalculatedRect];
    
    @synchronized(self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.backgroundView) {
                /// call setNeedsDisplay only when rect of backgroundView is changing from CGRectZero to different
                BOOL shouldCallNeedsDisplay = NO;
                if (CGRectEqualToRect(self.backgroundView.frame, CGRectZero)) {
                    shouldCallNeedsDisplay = YES;
                }
                self.backgroundView.frame = rect;
                if (shouldCallNeedsDisplay) {
                        [self.backgroundView setNeedsDisplay];
                }
            }
        });

    }
}

@end
