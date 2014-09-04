//
//  AccountMobilePad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/6/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AccountMobilePad.h"
#import "ServiceConnection.h"
#import "AccountMainPad.h"

#import "NSDictionary+LoadWalletData.h"


@implementation AccountMobilePad


{
    
    NSMutableData *contentData;
    NSURLConnection *conn;
    ServiceConnection *con;
    NSDictionary *loadData;
    
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
    self.getAccount = jsonResponse;
    [self.delegate didFinishLoadingRates:@"1" andError:@""];
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


- (void)loadAccount
{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    
    
    NSString *serviceMethods = @"retrieveMobileAccount";
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    
    
    NSString *walletNo = @"?walletno=";
    NSString *walletNoValue =[loadData objectForKey:@"walletno"];
    
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@%@%@", con.NSgetURLService, serviceMethods, walletNo, walletNoValue];
    
    
    
    
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}




@end
