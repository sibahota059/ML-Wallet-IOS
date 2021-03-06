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
#import "NSData+Base64.h"
#import "CryptLib.h"

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
    
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    
    
    if (myError == nil){
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        NSDictionary *getResponse = [NSJSONSerialization JSONObjectWithData:encryptedData options:kNilOptions error:&myError];
        
        
        NSString* charge = [getResponse objectForKey:@"charge"];
        NSString* kptn = [getResponse objectForKey:@"kptn"];
        NSString* principal = [getResponse objectForKey:@"principal"];
        NSString* respcode = [getResponse objectForKey:@"respcode"];
        NSString* respmessage = [getResponse objectForKey:@"respmessage"];
        
        self.getKptn        = kptn;
        self.getRespcode    = respcode;
        self.getRespmessage = respmessage;
        self.getTotal       = [NSString stringWithFormat:@"%0.2f", [charge doubleValue] + [principal doubleValue]];
        
        [self.delegate didFinishLoading:@"1" andEror:@""];
        
    }else{
        
        [self.delegate didFinishLoading:@"1" andEror:myError.localizedDescription];
        
    }
    
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
    
    NSString *contentURL = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"receiverno\":\"%@\",\"senderlname\":\"%@\",\"sendermname\":\"%@\",\"senderfname\":\"%@\",\"receiverlname\":\"%@\",\"receivermname\":\"%@\",\"receiverfname\":\"%@\",\"principal\":\"%@\",\"latitude\":\"%@\", \"longitude\":\"%@\", \"deviceid\":\"%@\", \"location\":\"%@\"}", self.walletNo, self.receiverNo, self.senderLname, self.senderMname, self.senderFname, self.receiverLname, self.receiverMname, self.receiverFname, self.principal, self.latitude, self.longitude, self.deviceId, self.location];
    
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[contentURL dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    
    //Data to POST
    NSString *post = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"sendoutMobile"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
    
}


@end
