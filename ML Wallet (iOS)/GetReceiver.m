//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "GetReceiver.h"
#import "ServiceConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation GetReceiver
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
    [self.delegate didFinishLoadingReceiver:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getReceiver = jsonResponse;
    [self.delegate didFinishLoadingReceiver:@"1" andError:@""];
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


- (void)getReceiverWalletNo:(NSString *)walleno
{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *serviceMethods = @"retrieveReceivers/";
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@?walletno=%@", con.NSgetURLService, serviceMethods, walleno];

    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

