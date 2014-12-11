//
//  Partners.h
//  ML Wallet
//
//  Created by mm20-18 on 12/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Partners : NSObject

@property (weak, nonatomic) NSString *partnersId;
@property(weak, nonatomic) NSString *partnersName;
@property(weak, nonatomic) NSMutableArray *accountNo;

-(id) init:(NSString *) partnersId partnersName:(NSString *)partnersName accountNo:(NSMutableArray *) accountNo;
@end
