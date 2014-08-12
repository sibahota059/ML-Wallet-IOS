//
//  EditPasswordPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditPasswordPad.h"
#import "NSDictionary+LoadWalletData.h"

@interface EditPasswordPad ()

@end

@implementation EditPasswordPad

UIScrollView *profileScroll;

NSDictionary *loadData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(768, 400)];
    
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    
    [self.view addSubview:profileScroll];
    
    [self createPasswordLabel];
    
    [self createPasswordValue];
    
    [self addNavigationBarButton];
}





//-(void) loadFromPlaylist{
//    
//    firstNameValue = [loadData objectForKey:@"fname"];
//    middleNameValue = [loadData objectForKey:@"mname"];
//    lastNameValue = [loadData objectForKey:@"lname"];
//    countryValue =[loadData objectForKey:@"country"];
//    provinceValue =[loadData objectForKey:@"provinceCity"];
//    addressValue =[loadData objectForKey:@"permanentAdd"];
//    zipcodeValue =[loadData objectForKey:@"zipcode"];
//    genderValue =[loadData objectForKey:@"gender"];
//    birthdateValue =[loadData objectForKey:@"bdate"];
//    ageValue =[loadData objectForKey:@"age"];
//    mobileNumberValue =[loadData objectForKey:@"mobileno"];
//    
//    emailValue =[loadData objectForKey:@"emailadd"];
//    workValue =[loadData objectForKey:@"natureOfWork"];
//    nationalityValue =[loadData objectForKey:@"nationality"];
//    
//    photo1Value =[loadData objectForKey:@"photo1"];
//    photo2Value =[loadData objectForKey:@"photo2"];
//    photo3Value =[loadData objectForKey:@"photo3"];
//    photo4Value =[loadData objectForKey:@"photo2"];
//    
//    
//    question1 =[loadData objectForKey:@"secquestion1"];
//    question2 =[loadData objectForKey:@"secquestion2"];
//    question3 =[loadData objectForKey:@"secquestion3"];
//    answer1 =[loadData objectForKey:@"secanswer1"];
//    answer2 =[loadData objectForKey:@"secanswer2"];
//    answer3 =[loadData objectForKey:@"secanswer3"];
//    
//    
//    
//    
//}

//-(void) setInfo{
//    [firstName setText:firstNameValue];
//    [middleName setText:middleNameValue];
//    [lastName setText:lastNameValue];
//    [country setText:countryValue];
//    [province setText:provinceValue];
//    [address setText:addressValue];
//    [zipcode setText:zipcodeValue];
//    [gender setText:genderValue];
//    
//    //FORMAT DATE====================================================
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [dateFormatter dateFromString:birthdateValue];
//    [dateFormatter setDateFormat:@"MMM. dd, yyyy"];
//    NSString *finalDateString = [dateFormatter stringFromDate:date];
//    //End Format Date===============================================
//    
//    [birthdate setText:finalDateString];
//    [age setText:ageValue];
//    [mobileNumber setText:mobileNumberValue];
//    [email setText:emailValue];
//    [work setText:workValue];
//    [nationality setText:nationalityValue];
//    
//    
//    
//    
//    //CONVERTING STRING INTO IMAGE=================================================
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    [profileImage setImage:[UIImage imageWithData:data]];
//    
//    NSData *data1 = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    [image1 setImage:[UIImage imageWithData:data1]];
//    
//    
//    NSData *data2 = [[NSData alloc]initWithBase64EncodedString:photo2Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    [image2 setImage:[UIImage imageWithData:data2]];
//    
//    
//    NSData *data3 = [[NSData alloc]initWithBase64EncodedString:photo3Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    [image3 setImage:[UIImage imageWithData:data3]];
//    
//    
//    NSData *data4 = [[NSData alloc]initWithBase64EncodedString:photo4Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    [image4 setImage:[UIImage imageWithData:data4]];
//    
//    //================================================================================
//    
//    
//    
//    dialog = [[QuestionVerificationDialogPad alloc] initWithFrame:CGRectMake(0, 0, 768, 1120) addTarget:self action:@selector(goToEdit:) forControlEvents:UIControlEventTouchUpInside addQuestion1:question1 addQuestion2:question2 addQuestion3:question3];
//    
//    
//    [dialog setHidden:YES];
//    
//    
//    
//    
//    
//    [profileName setText:[NSString stringWithFormat:@"%@ %@. %@",firstNameValue, middleNameValue, lastNameValue]];
//    [profilePhone setText:mobileNumberValue];
//    [profileEmail setText:emailValue];
//    
//    
//    
//}















-(void) createPasswordLabel{
    
    
    //Country
    
    
    //Old Password
    UILabel *oldPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 200, 250, 30)];
    [oldPasswordLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [oldPasswordLabel setText:@"Type your old password"];
    
    
    //New Password
    UILabel *newPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 270, 250, 30)];
    [newPasswordLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [newPasswordLabel setText:@"Type your new password"];
    
    
    //Confirm Password
    UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 340, 250, 30)];
    [confirmPasswordLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [confirmPasswordLabel setText:@"Confirm your new password"];
    
    
    [profileScroll addSubview:oldPasswordLabel];
    [profileScroll addSubview:newPasswordLabel];
    [profileScroll addSubview:confirmPasswordLabel];
    
}

-(void) createPasswordValue{
    

    //Old Password
    UIView *oldPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 230, 434, 35)];
    [oldPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [oldPassword setBackgroundColor:[UIColor whiteColor]];
    [oldPassword setFont:[UIFont systemFontOfSize:19.0f]];
    [oldPassword setPlaceholder:@" Old Password"];
    [oldPasswordOutline addSubview:oldPassword];
    
    
    
    //New Password
    UIView *newPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 300, 434, 35)];
    [newPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [newPassword setBackgroundColor:[UIColor whiteColor]];
    [newPassword setFont:[UIFont systemFontOfSize:19.0f]];
    [newPassword setPlaceholder:@" New Password"];
    [newPasswordOutline addSubview:newPassword];
    
    
    //Address
    UIView *confirmPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 370, 434, 35)];
    [confirmPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [confirmPassword setBackgroundColor:[UIColor whiteColor]];
    [confirmPassword setFont:[UIFont systemFontOfSize:19.0f]];
    [confirmPassword setPlaceholder:@" Confirm Password"];
    [confirmPasswordOutline addSubview:confirmPassword];
    
    
    [profileScroll addSubview:oldPasswordOutline];
    [profileScroll addSubview:newPasswordOutline];
    [profileScroll addSubview:confirmPasswordOutline];
    
    
}









- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Password";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    //    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}


-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
