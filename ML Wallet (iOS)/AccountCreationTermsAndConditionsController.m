//
//  AccountCreationTermsAndConditionsController.m
//  ML Wallet
//
//  Created by ml on 8/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AccountCreationTermsAndConditionsController.h"

@interface AccountCreationTermsAndConditionsController ()

@end

@implementation AccountCreationTermsAndConditionsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self termsAndConditions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)init_Buttons{
    [self.btnAccept addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(hideErrorNotification) forControlEvents:UIControlEventTouchUpInside];
    [self.btnDecline addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRetry addTarget:self action:@selector(resendPin) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)hideErrorNotification{

}
-(void)showErrorNotification{
    self.pinConfirmationView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}
-(void)goBack{

}
-(void)resendPin{

}
-(void)createAccount{

}
-(void)termsAndConditions{
    NSLog(@"Fail ni");

    self.termsAndconditionTextView.text = @"1. Sender must comply with the Know Your Customer (KYC) form, present valid identification, and must subscribe to the AMLC rules and regulations and other applicable laws in making the transaction.\n\n2. The Sender must register the fullname of the receiver inclucing full middle name. Should the Sender fail to give the full middle name of the receiver, it shall be considered a waiver on this part to include his information in verifying the transaction, MLI shall not be held liable for any paid transactions to a receiver whose full middle name information was waived by the Sender. Incorrect spelling of the receiver's name(s) may cause delay in paying out the transaction.\n\n3. The Sender hereby agrees that the transaction shall be released to the claimant receiver if the latter can present the correct Kwarta Padala Transaction Number (KPTN) and comply with the valid ID, KYC and all other requirements as may be required by law.\n\n4. The sender must relay to the receiver the complete and correct KPTN and must advise the receiver to bring a valid ID for additional verification purposes.\n\n5. The Sender may waive the age requirement of the receiver. However, a minor receiver can only claim the money provided said minor is a relative of the sender to the 4th civil degree or godchild/ward/beneficiary of the sender or whose relationship with the sender is such that it does not violate the Child Trafficking Law. The said minor receiver must comply with the identification requirements mentioned herein. Minors below 12 years old must be accompanied by his/her guardian. Tha said guardian must comply with the requirements in Item No. 3 herein.\n\n6. The money is available for pickup in any MLFSI subject to hours of operation of the selected payout branch including closures without prior notice, its communications facility, its connectivity to the ML Wallet and MLKP Systems, and other conditions, including but not limited to power and telecommunications failure, computer or gadget failure, inclement weather and the like.\n\n7. Should the sender decides to cancel sendout, he/she must submit a written request to MLFSI for the cancellation of the said transaction. MLFSI will refund the principal amount of the money transfer only. MLFSI will refund the charges upon written request of the sender, only if the money transfer is not available at the recipient within seven (7) days from the time it was sent. To the extent allowed by law, MLFSI may deduct a service fee of FIVE HUNDRED PESOS (Php500) per month from money transfer that are not picked up after one month from the time it was sent.\n\n8. Changes to the original entries of the sendout will be made only at any MLFSI branches.\n\n9. In case of delay, non-payment or underpayment of this money transfer whether by fault or negligence of the company or its employees, neither shall be liable for damages beyond the sum of FIVE THOUSAND PESOS (P5,000), in addition to the refund of the principal amount of the money transfer and the service fee. In no event will the company or it's employees be liable for any indirect, special, incidental or consequential damages.\n\n10. MLFSI reserves the right to deactivate customer account in cases of three times login failure, however, the customer may request activation by calling our Customer Care.\n\n11. MLFSI may not accept, process or pay any money transfer that any of them determines, in their sole discretion, to be in violation of any MLFSI policy or applicable law.\n\n12. All claims or suits regarding this transaction shall be filed in the courts of Cebu City only.\n";
    
}

@end
