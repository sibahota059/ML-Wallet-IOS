//
//  AccountMain.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountMain.h"
#import "ProfileInformation.h"
#import "AccountInformation.h"
#import "MenuViewController.h"
#import "SaveWalletData.h"

@interface AccountMain ()
{
    AccountMobilePad *account;
}
@end

@implementation AccountMain


NSString *firstName ,*middleName, *lastName , *country, *province, *address, *zipcode, *gender, *bdate, *age, *mobileno, *emailadd, *nationality, *work, *answer1, *answer2, *answer3, *question1, *question2, *question3,
*walletNo, *respMessage, *resCode, *photo1, *photo2, *photo3, *photo4;

//USER BDAY USE IN GETTING AGE
NSDate *date;

UIImageView *profileImageView;

UIView *imageFrameView;

UILabel *nameLabel, *bdayLabel, *countryLabel;

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

    [self createUI];
    account = [AccountMobilePad new];
    account.delegate = self;
    [account loadAccount];
   
    
   }


-(void)createUI{
    
    //IMAGE
    imageFrameView = [[UIView alloc] initWithFrame:CGRectMake(95, 60, 130, 130)];
    [imageFrameView setBackgroundColor:[UIColor redColor]];
    
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 62, 126, 126)];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 300, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 40)];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    countryLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton *accountButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 325, 100, 30)];
    [accountButton setBackgroundColor:[UIColor redColor]];
    [accountButton setTitle:@"Account" forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(accountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 325, 100, 30)];
    [profileButton setBackgroundColor:[UIColor redColor]];
    [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:bdayLabel];
    [self.view addSubview:countryLabel];
    
    [self.view addSubview:accountButton];
    [self.view addSubview:profileButton];
    
    [self.view addSubview:imageFrameView];
    [self.view addSubview:profileImageView];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self addNavigationBarButton];
    
}




- (void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError{
    
    
    //Store the NSDictionary rates data into static array
    NSArray *accountArray       = [account.getAccount objectForKey:@"retrieveMobileAccountResult"];
    
    firstName = [accountArray valueForKey:@"fname"];
    middleName = [accountArray valueForKey:@"mname"];
    lastName = [accountArray valueForKey:@"lname"];
    country = [accountArray valueForKey:@"country"];
    province = [accountArray valueForKey:@"provinceCity"];
    address = [accountArray valueForKey:@"permanentAdd"];
    zipcode = [accountArray valueForKey:@"zipcode"];
    gender = [accountArray valueForKey:@"gender"];
    bdate = [accountArray valueForKey:@"bdate"];
    mobileno = [accountArray valueForKey:@"mobileno"];
    emailadd = [accountArray valueForKey:@"emailadd"];
    nationality = [accountArray valueForKey:@"nationality"];
    work = [accountArray valueForKey:@"natureOfWork"];
    
    
    
    answer1 = [accountArray valueForKey:@"secanswer1"];
    answer2 = [accountArray valueForKey:@"secanswer2"];
    answer3 = [accountArray valueForKey:@"secanswer3"];
    question1 = [accountArray valueForKey:@"secquestion1"];
    question2 = [accountArray valueForKey:@"secquestion2"];
    question3 = [accountArray valueForKey:@"secquestion3"];
    
    walletNo = [accountArray valueForKey:@"walletno"];
    
    respMessage = [accountArray valueForKey:@"respmessage"];
    resCode = [accountArray valueForKey:@"respcode"];
    
    photo1 = [accountArray valueForKey:@"photo1"];
    photo2 = [accountArray valueForKey:@"photo2"];
    photo3 = [accountArray valueForKey:@"photo3"];
    photo4 = [accountArray valueForKey:@"photo4"];
    
    
    
    //Format date====================================================
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    date = [dateFormatter dateFromString:bdate];
    [dateFormatter setDateFormat:@"MMM. dd, yyyy"];
    NSString *finalDateString = [dateFormatter stringFromDate:date];
    //End Format Date===============================================
    
    
    
    [self saveToPaylist];
    
    
    //CONVERT STRING TO IMAGE===========================================
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    [profileImageView setImage:[UIImage imageWithData:data]];
    //==================================================================
    
    
    
    
    //DISPLAY ACCOUNT INFORMATION LABEL===============================
    [nameLabel setText:[NSString stringWithFormat:@"%@ %@. %@", firstName, middleName, lastName]];
    [bdayLabel setText:[NSString stringWithFormat:@"%@", finalDateString]];
    [countryLabel setText:[NSString stringWithFormat:@"%@", country]];
    //================================================================
    
    
    
    
}

-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    int userAge = [self userAge:date];
    
    [saveData initSaveData:firstName forKey:@"fname"];
    [saveData initSaveData:middleName forKey:@"mname"];
    [saveData initSaveData:lastName forKey:@"lname"];
    [saveData initSaveData:country forKey:@"country"];
    [saveData initSaveData:province forKey:@"provinceCity"];
    [saveData initSaveData:address forKey:@"permanentAdd"];
    [saveData initSaveData:zipcode forKey:@"zipcode"];
    [saveData initSaveData:gender forKey:@"gender"];
    [saveData initSaveData:bdate forKey:@"bdate"];
    
    [saveData initSaveData:[NSString stringWithFormat:@"%i", userAge] forKey:@"age"];
    [saveData initSaveData:mobileno forKey:@"mobileno"];
    [saveData initSaveData:emailadd forKey:@"emailadd"];
    [saveData initSaveData:nationality forKey:@"nationality"];
    [saveData initSaveData:work forKey:@"natureOfWork"];
    
    
    [saveData initSaveData:answer1 forKey:@"secanswer1"];
    [saveData initSaveData:answer2 forKey:@"secanswer2"];
    [saveData initSaveData:answer3 forKey:@"secanswer3"];
    [saveData initSaveData:question1 forKey:@"secquestion1"];
    [saveData initSaveData:question2 forKey:@"secquestion2"];
    [saveData initSaveData:question3 forKey:@"secquestion3"];
    
    
    [saveData initSaveData:walletNo forKey:@"walletno"];
    
    
    [saveData initSaveData:photo1 forKey:@"photo1"];
    [saveData initSaveData:photo2 forKey:@"photo2"];
    [saveData initSaveData:photo3 forKey:@"photo3"];
    [saveData initSaveData:photo4 forKey:@"photo4"];
    
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)profileButtonClicked:(id) sender{
    ProfileInformation *profileInfo = [[ProfileInformation alloc] initWithNibName:@"ProfileInformation" bundle:nil];
   
    [self.navigationController pushViewController:profileInfo animated:YES];
}

-(void)accountButtonClicked:(id) sender{
    
    
    AccountInformation *accountInfo = [[AccountInformation alloc] initWithNibName:@"AccountInformation" bundle:nil];
    
    [self.navigationController pushViewController:accountInfo animated:YES];
}



-(void)addNavigationBarButton{
    
    
//    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStyleBordered target:self action:@selector(profileButtonClicked:)];
//    
//    UIBarButtonItem *account = [[UIBarButtonItem alloc] initWithTitle:@"Account" style:UIBarButtonItemStyleBordered target:self action:@selector(accountButtonClicked:)];
//
//    
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationItem setLeftBarButtonItem:account];
//    [self.navigationItem setRightBarButtonItem:profile];
    
    // LEFT NAVIGATION BUTTON
    
    
//    UIView *profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    
//    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [profileButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    [profileButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [profileView addSubview:profileButton];
//    
//    UIBarButtonItem *profileNavButton = [[UIBarButtonItem alloc] initWithCustomView:profileView];
//    [profileNavButton setStyle:UIBarButtonItemStyleBordered];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"My Information";
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backPressed:)];
  
    
    
    
    
    
    
    //ADDING THE LEFT AND RIGHT BUTTON
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:buttonHome];

    
}

-(void)backPressed:(id)sender{
    
    self.navigationController.navigationBarHidden = YES;
    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuPage animated:YES];
    
}



-(int) userAge:(NSDate *)birthDay{
    
    NSDate* currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:birthDay];
    int days = secondsBetween / 86400;
    int  age = days/ 364 ;
    return age;
}


@end
