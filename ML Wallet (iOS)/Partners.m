//
//  Partners.m
//  ML Wallet
//
//  Created by mm20-18 on 12/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "Partners.h"

@implementation Partners;


@synthesize partnersId;
@synthesize partnersName;
@synthesize accountNo;

-(id) init:(NSString *) partnersIdPar partnersName:(NSString *)partnersNamePar accountNo:(NSMutableArray *) accountNoPar{

    self = [super init];
    
    if (self)
    {
        self.partnersId = partnersIdPar;
        self.partnersName = partnersNamePar;
        self.accountNo = accountNoPar;
    }
    return self;

}



@end
