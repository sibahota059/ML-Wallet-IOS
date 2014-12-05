//
//  RetrievePartnersAccount.h
//  ML Wallet
//
//  Created by ml on 12/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetPartnersDelegate <NSObject>

@required
-(void)didFinishLoadingPartners:(NSString *)indicator andError:(NSString *)getError;

@end
@interface RetrievePartnersAccount : NSObject
@property (weak, nonatomic) id<GetPartnersDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getUserPartners;

- (void)getUserWalletNo:(NSString *)walleno;
@end

