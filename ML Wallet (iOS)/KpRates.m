//
//  KpRates.m
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "KpRates.h"
#import "MLRatesTableViewController.h"
#import "TempConnection.h"
//#define TRUSTED_HOST @"192.168.12.204"

@implementation KpRates
{
    
    NSMutableData *contentData;
    NSURLConnection *conn;
    TempConnection *con;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    conn = nil;
    [self.delegate didFinishLoadingRates:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getRates = jsonResponse;
    [self.delegate didFinishLoadingRates:@"1" andError:@""];
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
    con         = [TempConnection new];
    
    NSString *serviceMethods = @"getChargeValues";
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@:%@%@%@", con.getHttp, con.getUrl, con.getPort, con.getPath, serviceMethods];
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];

}




@end
