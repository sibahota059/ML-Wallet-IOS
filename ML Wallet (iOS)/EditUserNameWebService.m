//
//  EditUserNameWebService.m
//  ML Wallet
//
//  Created by mm20-18 on 8/13/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditUserNameWebService.h"
#import "ServiceConnection.h"

@implementation EditUserNameWebService

{
    NSMutableData *contentData;
    NSURLConnection *conn;
    ServiceConnection *con;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"Bad: %@", [error description]);
    [self.delegate didFinishEditingUserName:@"error" andError:error.localizedDescription];
    conn = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:nil];
    
    //NSLog(@"%@", jsonResponse);
    NSDictionary* email = [jsonResponse objectForKey:@"ChangeUsernameResult"];
    
    NSString* repscode = [email objectForKey:@"respcode"];
    NSString* repsmessage = [email objectForKey:@"respmessage"];
    
    
    
    self.respcode    = repscode;
    self.respmessage = repsmessage;
    
    [self.delegate didFinishEditingUserName:@"1" andError:@""];
    
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


-(void)wallet:(NSString *)walletNo username:(NSString *)username_par
{
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"walletno\":\"%@\",\"newUsername\":\"%@\"}", walletNo, username_par];
    
    NSString *serviceMethods = @"ChangeUsername";
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", con.NSgetURLService, serviceMethods]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}



@end
