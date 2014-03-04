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

/*
- (instancetype) initReceiverToEdit:(NSString*)receiverName Address:(NSString*)address Relation:(NSString*)relation ReceiverImage:(UIImage*)receiverImage;

- (instancetype)initRetriveInfo;
*/

-(id) initWithName:(NSString *)name Address:(NSString *)address Relation:(NSString *)relation receiverImage:(UIImage *)image;

@end
