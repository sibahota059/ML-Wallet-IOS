//
//  PartnersAccountNoList.h
//  ML Wallet
//
//  Created by mm20-18 on 11/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnersAccountNoList : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *accountNo;
    NSMutableArray *accountNoList;
}

@property (strong, nonatomic)UIButton *cancelButton;
@property (strong, nonatomic)UIButton *deleteButton;

@property (strong, nonatomic)NSString *accountNo;
@property (nonatomic, retain)NSMutableArray *accountNoList;

- (id)initWithFrame:(CGRect)frame accountNoListPar:(NSMutableArray *)accountNoListPar;

@end
