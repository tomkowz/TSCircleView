//
//  CircleView.m
//  MKMapViewCircleScalingTest
//
//  Created by Tomasz Szulc  on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 5);
    
    CGRect insetRect = CGRectInset(self.bounds, 5, 5);
    insetRect.origin = CGPointMake(5, 5);
    
    CGContextFillEllipseInRect(context, insetRect);
    CGContextStrokeEllipseInRect(context, insetRect);
}


@end
