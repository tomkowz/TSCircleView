//
//  ViewController.m
//  TSCircleViewExample
//
//  Created by Tomasz Szulc Prywatny on 15/07/14.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"
#import "TSCustomCircleView.h"

@implementation ViewController {
    Annotation *_annotation;
    TSCustomCircleView *_circleView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _annotation = [[Annotation alloc] init];
    [_annotation setCoordinate: CLLocationCoordinate2DMake(0, 0)];
    [self.mapView addAnnotation:_annotation];
    [self.mapView setCenterCoordinate:_annotation.coordinate animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_annotation.coordinate, 1000, 1000);
    [self.mapView setRegion:region];
    
    [self _addCircleOnCurrentLocationWithRadius:_slider.value];
}

- (IBAction)onSliderChanged:(UISlider *)sender {
//    [_circleView pauseAnimation];
    _circleView.radius = sender.value;
    [_circleView setNeedsDisplay];
}

- (IBAction)onSliderTouchUpInside:(UISlider *)sender {
//    [_circleView resumeAnimation];
}

- (IBAction)onStartPressed:(id)sender {
    [_circleView startAnimating];
}

- (IBAction)onStopPressed:(id)sender {
    [_circleView stopAnimating];
}

- (IBAction)onPausePressed:(id)sender {
    [_circleView pauseAnimation];
}

- (IBAction)onResumePressed:(id)sender {
    [_circleView resumeAnimation];
}

- (void)_addCircleOnCurrentLocationWithRadius:(CGFloat)radius {
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:_annotation.coordinate radius:radius];
    [self.mapView addOverlay:circle level:MKOverlayLevelAboveRoads];
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
    return view;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if (!_circleView) {
        _circleView = [[TSCustomCircleView alloc] initWithCircle:overlay];
        _circleView.shouldShowBackgroundViewOnStop = YES;
    }
    return _circleView;
}

@end
