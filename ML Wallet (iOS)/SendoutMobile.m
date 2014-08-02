 //
//  SendoutMobile.m
//  ML Wallet
//
//  Created by mm20 on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SendoutMobile.h"
#import "MLSendMoneyViewController.h"
#import "ServiceConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation SendoutMobile
{
    
    NSMutableData *contentData;
    NSURLConnection *conn;
    ServiceConnection *con;
    
}



- (instancetype)initWithWalletNo:(NSString *)walletNo senderFname:(NSString *)senderFname senderMname:(NSString *)senderMname senderLname:(NSString *)senderLname receiverFname:(NSString *)receiverFname receiverMname:(NSString *)receiverMname receiverLname:(NSString *)receiverLname receiverNo:(NSString *)receiverNo principal:(NSString *)principal latitude:(NSString *)latitude longitude:(NSString *)longitude location:(NSString *)location deviceId:(NSString *)deviceId{
    
    
    self = [super init];
    
    if (self) {
        
        self.walletNo        = walletNo;
        self.senderFname     = senderFname;
        self.senderMname     = senderMname;
        self.senderLname     = senderLname;
        self.receiverFname   = receiverFname;
        self.receiverMname   = receiverMname;
        self.receiverLname   = receiverLname;
        self.receiverNo      = receiverNo;
        self.principal       = principal;
        self.latitude        = latitude;
        self.longitude       = longitude;
        self.location        = location;
        self.deviceId        = deviceId;
        
    }
    
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"Bad: %@", [error description]);
    [self.delegate didFinishLoading:@"error" andEror:error.localizedDescription];
    conn = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
  
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:nil];
    
    //NSLog(@"%@", jsonResponse);
    NSDictionary* sendout = [jsonResponse objectForKey:@"sendoutMobileResult"];
    
    NSString* charge = [sendout objectForKey:@"charge"];
    NSString* kptn = [sendout objectForKey:@"kptn"];
    NSString* principal = [sendout objectForKey:@"principal"];
    //NSString* recfname = [sendout objectForKey:@"recfname"];
    //NSString* reclname = [sendout objectForKey:@"reclname"];
    //NSString* recmname = [sendout objectForKey:@"recmname"];
    NSString* respcode = [sendout objectForKey:@"respcode"];
    NSString* respmessage = [sendout objectForKey:@"respmessage"];
    //NSString* sendfname = [sendout objectForKey:@"sendfname"];
    //NSString* sendlname = [sendout objectForKey:@"sendlname"];
    //NSString* sendmname = [sendout objectForKey:@"sendmname"];

    self.getKptn        = kptn;
    self.getRespcode    = respcode;
    self.getRespmessage = respmessage;
    self.getTotal       = [NSString stringWithFormat:@"%0.2f", [charge doubleValue] + [principal doubleValue]];
    
    [self.delegate didFinishLoading:@"1" andEror:@""];
    
}


// ------------ ByPass ssl starts ----------
-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
// -------------------ByPass ssl ends


-(void)postDataToUrl
{
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"receiverno\":\"%@\",\"senderlname\":\"%@\",\"sendermname\":\"%@\",\"senderfname\":\"%@\",\"receiverlname\":\"%@\",\"receivermname\":\"%@\",\"receiverfname\":\"%@\",\"principal\":\"%@\",\"latitude\":\"%@\", \"longitude\":\"%@\", \"deviceid\":\"%@\", \"location\":\"%@\"}", self.walletNo, self.receiverNo, self.senderLname, self.senderMname, self.senderFname, self.receiverLname, self.receiverMname, self.receiverFname, self.principal, self.latitude, self.longitude, self.deviceId, self.location];
    
    NSString *serviceMethods = @"sendoutMobile";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", con.NSgetURLService, serviceMethods]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


@end
