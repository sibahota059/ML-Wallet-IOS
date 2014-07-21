//
//  ReceiverObject.h
//  ML Wallet
//
//  Created by ml on 2/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiverObject : NSObject

@property (retain, nonatomic) NSString *ReceiverName;
@property (retain, nonatomic) NSString *Address;
@property (retain, nonatomic) NSString *Relation;
@property (retain, nonatomic) UIImage *ReceiverImage;
@property (retain, nonatomic) NSNumber *receiverNo;

@property (retain, nonatomic) NSString *fname;
@property (retain, nonatomic) NSString *lname;
@property (retain, nonatomic) NSString *mname;


-(id) initWithName:(NSString *)name Address:(NSString *)address Relation:(NSString *)relation receiverImage:(UIImage *)image receiverNo:(NSNumber *)receiverNo FName:(NSString*)fname LName:(NSString*)lname MName:(NSString*)MName;

@end
