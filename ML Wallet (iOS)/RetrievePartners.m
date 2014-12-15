//
//  RetrievePartners.m
//  ML Wallet
//
//  Created by mm20-18 on 11/24/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "RetrievePartners.h"
#import "EditInformationCell.h"
#import "PartnersAccountNoList.h"
#import "NSDictionary+LoadWalletData.h"
#import "Partners.h"
#import "SelectBillsPayPartners.h"
#import "DimLightDialogBackground.h"


@interface RetrievePartners ()

@end

@implementation RetrievePartners
{
    NSMutableArray *partnersData;
}

@synthesize partners;
@synthesize accountNoList;

UIView *backgroundDim;
PartnersAccountNoList *partnersAccountNo;


MBProgressHUD *HUD;

NSDictionary *loadData;

NSString *RETRIEVE_PARTNER_VAL_ERROR = @"Validation Error";

NSString  *wallet;

NSString *accountNo;

DimLightDialogBackground *dialogBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{

    [super viewDidLoad];

    
    NSDictionary *partner = self.partners;
    
    NSMutableArray *partnersList = [partner valueForKey:@"ListBillsPayPartners"];
    
    NSMutableArray *partnersArrayList = [[NSMutableArray alloc] init];
    
    
            // saving the partners of the user
    int i = 0;
    while(i < [partnersList count])
    {
        NSDictionary *singlePartner = [partnersList objectAtIndex:i];
        NSString *partersId = [singlePartner objectForKey:@"PartnersId"];
        NSString *PartnersName = [singlePartner objectForKey:@"PartnersName"];
        NSMutableArray *accountNumberList = [singlePartner objectForKey:@"ListAccountNo"];
        Partners *partner = [[Partners  alloc] init:partersId partnersName:PartnersName accountNo:accountNumberList];
        [partnersArrayList addObject:partner];
        i++;
    }
    
    partnersData = partnersArrayList;
    

    
    
    
    
//    int j = 0;
//    int test = [partnersArrayList count];
//    NSMutableArray *partnersName = [[NSMutableArray alloc] init];
//    
//    while(j < test)
//    {
//        Partners *onePartner = [partnersArrayList objectAtIndex:j];
//        NSString *name = onePartner.partnersName;
//        [partnersName addObject:name];
//        j++;
//    }
    
//    partnersData = partnersName;
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    wallet = [loadData objectForKey:@"walletno"];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
     self.navigationController.navigationBarHidden = NO;
    [self navigationButtons];

}



- (void)dismissProgressBar{
    
    [HUD hide:YES];
    [HUD show:NO];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [partnersData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"EditInformationCell";
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 50)];
    UIImageView *accessoryViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIndicator.png"]];
    [accessoryView addSubview:accessoryViewImage];
    accessoryViewImage.center = CGPointMake(12, 25);
    
    EditInformationCell *cell = (EditInformationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditInformationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell setAccessoryView:accessoryView];
    cell.textLabel.text = [[partnersData objectAtIndex:indexPath.row] partnersName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    dialogBackground = [[DimLightDialogBackground alloc] init];
    
    Partners *part = [partnersData objectAtIndex:indexPath.row];
    NSMutableArray *testAccountList = part.accountNo;
    
    self.accountNoList = testAccountList;
    NSMutableArray *test = self.accountNoList;
    
    
    
    partnersAccountNo = [[PartnersAccountNoList alloc] initWithFrame:CGRectMake(20, 20, 280, 300) accountNoListPar:test];
//    [[PartnersAccountNoList alloc] initWithFrame:CGRectMake(20, 20, 280, 300) ];
    
    
//    partnersAccountNo.accountNoList = test;
    
    [partnersAccountNo.cancelButton addTarget:self action:@selector(cancelMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dialogBackground];
    [self.view addSubview:partnersAccountNo];
    
//    partnersAccountNo.hidden = NO;

}


-(void)navigationButtons{
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Partners";
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backPressed:)];
    
    UIBarButtonItem *buttonSelectReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"receiver_add_person.png"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                            action:@selector(gotoSelectPartner:)];
    
    self.navigationItem.leftBarButtonItem = buttonHome;
    self.navigationItem.rightBarButtonItem = buttonSelectReceiver;
}

-(void)backPressed:(id)sender{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController  popViewControllerAnimated:YES];
    
}

-(void)gotoSelectPartner:(id)sender
{
    SelectBillsPayPartners *selectPartner = [[SelectBillsPayPartners alloc] initWithNibName:@"SelectBillsPayPartners" bundle:nil];
    [self.navigationController pushViewController:selectPartner animated:YES];


}



- (BOOL)prefersStatusBarHidden{
    return YES;
}


-(void) cancelMethod:(id)sender{
    
    accountNo = @"none";
    
    [dialogBackground removeFromSuperview];
    [partnersAccountNo removeFromSuperview];

    
}


@end
