//
//  KpRates.m
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "KpRates.h"
#import "MLRatesTableViewController.h"
#define TRUSTED_HOST @"192.168.12.204"

@implementation KpRates

NSMutableData *contentData;
NSURLConnection *conn;




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
    conn = nil;
    [self.delegate didFinishLoadingRates:@"0"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getRates = jsonResponse;
    [self.delegate didFinishLoadingRates:@"1"];
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


- (void)loadRates
{
    contentData = [NSMutableData data];
    NSString *contentURL = @"https://192.168.12.204:4443/Mobile/Client/mobileKP_WCF/service.svc/getChargeValues";
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];

}




@end
