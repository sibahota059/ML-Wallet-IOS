//
//  SendEmail.m
//  ML Wallet
//
//  Created by ml on 7/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SoCancel.h"
#import "TempConnection.h"

@implementation SoCancel
{
    NSMutableData *contentData;
    NSURLConnection *conn;
    TempConnection *con;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"Bad: %@", [error description]);
    [self.delegate didFinishLoadingCancellation:@"0"];
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
    NSDictionary* email = [jsonResponse objectForKey:@"SOCancelResult"];
    
    NSString* repscode = [email objectForKey:@"respcode"];
    NSString* repsmessage = [email objectForKey:@"respmessage"];
    
    
    
    self.respcode    = repscode;
    self.respmessage = repsmessage;
    
    [self.delegate didFinishLoadingCancellation:@"1"];
    
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
        if ([challenge.protectionSpace.host isEqualToString:con.getUrl]) {
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


-(void)soCancel:(NSString *)walletNo andKptn:(NSString *)kptn andLatitude:(NSString *)lat andLongitude:(NSString *)lon andDeviceId:(NSString *)deviceId andLocation:(NSString *)location
{
    
    contentData = [NSMutableData data];
    con         = [TempConnection new];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"kptn\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"deviceid\":\"%@\",\"location\":\"%@\"}", walletNo, kptn, lat, lon, deviceId, location];
    
    NSString *serviceMethods = @"SOCancel";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@:%@%@%@", con.getHttp, con.getUrl, con.getPort, con.getPath, serviceMethods]];
    
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
