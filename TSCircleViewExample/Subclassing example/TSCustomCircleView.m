//
//  TSCustomCircleView.m
//  TSCircleView
//
//  Created by Tomasz Szulc  on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSCustomCircleView.h"
#import "CircleView.h"

@implementation TSCustomCircleView

@synthesize backgroundView = _backgroundView;
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[CircleView alloc] initWithFrame:self.bounds];
    }
    return _backgroundView;
}

@end
