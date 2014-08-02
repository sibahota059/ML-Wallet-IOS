//
//  GetReceiver.m
//  ML Wallet
//
//  Created by mm20 on 7/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "CheckPin.h"
#import "ServiceConnection.h"

//#define TRUSTED_HOST @"192.168.12.204"

@implementation CheckPin
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
    [self.delegate didFinishLoadingPin:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getPin= jsonResponse;
    [self.delegate didFinishLoadingPin:@"1" andError:@""];
    
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


- (void)getReceiverWalletNo:(NSString *)walleno andReceiverPinNo:(NSString *)pin
{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *serviceMethods = @"checkPin";
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@/?walletno=%@&pin=%@", con.NSgetURLService,serviceMethods, walleno, pin];

    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end

