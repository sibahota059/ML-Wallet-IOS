//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "LoadHistory.h"
#import "TempConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation LoadHistory
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
    [self.delegate didFinishLoadingHistory:@"8"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getHistory = jsonResponse;
    [self.delegate didFinishLoadingHistory:@"1"];
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


- (void)getUserWalletNo:(NSString *)walleno
{
    contentData = [NSMutableData data];
    con         = [TempConnection new];
    
    NSString *serviceMethods = @"sendoutTopUpHistory";
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@:%@%@%@/?walletno=%@", con.getHttp, con.getUrl, con.getPort, con.getPath, serviceMethods, walleno];
    
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

