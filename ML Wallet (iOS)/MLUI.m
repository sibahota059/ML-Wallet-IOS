//
//  MLUI.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLUI.h"

@implementation MLUI


- (void)customTabBar:(UITabBarController *)tabController{
    
    tabController.tabBar.barStyle = UIBarStyleDefault;
    UITabBar *tabBar = tabController.tabBar;
    UITabBarItem *item1, *item2;
    
    UIImage *sendmoneyDefault = [[UIImage imageNamed:@"send_default.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *sendmoneySelected = [[UIImage imageNamed:@"send_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *ratesDefault = [[UIImage imageNamed:@"rates_default.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *ratesSelected = [[UIImage imageNamed:@"rates_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1 = [[tabBar.items objectAtIndex: 0] initWithTitle:@"" image:sendmoneyDefault selectedImage:sendmoneySelected];
    
    item2 = [[tabBar.items objectAtIndex: 1] initWithTitle:@"" image:ratesDefault selectedImage:ratesSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial"size:10.0f], NSForegroundColorAttributeName: [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]} forState:UIControlStateNormal];
    
    UIImage *tabBarBackground = [UIImage imageNamed:@"tabbar_bg.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_item.png"]];
    
}
- (void)navigationAppearance{
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ml_logo_iphone.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ml_logo_ipad.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    
}

- (UILabel *)navTitle:(NSString *)navtitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Arial" size:24];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor redColor];
    label.text = navtitle;
    [label sizeToFit];
    
    return label;
}

- (UIBarButtonItem *)navBarButton:(MLSendMoneyViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename{
    
    UIBarButtonItem *myNavBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagename] style:UIBarButtonItemStylePlain target:controller action:link];
    
    return myNavBtn;
}

- (UIBarButtonItem *)navBarButtonPreview:(MLPreviewViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename{
    
    UIBarButtonItem *myNavBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagename] style:UIBarButtonItemStylePlain target:controller action:link];
    
    return myNavBtn;
}

- (UIBarButtonItem *)navBarButtonTc:(MLTermsConditionViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename{
    
    UIBarButtonItem *myNavBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagename] style:UIBarButtonItemStylePlain target:controller action:link];
    
    return myNavBtn;
}

- (UIBarButtonItem *)navBarButtonHistory:(MLHistoryViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename{
    
    UIBarButtonItem *myNavBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagename] style:UIBarButtonItemStylePlain target:controller action:link];
    
    return myNavBtn;
}

- (void)displayAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (NSString *)termsConditions{
    NSString *tcmsg = @"1. Sender must comply with the Know Your Customer (KYC) form, present valid identification, and must subscribe to the AMLC rules and regulations and other applicable laws in making the transaction.\n\n2. The Sender must register the fullname of the receiver inclucing full middle name. Should the Sender fail to give the full middle name of the receiver, it shall be considered a waiver on this part to include his information in verifying the transaction, MLI shall not be held liable for any paid transactions to a receiver whose full middle name information was waived by the Sender. Incorrect spelling of the receiver's name(s) may cause delay in paying out the transaction.\n\n3. The Sender hereby agrees that the transaction shall be released to the claimant receiver if the latter can present the correct Kwarta Padala Transaction Number (KPTN) and comply with the valid ID, KYC and all other requirements as may be required by law.\n\n4. The sender must relay to the receiver the complete and correct KPTN and must advise the receiver to bring a valid ID for additional verification purposes.\n\n5. The Sender may waive the age requirement of the receiver. However, a minor receiver can only claim the money provided said minor is a relative of the sender to the 4th civil degree or godchild/ward/beneficiary of the sender or whose relationship with the sender is such that it does not violate the Child Trafficking Law. The said minor receiver must comply with the identification requirements mentioned herein. Minors below 12 years old must be accompanied by his/her guardian. Tha said guardian must comply with the requirements in Item No. 3 herein.\n\n6. The money is available for pickup in any MLFSI subject to hours of operation of the selected payout branch including closures without prior notice, its communications facility, its connectivity to the ML Wallet and MLKP Systems, and other conditions, including but not limited to power and telecommunications failure, computer or gadget failure, inclement weather and the like.\n\n7. Should the sender decides to cancel sendout, he/she must submit a written request to MLFSI for the cancellation of the said transaction. MLFSI will refund the principal amount of the money transfer only. MLFSI will refund the charges upon written request of the sender, only if the money transfer is not available at the recipient within seven (7) days from the time it was sent. To the extent allowed by law, MLFSI may deduct a service fee of FIVE HUNDRED PESOS (Php500) per month from money transfer that are not picked up after one month from the time it was sent.\n\n8. Changes to the original entries of the sendout will be made only at any MLFSI branches.\n\n9. In case of delay, non-payment or underpayment of this money transfer whether by fault or negligence of the company or its employees, neither shall be liable for damages beyond the sum of FIVE THOUSAND PESOS (P5,000), in addition to the refund of the principal amount of the money transfer and the service fee. In no event will the company or it's employees be liable for any indirect, special, incidental or consequential damages.\n\n10. MLFSI reserves the right to deactivate customer account in cases of three times login failure, however, the customer may request activation by calling our Customer Care.\n\n11. MLFSI may not accept, process or pay any money transfer that any of them determines, in their sole discretion, to be in violation of any MLFSI policy or applicable law.\n\n12. All claims or suits regarding this transaction shall be filed in the courts of Cebu City only.\n";
    
    return tcmsg;
}

- (UIView *)shadowView:(UIView*)viewContent{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:viewContent.bounds];
    viewContent.layer.masksToBounds = NO;
    viewContent.layer.shadowColor = [UIColor blackColor].CGColor;
    viewContent.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    viewContent.layer.shadowOpacity = 0.32f;
    viewContent.layer.shadowPath = shadowPath.CGPath;
    
    return viewContent;
}
@end
