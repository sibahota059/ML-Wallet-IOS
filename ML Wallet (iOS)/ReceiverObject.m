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

-(id) initWithName:(NSString *)name Address:(NSString *)address Relation:(NSString *)relation receiverImage:(UIImage *)image receiverNo:(NSNumber *)receiverNo FName:(NSString *)fname LName:(NSString *)lname MName:(NSString *)mname;
{
    self = [super init];
    if(self)
    {
        self.ReceiverName   = name;
        self.Address        = address;
        self.ReceiverImage  = image;
        self.Relation       = relation;
        self.receiverNo     = receiverNo;
        self.fname          = fname;
        self.lname          = lname;
        self.mname          = mname;
    }
    return self;
}
@end
