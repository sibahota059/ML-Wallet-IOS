//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "LoadHistory.h"
#import "ServiceConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation LoadHistory
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

    [self.delegate didFinishLoadingHistory:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getHistory = jsonResponse;
    [self.delegate didFinishLoadingHistory:@"1" andError:@""];
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


- (void)getUserWalletNo:(NSString *)walleno
{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *serviceMethods = @"sendoutTopUpHistory";

    NSString *contentURL = [NSString stringWithFormat:@"%@%@/?walletno=%@", con.NSgetURLService, serviceMethods, walleno];
    
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

