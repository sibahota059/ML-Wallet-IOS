//
//  SendEmail.m
//  ML Wallet
//
//  Created by ml on 7/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SoCancel.h"
#import "ServiceConnection.h"
#import "NSData+Base64.h"
#import "CryptLib.h"

@implementation SoCancel
{
    NSMutableData *contentData;
    NSURLConnection *conn;
    ServiceConnection *con;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    conn = nil;
    [self.delegate didFinishLoadingCancellation:@"error" andError:error.localizedDescription];
    
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
        
        NSString* repscode = [getResponse objectForKey:@"respcode"];
        NSString* repsmessage = [getResponse objectForKey:@"respmessage"];
        
        self.respcode    = repscode;
        self.respmessage = repsmessage;
        
        [self.delegate didFinishLoadingCancellation:@"1" andError:@""];

        
    }else{
        
        [self.delegate didFinishLoadingCancellation:@"1" andError:myError.localizedDescription];
        
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


-(void)soCancel:(NSString *)walletNo andKptn:(NSString *)kptn andLatitude:(NSString *)lat andLongitude:(NSString *)lon andDeviceId:(NSString *)deviceId andLocation:(NSString *)location
{
    
    contentData = [NSMutableData data];
    
    NSString *contentURL = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"kptn\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"deviceid\":\"%@\",\"location\":\"%@\"}", walletNo, kptn, lat, lon, deviceId, location];
    
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[contentURL dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    
    //Data to POST
    NSString *post = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"SOCancel"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


@end
