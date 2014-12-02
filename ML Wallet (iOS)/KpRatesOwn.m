//
//  KpRatesOwn.m
//  ML Wallet
//
//  Created by ml on 11/27/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "KpRatesOwn.h"
#import "MLRatesTableViewController.h"
#import "ServiceConnection.h"

@implementation KpRatesOwn
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
    [self.delegate didFinishLoadingRatesOwn:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.getRates = jsonResponse;
    
    [self.delegate didFinishLoadingRatesOwn:@"1" andError:@""];
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


- (void)loadRates:(NSString *)parameterMethods
{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@", con.NSgetURLService, parameterMethods];
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
}

@end