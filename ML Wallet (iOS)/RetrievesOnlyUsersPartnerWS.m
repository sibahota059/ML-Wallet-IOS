//
//  RetrievesOnlyUsersPartnerWS.m
//  ML Wallet
//
//  Created by mm20-18 on 11/27/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "RetrievesOnlyUsersPartnerWS.h"
#import "ServiceConnection.h"
#import "NSDictionary+LoadWalletData.h"
#import "CryptLib.h"
#import "NSData+Base64.h"
#import "Partners.h"

@implementation RetrievesOnlyUsersPartnerWS
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
    //NSLog(@"Bad: %@", [error description]);
    [self.delegate didFinishRetrievingPartners:@"error" andError:error.localizedDescription];
    conn = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableLeaves error:&myError];
    
    
    if (myError == nil){
        
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        NSLog(@"data %@", [result base64EncodingWithLineLength:0]);
        
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:encryptedData options:kNilOptions error:&myError];
        
        self.respcode = [jsonResponse valueForKey:@"RespCode"];
        self.respmessage = [jsonResponse valueForKey:@"RespMsg"];
        self.partners = jsonResponse;
        
        // end of saving the partner of the users

        [self.delegate didFinishRetrievingPartners:@"1" andError:@""];
    
    }else{
        
        [self.delegate didFinishRetrievingPartners:@"error" andError:myError.localizedDescription];
        
    }
    
    
    
    
    
    
//========================================================================
//    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
//                                                                 options:kNilOptions
//                                                                   error:nil];
//    
//    //NSLog(@"%@", jsonResponse);
//    NSDictionary* email = [jsonResponse objectForKey:@"ChangeUsernameResult"];
//    
//    NSString* repscode = [email objectForKey:@"respcode"];
//    NSString* repsmessage = [email objectForKey:@"respmessage"];
//    
//    
//    
//    self.respcode    = repscode;
//    self.respmessage = repsmessage;
//    
//    [self.delegate didFinishRetrievingPartners:@"1" andError:@""];
    
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


-(void)retrievePartners
{
    
    contentData = [NSMutableData data];
    contentData = [[NSMutableData alloc] init];
    con         = [ServiceConnection new];
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    NSString *walletNoValue =[loadData objectForKey:@"walletno"];
    
    NSString *contentURL = [NSString stringWithFormat:@"{\"walletno\" : \"%@\"}",
                            walletNoValue];
    
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[contentURL dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    
    //Data to POST
    NSString *post = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"RetrievePartnersAccount"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}



@end
