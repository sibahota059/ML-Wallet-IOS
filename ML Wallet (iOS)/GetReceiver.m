//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "GetReceiver.h"

#define TRUSTED_HOST @"192.168.12.204"

@implementation GetReceiver

NSMutableData *contentData;
NSURLConnection *conn;




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
    conn = nil;
    [self.delegate didFinishLoadingReceiver:@"0"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getReceiver = jsonResponse;
    [self.delegate didFinishLoadingReceiver:@"1"];
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


- (void)getReceiverWalletNo:(NSString *)walleno
{
    contentData = [NSMutableData data];
    NSString *contentURL = [NSString stringWithFormat:@"https://192.168.12.204:4443/Mobile/Client/mobileKP_WCF/service.svc/retrieveReceivers/?walletno=%@", walleno];
    //NSString *contentURL = @"https://192.168.12.204:4443/Mobile/Client/mobileKP_WCF/service.svc/retrieveReceivers/?walletno=14050000000135";
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

