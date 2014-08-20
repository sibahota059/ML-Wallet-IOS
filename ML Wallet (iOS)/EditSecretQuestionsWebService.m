//
//  EditSecretQuestionsWebService.m
//  ML Wallet
//
//  Created by mm20-18 on 8/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditSecretQuestionsWebService.h"
#import "ServiceConnection.h"




@implementation EditSecretQuestionsWebService

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
    [self.delegate didFinishEditingQuestions:@"error" andError:error.localizedDescription];
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
    NSDictionary* email = [jsonResponse objectForKey:@"ChangeSecurityQuestionResult"];
    
    NSString* repscode = [email objectForKey:@"respcode"];
    NSString* repsmessage = [email objectForKey:@"respmessage"];
    
    
    
    self.respcode    = repscode;
    self.respmessage = repsmessage;
    
    [self.delegate didFinishEditingQuestions:@"1" andError:@""];
    
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


-(void)wallet:(NSString *)walletNo secQuestion1:(NSString *)question1 secQuestion2:(NSString *)question2 secQuestion3:(NSString *)question3 secAns1:(NSString *)answer1 secAns2:(NSString *)answer2 secAns3:(NSString *)answer3
{
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"sec1\":\"%@\", \"sec2\":\"%@\", \"sec3\":\"%@\", \"ans1\":\"%@\", \"ans2\":\"%@\", \"walletno\":\"%@\", \"ans3\":\"%@\"}", question1, question2, question3, answer1, answer2, walletNo, answer3];
    
    NSString *serviceMethods = @"ChangeSecurityQuestion";
    
    
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
