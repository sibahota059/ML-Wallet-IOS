//
//  CryptLib.h
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface StringEncryption : NSObject

-  (NSData *)encrypt:(NSData *)plainText; //key:(NSString *)key; iv:(NSString *)iv;
-  (NSData *)decrypt:(NSData *)encryptedText; //key:(NSString *)key; iv:(NSString *)iv;
-  (NSData *)generateRandomIV:(size_t)length;
-  (NSString *) md5:(NSString *) input;
-  (NSString*) sha256_length:(NSInteger) length;

@end
