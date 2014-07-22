//
//  MapViewController.m
//  ML Wallet
//
//  Created by ml on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MapViewController.h"



@interface MapViewController ()<GMSMapViewDelegate>
@property (nonatomic, strong) NSMutableData *responseData;
@end


@implementation MapViewController
{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
    NSMutableArray *dataArray;
    NSMutableArray *gmLat;
    NSMutableArray *gmLong;
    NSMutableArray *place;
    NSMutableArray *town;
    NSArray *steps;
    GMSCircle *circ;
    MBProgressHUD *HUD;
    GMSMarker *marker;
    NSSet *markers;
    NSURLSession *markerSession;
    GMSPolyline *polyline;
    UIButton *directionsButton;
    }



@synthesize responseData = _responseData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self navigationView];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    NSLog(@"viewdidload");
    
    
    
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"https://192.168.12.204:4443/Mobile/Client/MapService/MapService.svc/getCoordinates/"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:16];
    
   mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
   // mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;
    mapView_.delegate = self;

    //  self.view = mapView_;
    
    
    [self.view insertSubview:mapView_ atIndex:0];
    
  
    

    
    
    
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
     //   mapView_.myLocationEnabled = YES;

          CLLocation *myLocation = mapView_.myLocation;
          NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    });
      // actualZoom = mapView_.camera.zoom;
    
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    config.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
                                                    diskCapacity:10 * 1024 * 1024
                                                        diskPath:@"MarkerData"];
    markerSession = [NSURLSession sessionWithConfiguration:config];
    
    
    directionsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    directionsButton.alpha = 0.0;
    
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)infoWindowmarker {
    NSString *ahw = infoWindowmarker.snippet;
    NSLog(@"Marker Info Window Tap Branch Name : %@", ahw);

    
    
    
}
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)bmarker{
   [mapView_ setSelectedMarker:bmarker];
    CLLocation *myLocation = mapView_.myLocation;
    NSLog(@"Location ni Naku ! %f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    
     GMSMutablePath *path = [GMSMutablePath path];
     [path addLatitude:myLocation.coordinate.latitude longitude:myLocation.coordinate.longitude];
     [path addLatitude:bmarker.position.latitude longitude:bmarker.position.longitude];
     /*
     
     GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
     polyline.strokeColor = [UIColor blueColor];
     polyline.strokeWidth = 5.f;
     polyline.map = mapView_;
    */
    


    if(myLocation!=nil){
     
        NSLog(@"Dili null");
        
        
        NSString *urlString =
        [NSString stringWithFormat:@"%@?origin=%f,%f&destination=%f,%f&sensor=true&key=%@",
         @"https://maps.googleapis.com/maps/api/directions/json",
         myLocation.coordinate.latitude,
         myLocation.coordinate.longitude,
         bmarker.position.latitude,
         bmarker.position.longitude,
         @"AIzaSyDNYjJnFbOBJWmJMaXwLvX8Um4jk3p1F1A"];
        
        NSURL *directionsURL = [NSURL URLWithString:urlString];
        NSURLSessionDataTask *directionsTask = [markerSession dataTaskWithURL:directionsURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *e){
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization
                            JSONObjectWithData: data
                            options: NSJSONReadingMutableContainers
                            error: &error];
                                                                
            if(!error) {
                steps = json[@"routes"][0][@"legs"][0][@"steps"];
                                                                    
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            directionsButton.alpha = 1.0;
                            }];
            GMSPath *path =
            [GMSPath pathFromEncodedPath:
            json[@"routes"][0][@"overview_polyline"][@"points"]];
            polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeWidth = 10;
            polyline.strokeColor = [UIColor greenColor];
            polyline.map = mapView_;

            }
                                                                
        }];
         

        
        
    }
    return YES;
}


- (void)directionsTapped:(id)sender {

                    // steps = nil;
                    //    mapView_.selectedMarker = nil;
                     
    }



- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        firstLocationUpdate_ = YES;
        CLLocation *myLocation = mapView_.myLocation;
        
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:16];
        circ = [GMSCircle circleWithPosition:location.coordinate radius:100];
        //circ.fillColor = [UIColor whiteColor];
        circ.strokeColor = [UIColor redColor];
        circ.strokeWidth = 0.8;
       // circ.map = mapView_;
        GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
        [mapView_ animateWithCameraUpdate:upwards];
        NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    }
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma Start #Navigation Items
- (void)navigationView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"MY LOCATION";
    
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoHome)];
    //go to current user location button
    UIBarButtonItem *btnMyLocation = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"username.png"]
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoBranch)];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    self.navigationItem.rightBarButtonItem = btnMyLocation;
    
    //Set Background
    if ([UIScreen mainScreen].bounds.size.height >= 568) //4 inch 568
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
    }
    else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground3.png"]]];
    }
}


#pragma Start goto Home View
- (void)gotoHome
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
/*
- (void)gotoMyLocation
{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        mapView_.myLocationEnabled = YES;
        CLLocation *myLocation = mapView_.myLocation;
        NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
        mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:16];
       
    });
}
 */
//select radius alertView
-(void)gotoBranch{

    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Select Radius."
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"500", @"1000",@"1500",@"2000",@"All", nil];
 
    [message show];

}

//select radius button click
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"500"])
    {
        [mapView_ clear];
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            circ.map = nil;
            mapView_.myLocationEnabled = YES;
            CLLocation *myLocation = mapView_.myLocation;
            NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:500];
            //circ.fillColor = [UIColor whiteColor];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 2;
            circ.map = mapView_;
            mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                             zoom:15.5];
            GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
            [mapView_ animateWithCameraUpdate:upwards];
            
            
            
            NSLog(@"500 Radius was selected.");
            NSUInteger count = [gmLat count];
            for(NSUInteger i = 0;i < count; i++){
                NSString *strlongitude;
                NSString *strlatitude;
                NSString *strplace;
                strlongitude = [gmLong objectAtIndex:i];
                strlatitude = [gmLat objectAtIndex:i];
                strplace =[place objectAtIndex:i];
                
                // NSLog(@"Latitude : %@", place);
                double longdouble = [strlongitude doubleValue];
                double latdouble = [strlatitude doubleValue];
                
                CLLocation *locA = [[CLLocation alloc] initWithLatitude:latdouble longitude:longdouble];
                
                
                int distance = [myLocation distanceFromLocation:locA];
                if(distance < 500)
                {
                    
                    
                    marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                    marker.snippet = strplace;
                    marker.map = mapView_;
                    marker.icon = [UIImage imageNamed:@"ml_1"];
                    
                }
                
                
            }
            
            
            
            
            [HUD hide:YES];
            [HUD show:NO];
            
            
            
        });
        

    }
    else if([title isEqualToString:@"1000"])
    {
        [mapView_ clear];
        
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            circ.map = nil;
            mapView_.myLocationEnabled = YES;
            CLLocation *myLocation = mapView_.myLocation;
            NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:1000];
            //circ.fillColor = [UIColor whiteColor];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 2;
            circ.map = mapView_;
            mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                             zoom:14.5];
            GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
            [mapView_ animateWithCameraUpdate:upwards];
            
            
            
            NSLog(@"1000 Radius was selected.");
            NSUInteger count = [gmLat count];
            for(NSUInteger i = 0;i < count; i++){
                NSString *strlongitude;
                NSString *strlatitude;
                NSString *strplace;
                strlongitude = [gmLong objectAtIndex:i];
                strlatitude = [gmLat objectAtIndex:i];
                strplace =[place objectAtIndex:i];
                
                // NSLog(@"Latitude : %@", place);
                double longdouble = [strlongitude doubleValue];
                double latdouble = [strlatitude doubleValue];
                
                CLLocation *locA = [[CLLocation alloc] initWithLatitude:latdouble longitude:longdouble];
                
                
                int distance = [myLocation distanceFromLocation:locA];
                if(distance < 1000)
                {
                    
                    
                    marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                    marker.snippet = strplace;
                    marker.map = mapView_;
                    marker.icon = [UIImage imageNamed:@"ml_1"];
                    
                }
                
                
            }
            
            
            
            
            [HUD hide:YES];
            [HUD show:NO];
            
            
            
        });
        

    }
    else if([title isEqualToString:@"1500"])
    {
        [mapView_ clear];
        
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            circ.map = nil;
            mapView_.myLocationEnabled = YES;
            CLLocation *myLocation = mapView_.myLocation;
            NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:1500];
            //circ.fillColor = [UIColor whiteColor];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 2;
            circ.map = mapView_;
            mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                             zoom:13.9];
            GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
            [mapView_ animateWithCameraUpdate:upwards];
            
            
            
            NSLog(@"1500 Radius was selected.");
            NSUInteger count = [gmLat count];
            for(NSUInteger i = 0;i < count; i++){
                NSString *strlongitude;
                NSString *strlatitude;
                NSString *strplace;
                strlongitude = [gmLong objectAtIndex:i];
                strlatitude = [gmLat objectAtIndex:i];
                strplace =[place objectAtIndex:i];
                
                // NSLog(@"Latitude : %@", place);
                double longdouble = [strlongitude doubleValue];
                double latdouble = [strlatitude doubleValue];
                
                CLLocation *locA = [[CLLocation alloc] initWithLatitude:latdouble longitude:longdouble];
                
                
                int distance = [myLocation distanceFromLocation:locA];
                if(distance < 1500)
                {
                    
                    
                    marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                    marker.snippet = strplace;
                    marker.map = mapView_;
                    marker.icon = [UIImage imageNamed:@"ml_1"];
                    
                }
                
                
            }
            
            
            
            
            [HUD hide:YES];
            [HUD show:NO];
            
            
            
        });
        

    }
    else if([title isEqualToString:@"2000"])
    {
        [mapView_ clear];
        
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            circ.map = nil;
            mapView_.myLocationEnabled = YES;
            CLLocation *myLocation = mapView_.myLocation;
            NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:2000];
            //circ.fillColor = [UIColor whiteColor];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 2;
            circ.map = mapView_;
            mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                             zoom:13.3];
            GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
            [mapView_ animateWithCameraUpdate:upwards];
            
            
            
            NSLog(@"2000 Radius was selected.");
            NSUInteger count = [gmLat count];
            for(NSUInteger i = 0;i < count; i++){
                NSString *strlongitude;
                NSString *strlatitude;
                NSString *strplace;
                strlongitude = [gmLong objectAtIndex:i];
                strlatitude = [gmLat objectAtIndex:i];
                strplace =[place objectAtIndex:i];
                
                // NSLog(@"Latitude : %@", place);
                double longdouble = [strlongitude doubleValue];
                double latdouble = [strlatitude doubleValue];
                
                CLLocation *locA = [[CLLocation alloc] initWithLatitude:latdouble longitude:longdouble];
                
                
                int distance = [myLocation distanceFromLocation:locA];
                if(distance < 2000)
                {
                    
                    
                    marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                    marker.snippet = strplace;
                    marker.map = mapView_;
                    marker.icon = [UIImage imageNamed:@"ml_1"];
                    
                }
                
                
            }
            
            
            
            
            [HUD hide:YES];
            [HUD show:NO];
            
            
            
        });
        


    }
    else if([title isEqualToString:@"All"]){
        [mapView_ clear];
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            circ.map = nil;
            mapView_.myLocationEnabled = YES;
            CLLocation *myLocation = mapView_.myLocation;
            NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                             zoom:15];
            GMSCameraUpdate *upwards = [GMSCameraUpdate scrollByX:0 Y:50 ];
            [mapView_ animateWithCameraUpdate:upwards];
            circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:100];
            //circ.fillColor = [UIColor whiteColor];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 0.8;
          //  circ.map = mapView_;
            
            
            NSLog(@"Button All was selected.");
            NSUInteger count = [gmLat count];
            for(NSUInteger i = 0;i < count; i++){
                NSString *strlongitude;
                NSString *strlatitude;
                NSString *strplace;
                strlongitude = [gmLong objectAtIndex:i];
                strlatitude = [gmLat objectAtIndex:i];
                strplace =[place objectAtIndex:i];
          
                // NSLog(@"Latitude : %@", place);
                double longdouble = [strlongitude doubleValue];
                double latdouble = [strlatitude doubleValue];
                
                marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                marker.snippet = strplace;
                marker.map = mapView_;
                marker.icon = [UIImage imageNamed:@"ml_1"];
                
            
            }

            
            
            
            [HUD hide:YES];
            [HUD show:NO];
          
            
            
        });
        

    }
    else if([title isEqualToString:@"Cancel"])
    {
       // [mapView_ clear];
        NSLog(@"Button Cancel was selected.");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSArray * trustedHosts = @[@"https://192.168.12.204:4443/Mobile/Client/MapService/MapService.svc/getCoordinates/"];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}





- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
   // NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

   // dataArray = [[NSMutableArray alloc] init];
    //creating branch markers
    
    gmLat = [[NSMutableArray alloc] init];
    gmLong = [[NSMutableArray alloc] init];
    place = [[NSMutableArray alloc] init];
    for(id key in res) {
        NSDictionary *resultCoordinates = [res objectForKey:key];
        NSArray *resultList = [resultCoordinates objectForKey:@"mapInfo"];
        
        for (NSDictionary *result in resultList) {
            NSString *bName = [result objectForKey:@"bName"];
           // NSLog(@"Branch Name : %@", bName);
            NSString *mLat = [result objectForKey:@"mLat"];
            //NSLog(@"Latitude : %@", bName);
            NSString *mLong = [result objectForKey:@"mLong"];
          //  NSLog(@"Longitude : %@", mLong);
            
            
          //  gmLat = [[NSArray alloc]initWithObjects:mLat, nil];
          //  gmLat = [[NSArray alloc]initWithObjects:mLat, nil];
          //  gmLong = [[NSArray alloc]initWithObjects:mLong, nil];
          //  place = [[NSArray alloc]initWithObjects:bName, nil];
            NSUInteger count = [res count];
            for(NSUInteger i=0;i < count; i++){
                [gmLat insertObject:mLat atIndex:i];
                [gmLong insertObject:mLong atIndex:i];
                [place insertObject:bName atIndex:i];
            }
            
            
            //town = [[NSArray alloc]initWithObjects:@"Minglanilla",@"Naga",@"Minglanilla",@"Minglanilla", nil];

            
            //Convert to double
            double latdouble = [mLat doubleValue];
            double londouble = [mLong doubleValue];
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latdouble,londouble );
          //  marker.title = bName;
            marker.snippet = bName;
            marker.icon = [UIImage imageNamed:@"ml_1"];
            markers =[NSSet setWithObjects:marker, nil];
            marker.map = mapView_;
            
            
            
        }
        
        
    }
    
    
    [HUD hide:YES];
    [HUD show:NO];
    
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
//mylocationbutton gmap
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    NSInteger bar = (int)screenHeight;
    NSString *inStr = [NSString stringWithFormat: @"%d", (int)bar];
    NSLog(@"Skrin Hayt : %@", inStr);
    if(bar<=490){
        mapView_.padding =
        UIEdgeInsetsMake(self.topLayoutGuide.length + 100,
                         0,
                         self.bottomLayoutGuide.length + (bar*.4),
                         0);
    }
    else {
        mapView_.padding =
        UIEdgeInsetsMake(self.topLayoutGuide.length + 100,
                         0,
                         self.bottomLayoutGuide.length + 100,
                         0);
        
    }
    
}

@end
