//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "CheckPin.h"
#import "TempConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation CheckPin
{
    
    NSMutableData *contentData;
    NSURLConnection *conn;
    TempConnection *con;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
    conn = nil;
    [self.delegate didFinishLoadingPin:@"error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getPin= jsonResponse;
    [self.delegate didFinishLoadingPin:@"1"];
    
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


- (void)getReceiverWalletNo:(NSString *)walleno andReceiverPinNo:(NSString *)pin
{
    contentData = [NSMutableData data];
    con         = [TempConnection new];
    
    NSString *serviceMethods = @"checkPin";
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@:%@%@%@/?walletno=%@&pin=%@", con.getHttp, con.getUrl, con.getPort, con.getPath, serviceMethods, walleno, pin];

    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

