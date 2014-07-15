//
//  ViewController.h
//  TSCircleViewExample
//
//  Created by Tomasz Szulc Prywatny on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)onSliderChanged:(UISlider *)sender;
- (IBAction)onSliderTouchUpInside:(UISlider *)sender;

- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
- (IBAction)onPausePressed:(id)sender;
- (IBAction)onResumePressed:(id)sender;
@end
