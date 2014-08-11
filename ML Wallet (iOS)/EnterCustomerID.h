//
//  EnterCustomerID.h
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

//#import "MLViewController.h"
//@interface EnterCustomerID : MLViewController <UITextFieldDelegate>
#import "Customer.h"

@interface EnterCustomerID : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) Customer *customer;
@end
