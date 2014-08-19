//
//  EditAccountInfoWebService.m
//  ML Wallet
//
//  Created by mm20-18 on 8/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditAccountInfoWebService.h"
#import "ServiceConnection.h"

@implementation EditAccountInfoWebService

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
    [self.delegate didFinishEditingAccount:@"error" andError:error.localizedDescription];
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
    NSDictionary* email = [jsonResponse objectForKey:@"ChangeAccountInfoResult"];
    
    NSString* repscode = [email objectForKey:@"respcode"];
    NSString* repsmessage = [email objectForKey:@"respmessage"];
    
    
    
    self.respcode    = repscode;
    self.respmessage = repsmessage;
    
    [self.delegate didFinishEditingAccount:@"1" andError:@""];
    
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


-(void)wallet:(NSString *)walletNo country:(NSString *)countryPar province:(NSString *)provincePar address:(NSString *)addressPar zipcode:(NSString *)zipcodePar gender:(NSString *)genderPar mnumber:(NSString *)mnumberPar work:(NSString *)workPar nationality:(NSString *)nationalityPar photo1:(UIImage *)photo1Par photo2:(UIImage *)photo2Par photo3:(UIImage *)photo3Par photo4:(UIImage *)photo4Par
{
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *strImage1 = [self encodeToBase64String:photo1Par];
    NSArray *photoArray1 = [NSArray arrayWithObject:strImage1];
    
    NSString *strImage2 = [self encodeToBase64String:photo2Par];
    NSArray *photoArray2 = [NSArray arrayWithObject:strImage2];
    
    NSString *strImage3 = [self encodeToBase64String:photo3Par];
    NSArray *photoArray3 = [NSArray arrayWithObject:strImage3];
   
    NSString *strImage4 = [self encodeToBase64String:photo4Par];
    NSArray *photoArray4 = [NSArray arrayWithObject:strImage4];
   
    
    NSArray *keys ;
    NSArray *objects ;
    NSDictionary *jsonDictionary ;
    
    keys = [NSArray arrayWithObjects:@"walletno",@"country",@"province",@"permaAddress",@"zipcode",@"gender",@"mNumber",@"natureWork",@"nationality",@"photo1",@"photo2",@"photo3",@"photo4", nil];
    
    objects = [NSArray arrayWithObjects:walletNo, countryPar, provincePar,addressPar, zipcodePar, genderPar, mnumberPar, workPar, nationalityPar, photoArray1, photoArray2, photoArray3, photoArray4,nil];
    
    jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"ChangeAccountInfo"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:kNilOptions error:&error];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    [NSURLConnection connectionWithRequest:request delegate:self];

    
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
