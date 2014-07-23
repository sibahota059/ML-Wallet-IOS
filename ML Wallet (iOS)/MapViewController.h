//
//  MapViewController.h
//  ML Wallet
//
//  Created by ml on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
@interface MapViewController : UIViewController<GMSMapViewDelegate, CLLocationManagerDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSArray *arrayOfPoints;
@property(nonatomic,retain) CLLocationManager *locationManager;
@end
