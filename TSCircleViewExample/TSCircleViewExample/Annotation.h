//
//  Annotation.h
//  MKMapViewCircleScalingTest
//
//  Created by Tomasz Szulc Prywatny on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Annotation : NSObject <MKAnnotation>
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@end
