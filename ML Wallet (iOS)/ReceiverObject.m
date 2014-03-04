//
//  ReceiverObject.m
//  ML Wallet
//
//  Created by ml on 2/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ReceiverObject.h"

@implementation ReceiverObject

@synthesize ReceiverName;

@synthesize Address;

/*
- (instancetype) initReceiverToEdit:(NSString*)receiverName Address:(NSString*)address Relation:(NSString*)relation ReceiverImage:(UIImage*)receiverImage
{
    self = [super init];
    
    if (self) {
        self.ReceiverName   = receiverName;
        self.ReceiverImage  = receiverImage;
        self.Address        = address;
        self.Relation       = relation;
    }
    
    return self;
}

- (instancetype)initRetriveInfo
{
    NSMutableDictionary *dictionaryInfo = [[NSMutableDictionary alloc] init];
    [dictionaryInfo setObject:self.ReceiverName forKey:@"name"];
    [dictionaryInfo setObject:self.ReceiverImage forKey:@"image"];
    [dictionaryInfo setObject:self.Address forKey:@"address"];
    [dictionaryInfo setObject:self.Relation forKey:@"relation"];
    
    return [dictionaryInfo mutableCopy];
}
*/


-(id) initWithName:(NSString *)name Address:(NSString *)address Relation:(NSString *)relation receiverImage:(UIImage *)image;
{
    self = [super init];
    if(self)
    {
        self.ReceiverName   = name;
        self.Address        = address;
        self.ReceiverImage  = image;
        self.Relation       =relation;
    }
    return self;
}
@end
