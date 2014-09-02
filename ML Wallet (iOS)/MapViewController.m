//
//  MapViewController.m
//  ML Wallet
//
//  Created by ml on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MapViewController.h"
#import "ServiceConnection.h"
#import "UIAlertView+alertMe.h"



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
    GMSPolyline *polyline;
    NSString *addressBranch;
    NSString *myLocName;
    NSString *distancetoBranch;
    NSString *timetraveledtoBranch;
    NSUInteger circleRad;
    UIAlertView *message;
}

@synthesize responseData = _responseData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationView];
    NSLog(@"viewdidload");
    [self getBranchMarkers:0];
    
    //Display MAP
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:16];
    
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.delegate = self;
    self.view = mapView_;
    
    //[self.view insertSubview:mapView_ atIndex:0];
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CLLocation *myLocation = mapView_.myLocation;
        NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    });
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [self dismiss:message];
    NSLog(@"View did disappear");

}


-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

//message

#pragma mark - Map Delegate
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)infoWindowmarker {
    NSString *ahw = infoWindowmarker.snippet;
    NSLog(@"Marker Info Window Tap Branch Name : %@", ahw);
    CLLocation *myLocation = mapView_.myLocation;
    NSString *selectedBranchName = infoWindowmarker.snippet;
    if(myLocation!=nil){
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        HUD.square = YES;
        [HUD show:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            static NSURLSession* sharedSessionMainQueue = nil;
            if(!sharedSessionMainQueue){
                sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:nil delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            }
            NSString *urlString = [NSString stringWithFormat:
                                   @"%@?origin=%f,%f&destination=%f,%f&sensor=true&mode=driving",
                                   @"https://maps.googleapis.com/maps/api/directions/json",
                                   mapView_.myLocation.coordinate.latitude,
                                   mapView_.myLocation.coordinate.longitude,
                                   infoWindowmarker.position.latitude,
                                   infoWindowmarker.position.longitude];
            
            
            NSURL *directionsURL = [NSURL URLWithString:urlString];
            NSURLSessionDataTask *directionsTask =
            [sharedSessionMainQueue dataTaskWithURL:directionsURL
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *e) {
                                      NSError *error = nil;
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingMutableContainers
                                                                                             error:&error];
                                      NSLog(@"Directions Api Response: %@",json);
                                      
                                      NSLog(@"Json Result: %@",json[@"status"]);
                                      
                                      NSString *directionsResponse = json[@"status"];
                                      
                                      
                                      if(error==nil){
                                          
                                          
                                          if([directionsResponse isEqualToString:@"ZERO_RESULTS"]){
                                              
                                              
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:selectedBranchName message:@"Cannot Create Route." delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
                                              [alert show];
                                              [HUD hide:YES];
                                              [HUD show:NO];
                                              
                                          }
                                          else if([directionsResponse isEqualToString:@"OK"]){
                                              NSLog(@"Travel Time : %@",json[@"routes"][0][@"legs"][0][@"duration"][@"text"]);
                                              NSLog(@"Distance : %@",json[@"routes"][0][@"legs"][0][@"distance"][@"text"]);
                                              
                                              distancetoBranch = json[@"routes"][0][@"legs"][0][@"distance"][@"text"];
                                              timetraveledtoBranch = json[@"routes"][0][@"legs"][0][@"duration"][@"text"];
                                              NSString *selectedBranchInfo = [NSString stringWithFormat:@"Travel Time:%@ \n Distance:%@",timetraveledtoBranch,distancetoBranch];
                                              
                                              //selected branch info alertview
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:selectedBranchName message:selectedBranchInfo delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
                                              [alert show];
                                              //creating direction lines
                                              polyline.map = nil;
                                              GMSPath *path =
                                              [GMSPath pathFromEncodedPath:
                                               json[@"routes"][0][@"overview_polyline"][@"points"]];
                                              polyline = [GMSPolyline polylineWithPath:path];
                                              polyline.strokeWidth = 10;
                                              polyline.strokeColor = [UIColor redColor];
                                              polyline.map = mapView_;
                                              [HUD hide:YES];
                                              [HUD show:NO];
                                          }//end else if
                                          else{
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:selectedBranchName message:directionsResponse delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
                                              [alert show];
                                              [HUD hide:YES];
                                              [HUD show:NO];
                                          }//end else
                                          
                                          
                                          
                                      }//end if
                                      else{
                                          NSLog(@"%@",error);
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:selectedBranchName message:error.localizedDescription delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
                                          [alert show];
                                          [HUD hide:YES];
                                          [HUD show:NO];
                                      }// end else
                                      
                                  }];
            
            [directionsTask resume];
            
            
            
        });//end of asynctask
        
        
        
    }
    
    
    
    
}
#pragma mark - marker Click
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)bmarker{
    [mapView_ setSelectedMarker:bmarker];
    
    return YES;
    
}
#pragma mark - Get Branch Markers Method
-(void)getBranchMarkers:(NSUInteger)radd{
    circleRad = radd;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    //Get Branch Coordinate
    self.responseData = [NSMutableData data];
    ServiceConnection *str = [ServiceConnection new];
    NSString *url = [NSString stringWithFormat:@"%@", [str NSGetMapService]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
}
#pragma mark - Get Branch Markers Plus Radius
-(void)getBranchMarkersWithRadius:(NSUInteger)rad;{

    circ.map = nil;
    mapView_.myLocationEnabled = YES;
    CLLocation *myLocation = mapView_.myLocation;
    NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    if(rad==0){
     mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:15.5];
      NSLog(@"0 Radius was selected.");
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

            
            
        }//end for loop

    }//end if(rad==0)
    else if(rad==500){
        circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:500];
        //circ.fillColor = [UIColor whiteColor];
        circ.strokeColor = [UIColor redColor];
        circ.strokeWidth = 2;
        circ.map = mapView_;
        mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:15.5];
        
        
        
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
                
            }//end if
            
            
        }//end for loop

    }//end else if(rad==500)
    else if(rad==1000){
        circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:1000];
        //circ.fillColor = [UIColor whiteColor];
        circ.strokeColor = [UIColor redColor];
        circ.strokeWidth = 2;
        circ.map = mapView_;
        mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:13.9];
        
        
        
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
                
            }//end if
            
            
        }//end for loop
    
    }//end else if(radd==1000)
    else if(rad==1500){
        circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:1500];
        //circ.fillColor = [UIColor whiteColor];
        circ.strokeColor = [UIColor redColor];
        circ.strokeWidth = 2;
        circ.map = mapView_;
        mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:13.3];
        
        
        
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
            if(distance < 1500)
            {
                
                
                marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake(latdouble,longdouble );
                marker.snippet = strplace;
                marker.map = mapView_;
                marker.icon = [UIImage imageNamed:@"ml_1"];
                
            }//end if
            
            
        }//end for loop
    
    }//end else if(rad==1500)
    else if(rad==2000){
        circ = [GMSCircle circleWithPosition:myLocation.coordinate radius:2000];
        //circ.fillColor = [UIColor whiteColor];
        circ.strokeColor = [UIColor redColor];
        circ.strokeWidth = 2;
        circ.map = mapView_;
        mapView_.camera = [GMSCameraPosition cameraWithTarget:myLocation.coordinate
                                                         zoom:13.3];
        
        
        
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
                
            }//end if
            
            
        }//end for loop
    }//end else if(rad==2000)
    
    
    
    
}

//TODO
- (void)directionsTapped:(id)sender {
    
    // steps = nil;
    //    mapView_.selectedMarker = nil;
}

//UNUSed
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
        NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
        
    }
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

#pragma mark - Goto branch
-(void)gotoBranch{
    
    message = [[UIAlertView alloc] initWithTitle:@"Select Radius."
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"500", @"1000",@"1500",@"2000",@"All", nil];
    
    [message show];
    
}

#pragma mark - Custom alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"500"])
    {
        [mapView_ clear];
        NSUInteger dataArr = [gmLat count];
        if(dataArr==0){
            [self getBranchMarkers:500];
        }
        else {
            [self getBranchMarkersWithRadius:500];
        }
        
    }
    else if([title isEqualToString:@"1000"])
    {
        [mapView_ clear];
        NSUInteger dataArr = [gmLat count];
        if(dataArr==0){
            [self getBranchMarkers:1000];
        }
        
        else {
            [self getBranchMarkersWithRadius:1000];
        }
        
        
    }
    else if([title isEqualToString:@"1500"])
    {
        [mapView_ clear];
        NSUInteger dataArr = [gmLat count];
        if(dataArr==0){
            [self getBranchMarkers:1500];
        }
        else {
            [self getBranchMarkersWithRadius:1500];
        }
        
    }
    else if([title isEqualToString:@"2000"])
    {
       [mapView_ clear];
        NSUInteger dataArr = [gmLat count];
        if(dataArr==0){
            [self getBranchMarkers:2000];
        }
        else {
            [self getBranchMarkersWithRadius:2000];
        }
        
        
    }
    else if([title isEqualToString:@"All"]){
        [mapView_ clear];
        NSUInteger dataArr = [gmLat count];
        if(dataArr==0){
            [self getBranchMarkers:0];
        }
        
        else {
            [self getBranchMarkersWithRadius:0];
        }
        
        
    }
    else if([title isEqualToString:@"Cancel"])
    {
        // [mapView_ clear];
        NSLog(@"Button Cancel was selected.");
    }
}


#pragma mark - NSURLConnection Delegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError : %@",error.localizedDescription);
    [HUD hide:YES];
    [HUD show:NO];
    [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[error localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    
    
    
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil) {
        gmLat = [[NSMutableArray alloc] init];
        gmLong = [[NSMutableArray alloc] init];
        place = [[NSMutableArray alloc] init];
        
        NSDictionary *resultCoordinates = [res objectForKey:@"getCoordinatesResult"];
        NSArray *resultList = [resultCoordinates objectForKey:@"mapInfo"];
        NSString *strResponseCode = [resultCoordinates objectForKey:@"respcode"];
        NSString *strResponseMessage = [resultCoordinates objectForKey:@"respmessage"];
        NSLog(@"Response Code : %@",strResponseCode);
        NSLog(@"Response Message : %@",strResponseMessage);
        
        
        if([strResponseMessage isEqualToString:@"OK"]){
            for (NSDictionary *result in resultList) {
                NSString *bName = [result objectForKey:@"bName"];
                // NSLog(@"Branch Name : %@", bName);
                NSString *mLat = [result objectForKey:@"mLat"];
                //NSLog(@"Latitude : %@", bName);
                NSString *mLong = [result objectForKey:@"mLong"];
                NSUInteger count = [res count];
                for(NSUInteger i=0;i < count; i++){
                    [gmLat insertObject:mLat atIndex:i];
                    [gmLong insertObject:mLong atIndex:i];
                    [place insertObject:bName atIndex:i];
                }//end for (NSUInteger i=0;i < count; i++)
                
                //ss
                //Convert to double
                /*
                double latdouble = [mLat doubleValue];
                double londouble = [mLong doubleValue];
                
                marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake(latdouble,londouble );
                //  marker.title = bName;
                marker.snippet = bName;
                marker.icon = [UIImage imageNamed:@"ml_1"];
                markers =[NSSet setWithObjects:marker, nil];
                marker.map = mapView_;
                */
                 [HUD hide:YES];
                [HUD show:NO];
                
            }//end for(NSDictionary *result in resultList)
            [self getBranchMarkersWithRadius:circleRad];
            
        }//end if([strResponseMessage isEqualToString:@"OK"])
        else{
            NSLog(@"Error: %@",myError);
            [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
            [HUD hide:YES];
            [HUD show:NO];
            
        }//end else
        
        
        
        
    }//end if
    
    else {
        NSLog(@"Error : %@",myError.localizedDescription);
        [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [HUD hide:YES];
        [HUD show:NO];
    }//end else
    
    
    
    
    
}//end connectionDidFinishLoading




@end
