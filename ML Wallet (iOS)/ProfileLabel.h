//
//  ProfileLabel.h
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileLabel : UILabel

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y ;

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y myColor:(UIColor *) myColor;

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y myColor:(UIColor *)myColor width:(int)width;

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y width:(int) width;

-(id) initWithStatusValue:(NSString *) word_par x:(int)x y:(int)y;



@end
