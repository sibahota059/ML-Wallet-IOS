//
//  GetAllPartnerWS.m
//  ML Wallet
//
//  Created by mm20-18 on 12/9/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "GetAllPartnerWS.h"

#import "ServiceConnection.h"
#import "NSData+Base64.h"
#import "CryptLib.h"

@implementation GetAllPartnerWS
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
    [self.delegate didFinishLoadingPartners:@"error" andError:error.localizedDescription];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSString *loadedContent = [[NSString alloc] initWithData:
                               contentData encoding:NSUTF8StringEncoding];
    
    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    
    
    if (myError == nil){
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        NSDictionary *getResponse = [NSJSONSerialization JSONObjectWithData:encryptedData options:kNilOptions error:&myError];
        
        
       
        self.getPartners = getResponse;
        self.respcode = [getResponse valueForKey:@"RespCode"];
        self.respmessage = [getResponse valueForKey:@"RespMsg"];
        [self.delegate didFinishLoadingPartners:@"1" andError:@""];
        
    }else{
        
        [self.delegate didFinishLoadingPartners:@"1" andError:myError.localizedDescription];
        
    }
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


- (void)loadPartners{
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *contentURL = [NSString stringWithFormat:@"%@%@", con.NSgetURLService, @"GetBillsPayPartners"];
    
    conn = [[NSURLConnection alloc] initWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:contentURL]] delegate:self startImmediately:YES];
    
    
}


@end
