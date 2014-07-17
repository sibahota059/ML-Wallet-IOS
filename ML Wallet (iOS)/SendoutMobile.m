 //
//  SendoutMobile.m
//  ML Wallet
//
//  Created by mm20 on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SendoutMobile.h"
#import "MLSendMoneyViewController.h"

#define TRUSTED_HOST @"192.168.12.204"

@implementation SendoutMobile

NSMutableData *contentData;
NSURLConnection *conn;

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

//-(void) loadContent {
//    contentData = [NSMutableData data];
//    NSString *contentURL = @"https://192.168.12.204:4443/Mobile/Client/mobileKP_WCF/service.svc/checkConnection";
//    conn = [[NSURLConnection alloc] initWithRequest:
//            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
//    
//}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
    [self.delegate didFinishLoading];
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
    
    //NSString* charge = [sendout objectForKey:@"charge"];
    NSString* kptn = [sendout objectForKey:@"kptn"];
    //NSString* principal = [sendout objectForKey:@"principal"];
    NSString* recfname = [sendout objectForKey:@"recfname"];
    NSString* reclname = [sendout objectForKey:@"reclname"];
    NSString* recmname = [sendout objectForKey:@"recmname"];
    //NSString* respcode = [sendout objectForKey:@"respcode"];
    NSString* respmessage = [sendout objectForKey:@"respmessage"];
    NSString* sendfname = [sendout objectForKey:@"sendfname"];
    NSString* sendlname = [sendout objectForKey:@"sendlname"];
    NSString* sendmname = [sendout objectForKey:@"sendmname"];
    NSLog(@"My name is %@,%@%@. I sent money to %@,%@,%@ but it failed because I have %@", sendlname, sendfname, sendmname, reclname, recfname, recmname, respmessage);
    
    self.getKptn = kptn;
    
    [self.delegate didFinishLoading];
    
}


// ------------ ByPass ssl starts ----------
-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod
            isEqualToString:NSURLAuthenticationMethodServerTrust];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
(NSURLAuthenticationChallenge *)challenge {
    if (([challenge.protectionSpace.authenticationMethod
          isEqualToString:NSURLAuthenticationMethodServerTrust])) {
        if ([challenge.protectionSpace.host isEqualToString:TRUSTED_HOST]) {
            NSLog(@"Allowing bypass...");
            NSURLCredential *credential = [NSURLCredential credentialForTrust:
                                           challenge.protectionSpace.serverTrust];
            [challenge.sender useCredential:credential
                 forAuthenticationChallenge:challenge];
        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
// -------------------ByPass ssl ends


-(void)postDataToUrl
{
    
    contentData = [NSMutableData data];
    
//    NSString *jsonRequest = @"{\"walletno\":\"14050000000135\",\"receiverno\":\"690\",\"senderlname\":\"GAUDICOS\",\"sendermname\":\"\",\"senderfname\":\"ALBERT\",\"receiverlname\":\"Tarrayo\",\"receivermname\":\"A\",\"receiverfname\":\"Arthur\",\"principal\":\"300.0\",\"latitude\":\"-0.3234234\", \"longitude\":\"3.234343\", \"deviceid\":\"2342343423\", \"location\":\"Bohol, Philippines\"}";
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"receiverno\":\"%@\",\"senderlname\":\"%@\",\"sendermname\":\"%@\",\"senderfname\":\"%@\",\"receiverlname\":\"%@\",\"receivermname\":\"%@\",\"receiverfname\":\"%@\",\"principal\":\"%@\",\"latitude\":\"%@\", \"longitude\":\"%@\", \"deviceid\":\"%@\", \"location\":\"%@\"}", self.walletNo, self.receiverNo, self.senderLname, self.senderMname, self.senderFname, self.receiverLname, self.receiverMname, self.receiverFname, self.principal, self.latitude, self.longitude, self.deviceId, self.location];
    
    NSURL *url = [NSURL URLWithString:@"https://192.168.12.204:4443/Mobile/Client/mobileKP_WCF/service.svc/sendoutMobile"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


@end
