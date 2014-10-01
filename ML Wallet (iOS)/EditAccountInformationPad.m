//
//  EditAccountInformationPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditAccountInformationPad.h"
#import "ProfileImage.h"
#import "ProfileOutline.h"
#import "ProfileTextField.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"



@interface EditAccountInformationPad ()

@end

@implementation EditAccountInformationPad

EditAccountInfoWebService *editAccountInfoWS;

MBProgressHUD *HUD;

UIImage *image1, *image2, *image3, *image4;

UIImageView *imageView1, *imageView2, *imageView3, *imageView4;
UIImageView *userImage;
UIImage *userProfileImage, *mainImage;
UIScrollView *profileScroll;

UIImageView *profileImage;

UILabel *profileName, *profileEmail, *profilePhone;

NSDictionary *loadData;

NSData *data1, *data2, *data3, *data4;

UITextField *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


NSString *wallet, *firstNameValue, *middleNameValue, *lastNameValue, *countryValue, *provinceValue, *addressValue, *zipcodeValue, *genderValue, *birthdateValue, *ageValue, *mobileNumberValue, *emailValue, *workValue, *nationalityValue, *photo1Value, *photo2Value, *photo3Value, *photo4Value, *answer1, *answer2, *answer3, *question1, *question2, *question3;

NSString *finalCountry, *finalProvince, *finalAddress, *finalZipcode, *finalGender, *finalNumber, *finalWork, *finalNationality;

int whichImage1, whichImage2, whichImage3, whichImage4;

int hasSelectedPad = 0;

Boolean genderClicked, mobileClicked, workClicked, nationalityClicked;

UIView *genderUI;
UIView *imageSelectionView;
UIView *backgroundSelectionView;

NSString *strImage1, *strImage2, *strImage3, *strImage4;
- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1100)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(768, 1300)];
    
    editAccountInfoWS = [EditAccountInfoWebService new];
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;

    
    [self initializeImageIndicator];
    [self loadFromPlaylist];
    [self createImageInfo];
    [self createAccountLabel];
    [self createAccountValue];
    [self setInfo];
    [self selectGender];
    
    mobileClicked = NO;
    workClicked = NO;
    nationalityClicked = NO;
    genderClicked = YES;
    
    [self.view addSubview:profileScroll];
    [self addNavigationBarButton];
    editAccountInfoWS.delegate = self;
}

-(void) createImageInfo{
    

    
    UIView *imageFrameView = [[UIView alloc] initWithFrame:CGRectMake(167, 44, 150, 150)];
    [imageFrameView setBackgroundColor:[UIColor redColor]];
    
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 146, 146)];

    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(327, 70, 400, 30)];
    [profileName setFont:[UIFont fontWithName:nil size:22.0f]];
   
    
    profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(327, 95, 400, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:19.0f]];
    
    profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(327, 116, 400, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:19.0f]];
    
    UIButton *browsePicture = [[UIButton alloc] initWithFrame:CGRectMake(327, 160, 270, 30)];
    [browsePicture setBackgroundColor:[UIColor redColor]];
    [browsePicture addTarget:self action:@selector(selectPicture:) forControlEvents:UIControlEventTouchUpInside];
    [browsePicture setTitle:@"Browse Picture" forState:UIControlStateNormal];

    
    ProfileOutline *imageCollectionView = [[ProfileOutline alloc] initWithFrame:CGRectMake(167, 225, 434, 110)];
    
    [imageCollectionView setBackgroundColor:[UIColor redColor]];

    
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 106, 106)];
    
    
    UILabel *idFrontLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 106, 20)];
    [idFrontLabel1 setFont:[UIFont fontWithName:nil size:19.0f]];
    [idFrontLabel1 setTextAlignment: NSTextAlignmentCenter];
    [idFrontLabel1 setText:@"ID1: Front"];
    [imageView1 addSubview:idFrontLabel1];

    
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(110, 2, 106, 106)];
    
    UILabel *idBackLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 106, 20)];
    [idBackLabel1 setFont:[UIFont fontWithName:nil size:19.0f]];
    [idBackLabel1 setTextAlignment: NSTextAlignmentCenter];
    [idBackLabel1 setText:@"ID1: Back"];
    [imageView2 addSubview:idBackLabel1];
    
    
    
    
    imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 106, 106)];
    
    UILabel *idFrontLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 106, 20)];
    [idFrontLabel2 setFont:[UIFont fontWithName:nil size:19.0f]];
    [idFrontLabel2 setTextAlignment: NSTextAlignmentCenter];
    [idFrontLabel2 setText:@"ID2: Front"];
    [imageView3 addSubview:idFrontLabel2];

    
    
    
    imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(326, 2, 106, 106)];
    
    UILabel *idBackLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 106, 20)];
    [idBackLabel2 setFont:[UIFont fontWithName:nil size:19.0f]];
    [idBackLabel2 setTextAlignment: NSTextAlignmentCenter];
    [idBackLabel2 setText:@"ID2: Back"];
    [imageView4 addSubview:idBackLabel2];
    
    
    [imageCollectionView addSubview:imageView1];
    [imageCollectionView addSubview:imageView2];
    [imageCollectionView addSubview:imageView3];
    [imageCollectionView addSubview:imageView4];

    [imageFrameView addSubview:profileImage];
    
    //  ADD GESTURE RECOGNIZER TO THE 4 IMAGE================================================
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked1:)];
    singleTap1.numberOfTapsRequired = 1;
    singleTap1.numberOfTouchesRequired = 1;
    [imageView1 addGestureRecognizer:singleTap1];
    [imageView1 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked2:)];
    singleTap2.numberOfTapsRequired = 1;
    singleTap2.numberOfTouchesRequired = 1;
    [imageView2 addGestureRecognizer:singleTap2];
    [imageView2 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked3:)];
    singleTap3.numberOfTapsRequired = 1;
    singleTap3.numberOfTouchesRequired = 1;
    [imageView3 addGestureRecognizer:singleTap3];
    [imageView3 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked4:)];
    singleTap4.numberOfTapsRequired = 1;
    singleTap4.numberOfTouchesRequired = 1;
    [imageView4 addGestureRecognizer:singleTap4];
    [imageView4 setUserInteractionEnabled:YES];
    
    [profileScroll addSubview:imageFrameView];
    [profileScroll addSubview:profileName];
    [profileScroll addSubview:profilePhone];
    [profileScroll addSubview:profileEmail];
    [profileScroll addSubview:browsePicture];
    
    
    [profileScroll addSubview:imageCollectionView];
    
    
}

-(void) createAccountLabel{
    
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(249, 355, 270, 40)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:30.0f]];
    [accountInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Account Information"];
    
    
    //ProfileInformationLabel
    
    
    
    //Country
    UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(167, 395, 200, 30)];
    [profileCountry setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileCountry setText:@"Country: "];
    
    
    //Province
    UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(167, 465, 200, 30)];
    [profileProvince setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileProvince setText:@"Province: "];
    
    
    //Address
    UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(167, 535, 200, 30)];
    [profileAddress setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileAddress setText:@"Address: "];
    
    
    //ZipCode
    UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(167, 605, 200, 30)];
    [profileZipcode setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileZipcode setText:@"Zipcode: "];
    
    
    //Gender
    UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(167, 675, 200, 30)];
    [profileGender setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileGender setText:@"Gender: "];
    
    //Number
    UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(167, 745, 200, 30)];
    [profileNumber setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileNumber setText:@"Mobile Number: "];
    
    
   
    
    //Work
    UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(167, 815, 200, 30)];
    [profileWork setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileWork setText:@"Nature of Work: "];
    
    
    //Nationality
    UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(167, 885, 200, 30)];
    [profileNationality setFont:[UIFont fontWithName:nil size:19.0f]];
    [profileNationality setText:@"Nationality: "];
    
    
    [profileScroll addSubview:accountInfoLabel];
    
    [profileScroll addSubview:profileCountry];
    [profileScroll addSubview:profileProvince];
    [profileScroll addSubview:profileAddress];
    [profileScroll addSubview:profileZipcode];
    [profileScroll addSubview:profileGender];
    [profileScroll addSubview:profileNumber];
    [profileScroll addSubview:profileWork];
    [profileScroll addSubview:profileNationality];
    
}

-(void) createAccountValue{
    
    
    //Country
    UIView *leftMarginCountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    country = [[UITextField alloc] initWithFrame:CGRectMake(169, 427, 434, 35)];
    country.layer.cornerRadius = 8.0f;
    country.layer.masksToBounds = YES;
    country.layer.borderColor=[[UIColor redColor]CGColor];
    country.layer.borderWidth = 1.0f;
    country.leftView = leftMarginCountry;
    country.leftViewMode = UITextFieldViewModeAlways;
    [country setBackgroundColor:[UIColor whiteColor]];
    [country setReturnKeyType:UIReturnKeyNext];
    
    
    
    //Province
    UIView *leftMarginProvince = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    province = [[UITextField alloc] initWithFrame:CGRectMake(169, 497, 434, 35)];
    province.layer.cornerRadius = 8.0f;
    province.layer.masksToBounds = YES;
    province.layer.borderColor=[[UIColor redColor]CGColor];
    province.layer.borderWidth = 1.0f;
    province.leftView = leftMarginProvince;
    province.leftViewMode = UITextFieldViewModeAlways;
    [province setBackgroundColor:[UIColor whiteColor]];
    [province setReturnKeyType:UIReturnKeyNext];
    
    
    //Address
    UIView *leftMarginAddress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    address = [[UITextField alloc] initWithFrame:CGRectMake(169, 567, 434, 35)];
    address.layer.cornerRadius = 8.0f;
    address.layer.masksToBounds = YES;
    address.layer.borderColor=[[UIColor redColor]CGColor];
    address.layer.borderWidth = 1.0f;
    address.leftView = leftMarginAddress;
    address.leftViewMode = UITextFieldViewModeAlways;
    [address setBackgroundColor:[UIColor whiteColor]];
    [address setReturnKeyType:UIReturnKeyNext];
    
    
    
    //ZipCode
    UIView *leftMarginZipCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    zipcode = [[UITextField alloc] initWithFrame:CGRectMake(169, 637, 434, 35)];
    zipcode.layer.cornerRadius = 8.0f;
    zipcode.layer.masksToBounds = YES;
    zipcode.layer.borderColor=[[UIColor redColor]CGColor];
    zipcode.layer.borderWidth = 1.0f;
    zipcode.leftView = leftMarginZipCode;
    zipcode.leftViewMode = UITextFieldViewModeAlways;
    [zipcode setBackgroundColor:[UIColor whiteColor]];
    [zipcode setReturnKeyType:UIReturnKeyNext];
    [zipcode setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    
    //Gender
    UIView *leftMarginGender = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    gender = [[UITextField alloc] initWithFrame:CGRectMake(169, 707, 434, 35)];
    gender.layer.cornerRadius = 8.0f;
    gender.layer.masksToBounds = YES;
    gender.layer.borderColor=[[UIColor redColor]CGColor];
    gender.layer.borderWidth = 1.0f;
    gender.leftView = leftMarginGender;
    gender.leftViewMode = UITextFieldViewModeAlways;
    [gender setBackgroundColor:[UIColor whiteColor]];
    [gender setReturnKeyType:UIReturnKeyNext];
    gender.enabled = NO;
    
    UIControl *genderSelection = [[UIControl alloc] initWithFrame:gender.frame];
    [genderSelection addTarget:self action:@selector(showGenderSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //Mobile Number
    UIView *leftMarginNumber = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    mobileNumber = [[UITextField alloc] initWithFrame:CGRectMake(169, 777, 434, 35)];
    mobileNumber.layer.cornerRadius = 8.0f;
    mobileNumber.layer.masksToBounds = YES;
    mobileNumber.layer.borderColor=[[UIColor redColor]CGColor];
    mobileNumber.layer.borderWidth = 1.0f;
    mobileNumber.leftView = leftMarginNumber;
    mobileNumber.leftViewMode = UITextFieldViewModeAlways;
    [mobileNumber setBackgroundColor:[UIColor whiteColor]];
    [mobileNumber setReturnKeyType:UIReturnKeyNext];
    [mobileNumber setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    //Work
    UIView *leftMarginWork = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    work = [[UITextField alloc] initWithFrame:CGRectMake(169, 847, 434, 35)];
    work.layer.cornerRadius = 8.0f;
    work.layer.masksToBounds = YES;
    work.layer.borderColor=[[UIColor redColor]CGColor];
    work.layer.borderWidth = 1.0f;
    work.leftView = leftMarginWork;
    work.leftViewMode = UITextFieldViewModeAlways;
    [work setBackgroundColor:[UIColor whiteColor]];
    [work setReturnKeyType:UIReturnKeyNext];
    
    
    
    //Nationality
    UIView *leftMarginNationality= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    nationality = [[UITextField alloc] initWithFrame:CGRectMake(169, 917, 434, 35)];
    nationality.layer.cornerRadius = 8.0f;
    nationality.layer.masksToBounds = YES;
    nationality.layer.borderColor=[[UIColor redColor]CGColor];
    nationality.layer.borderWidth = 1.0f;
    nationality.leftView = leftMarginNationality;
    nationality.leftViewMode = UITextFieldViewModeAlways;
    [nationality setBackgroundColor:[UIColor whiteColor]];
    [nationality setReturnKeyType:UIReturnKeyDone];
    
    country.delegate = self;
    province.delegate = self;
    address.delegate = self;
    zipcode.delegate = self;
    gender.delegate = self;
    mobileNumber.delegate = self;
    work.delegate = self;
    nationality.delegate = self;
    
    [profileScroll addSubview:country];
    [profileScroll addSubview:province];
    [profileScroll addSubview:address];
    [profileScroll addSubview:zipcode];
    [profileScroll addSubview:gender];
    [profileScroll addSubview:mobileNumber];
    [profileScroll addSubview:work];
    [profileScroll addSubview:nationality];
    [profileScroll addSubview:genderSelection];
    
}







-(void) selectPicture:(id)sender{
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if ( (whichImage1 == 0) && (whichImage2 == 0) && (whichImage3 == 0) && (whichImage4 == 0))
    {
        [alert setMessage:@"Please select which image to edit."];
        
        [alert show];
    }
    else if (([UIImage imageWithData:data1] == nil) &&(whichImage2 == 1))
    {
        [alert setMessage:@"Your first picture slot has no picture, please select a picture there first."];
        
        [alert show];
    }
    else if(([UIImage imageWithData:data2] == nil) &&(whichImage3 == 1))
    {
        [alert setMessage:@"Your second picture slot has no picture, please select a picture there first."];
        
        [alert show];
    }
    else if(([UIImage imageWithData:data3] == nil) &&(whichImage4 == 1))
    {
        [alert setMessage:@"Your third picture slot has no picture, please select a picture there first."];
        
        [alert show];
    }
    else
    {
        
        //        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        //        picker.delegate         = self;
        //        picker.allowsEditing    = YES;
        //        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        //
        //        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        [self.navigationController presentViewController:picker animated:YES completion:nil];
        [self openImageSelection];
    }
}

-(void)imageClicked1:(id)sender{
    
    UIImage *userImage1 = [UIImage imageWithData:data1];
    if (userImage1 == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:userImage1];
        mainImage = userImage1;
    }
    
    userProfileImage = userImage1;
    [self initializeImageIndicator];
    whichImage1 = 1;
}

-(void)imageClicked2:(id)sender{
    
    UIImage *userImage2 = [UIImage imageWithData:data2];
    if (userImage2 == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:userImage2];
        mainImage = userImage2;
    }
    userProfileImage = userImage2;
    [self initializeImageIndicator];
    whichImage2 = 1;
}

-(void)imageClicked3:(id)sender{
    UIImage *userImage3 = [UIImage imageWithData:data3];
    if (userImage3 == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:userImage3];
        mainImage = userImage3;
    }
    userProfileImage = userImage3;
    [self initializeImageIndicator];
    whichImage3 = 1;
}

-(void)imageClicked4:(id)sender{
    
    UIImage *userImage4 = [UIImage imageWithData:data4];
    if (userImage4 == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:userImage4];
        mainImage = userImage4;
    }
    userProfileImage = userImage4;
    [self initializeImageIndicator];
    whichImage4 = 1;
}







-(void) loadFromPlaylist{
    
    
    wallet = [loadData objectForKey:@"walletno"];
    firstNameValue = [loadData objectForKey:@"fname"];
    middleNameValue = [loadData objectForKey:@"mname"];
    lastNameValue = [loadData objectForKey:@"lname"];
    
    countryValue =[loadData objectForKey:@"country"];
    provinceValue =[loadData objectForKey:@"provinceCity"];
    addressValue =[loadData objectForKey:@"permanentAdd"];
    zipcodeValue =[loadData objectForKey:@"zipcode"];
    genderValue =[loadData objectForKey:@"gender"];
    
    mobileNumberValue =[loadData objectForKey:@"mobileno"];
    
    workValue =[loadData objectForKey:@"natureOfWork"];
    nationalityValue =[loadData objectForKey:@"nationality"];
    
    photo1Value =[loadData objectForKey:@"photo1"];
    photo2Value =[loadData objectForKey:@"photo2"];
    photo3Value =[loadData objectForKey:@"photo3"];
    photo4Value =[loadData objectForKey:@"photo4"];
    
}

-(void) setInfo{
    
    UIImage *noImage = [UIImage imageNamed:@"noImage.png"];
    
    //CONVERTING STRING INTO IMAGE=================================================
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    userProfileImage = [UIImage imageWithData:data];
    if (userProfileImage == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:[UIImage imageWithData:data]];
        mainImage = userProfileImage;
    }
    
    
    
    data1 = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage1 = [UIImage imageWithData:data1];
    if (userImage1 == nil)
    {
        image1 = nil;
        imageView1.image = noImage;
    }
    else
    {
        image1 = [[UIImage alloc] initWithData:data1];
        imageView1.image = image1;
        hasSelectedPad = 1;
        
    }
    
    
    
    
    
    
    
    data2 = [[NSData alloc]initWithBase64EncodedString:photo2Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage2 = [UIImage imageWithData:data2];
    
    if (userImage2 == nil)
    {
        image2 = nil;
        imageView2.image = noImage;
    }
    else
    {
        image2 = [[UIImage alloc] initWithData:data2];
        imageView2.image = image2;
        hasSelectedPad = 1;
        
    }
    
    
    data3 = [[NSData alloc]initWithBase64EncodedString:photo3Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage3 = [UIImage imageWithData:data3];
    if (userImage3 == nil)
    {
        image3 = nil;
        imageView3.image = noImage;
    }
    else
    {
        image3 = [[UIImage alloc] initWithData:data3];
        imageView3.image = image3;
        hasSelectedPad = 1;
        
        
    }
    
    
    data4 = [[NSData alloc]initWithBase64EncodedString:photo4Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage4 = [UIImage imageWithData:data4];
    if (userImage4 == nil)
    {
        image4 = nil;
        imageView4.image = noImage;
        
        
    }
    else
    {
        image4 = [[UIImage alloc] initWithData:data4];
        imageView4.image = image4;
        hasSelectedPad = 1;
        
    }
    
    //================================================================================
    
    
    [profileName setText:[NSString stringWithFormat:@"%@ %@. %@",firstNameValue, middleNameValue, lastNameValue]];
    [profilePhone setText:mobileNumberValue];
    [profileEmail setText:emailValue];
    
    [country setText:[NSString stringWithFormat:@"%@", countryValue]];
    [province setText:[NSString stringWithFormat:@"%@", provinceValue]];
    [address setText:[NSString stringWithFormat:@"%@", addressValue]];
    [zipcode setText:[NSString stringWithFormat:@"%@", zipcodeValue]];
    
    NSString *finalGenderDisplay;
    if([genderValue isEqualToString:@"F"] )
    {
        finalGenderDisplay = @"Female";
    }
    else if([genderValue isEqualToString:@"M"] )
    {
        finalGenderDisplay = @"Male";
    }
    else
    {
        finalGenderDisplay = @"Please spicify your gender.";
    }
    
    [gender setText:[NSString stringWithFormat:@"%@", finalGenderDisplay]];
    [mobileNumber setText:[NSString stringWithFormat:@"%@", mobileNumberValue]];
    [work setText:[NSString stringWithFormat:@"%@", workValue]];
    [nationality setText:[NSString stringWithFormat:@"%@", nationalityValue]];
    
    
    
}



#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    CGSize size = CGSizeMake(150, 150);
    
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    hasSelectedPad = 1;
    
    resultImage = [self imageWithImage:resultImage scaledToSize:size];
    
    NSData *imgData= UIImageJPEGRepresentation(resultImage,0.0);
    
    if(whichImage1 == 1)
    {
        data1 = imgData;
        image1 = [[UIImage alloc] initWithData:data1];
        imageView1.image = image1;
        [profileImage setImage:image1];
        userProfileImage = image1;
        mainImage = image1;
        
        
    }
    else if(whichImage2 == 1)
    {
        data2 = imgData;
        image2 = [[UIImage alloc] initWithData:data2];
        imageView2.image = image2;
        [profileImage setImage:image2];
        userProfileImage = image2;
        mainImage = image2;
        
    }
    else if(whichImage3 == 1)
    {
        data3 = imgData;
        image3 = [[UIImage alloc] initWithData:data3];
        imageView3.image = image3;
        [profileImage setImage:image3];
        userProfileImage = image3;
        mainImage = image3;
        
    }
    else if(whichImage4 == 1)
    {
        data4 = imgData;
        image4 = [[UIImage alloc] initWithData:data4];
        imageView4.image = image4;
        [profileImage setImage:image4];
        userProfileImage = image4;
        mainImage = image4;
        
    }
    
    
    [backgroundSelectionView removeFromSuperview];
    [imageSelectionView removeFromSuperview];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Account Information";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    //RIGHT NAVIGATION BUTTON
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [saveButton setImage:[UIImage imageNamed:@"my_save.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveView addSubview:saveButton];
    
    UIBarButtonItem *saveNavButton = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    [saveNavButton setStyle:UIBarButtonItemStyleBordered];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:saveNavButton];
    
}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

-(void)savePressed:(id)sender{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{self.view.frame = CGRectMake(0, 100, 780, 1130); }
                     completion:^(BOOL finished){}];
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    
    
    finalCountry = country.text;
    finalProvince = province.text;
    finalAddress = address.text;
    finalZipcode = zipcode.text;
    finalGender = gender.text;
    finalNumber = mobileNumber.text;
    finalWork = work.text;
    finalNationality = nationality.text;
    
    
    
    if([finalGender isEqualToString:@"Female"])
    {
        finalGender = @"F";
    }
    else if([finalGender isEqualToString:@"Male"])
    {
        finalGender = @"M";
    }
    else
    {
        finalGender = @"X";
    }
    
    
    
    if (hasSelectedPad == 0)
    {
        [saveAlert setMessage:@"Please select atleast 1 picture."];
        [saveAlert show];
        
    }
    else if(userProfileImage == nil)
    {
        [saveAlert setMessage:@"Please select your profile picture."];
        [saveAlert show];
    }
    else if([finalCountry isEqualToString:@""] || [finalProvince isEqualToString:@""] || [finalAddress isEqualToString:@""] || [finalZipcode isEqualToString:@""] || [finalGender isEqualToString:@""] || [finalNumber isEqualToString:@""] || [finalWork isEqualToString:@""] || [finalNationality isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    else if([[finalNumber substringFromIndex:2] isEqualToString:@"09"])
    {
        [saveAlert setMessage:@"Mobile Number must begin with 09"];
        [saveAlert show];
    }
    else if(![gender.text isEqualToString:@"Male"] && ![gender.text isEqualToString:@"Female"])
    {
        [saveAlert setMessage:@"Gender must only be \"Male\" or \"Female\"."];
        [saveAlert show];
    }
    else if (finalNumber.length < 10)
    {
        [saveAlert setMessage:@"Mobile Number must have 10 digits."];
        [saveAlert show];
    }
    else
    {
        
        strImage1 = [self encodeToBase64String:mainImage];
        
        if(strImage1 == nil)
        {
            strImage1 = @"";
            
        }
        
        strImage2 = [self encodeToBase64String:image2];
        if(strImage2 == nil)
        {
            strImage2 = @"";
        }
        
        strImage3 = [self encodeToBase64String:image3];
        if(strImage3 == nil)
        {
            strImage3 = @"";
        }
        
        strImage4 = [self encodeToBase64String:image4];
        if(strImage4 == nil)
        {
            strImage4 = @"";
        }
        
        
        if(whichImage4 == 1)
        {
            strImage4 = [self encodeToBase64String:image1];
        }
        else if(whichImage3 == 1)
        {
            strImage3 = [self encodeToBase64String:image1];
        }
        else if(whichImage2 == 1)
        {
            strImage2 = [self encodeToBase64String:image1];
        }
        
        [editAccountInfoWS wallet:wallet country:finalCountry province:finalProvince address:finalAddress zipcode:finalZipcode gender:finalGender mnumber:finalNumber work:finalWork nationality:finalNationality photo1:strImage1 photo2:strImage2 photo3:strImage3 photo4:strImage4];
        
        [self displayProgressBar];
        
    }
    
    
    
    
    
    
}



-(void)didFinishEditingAccount:(NSString *)indicator andError:(NSString *)getError{
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [self dismissProgressBar];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editAccountInfoWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:editAccountInfoWS.respmessage];
        [self saveToPaylist];
    }
    else if ([[NSString stringWithFormat:@"%@", editAccountInfoWS.respcode] isEqualToString:@"0"])
        
    {
        [resultAlertView setMessage:editAccountInfoWS.respmessage];
        
    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in updating User account."];
    }else{
        
        [resultAlertView setMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" ];
    }
    
    [resultAlertView show];
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) initializeImageIndicator{
    whichImage1 = 0;
    whichImage2 = 0;
    whichImage3 = 0;
    whichImage4 = 0;
}

- (void)displayProgressBar{
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
}

- (void)dismissProgressBar{
    
    [HUD hide:YES];
    [HUD show:NO];
    
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}








- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    int animateUp = 0;
    
    if (textField == country)
    {
        profileScroll.frame = CGRectMake(0, 0, 780, 1130);
    }
    else if(textField == province)
    {
        profileScroll.frame = CGRectMake(0, 0, 780, 1130);
    }
    else if(textField == address)
    {        profileScroll.frame = CGRectMake(0, 0, 780, 1130);
    }
    else if(textField == zipcode)
    {
        profileScroll.frame = CGRectMake(0, 0, 780, 1130);
    }
    else if(textField == mobileNumber)
    {
        mobileClicked = YES;
        animateUp = -210;
        profileScroll.frame = CGRectMake(0, 0, 780, 1330);
    }
    else if(textField == work)
    {
        workClicked = YES;
        animateUp = -270;
        profileScroll.frame = CGRectMake(0, 0, 780, 1330);
    }
    else if(textField == nationality)
    {
        animateUp = -330;
        profileScroll.frame = CGRectMake(0, 0, 780, 1530);
        
    }
    else
    {
        animateUp = 100;
        
    }

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{self.view.frame = CGRectMake(0, animateUp, 780, 1530); }
                     completion:^(BOOL finished){}];
    
    return YES;


    
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"SHOULD_RETURN");
    if (textField == country)
    {
        [province becomeFirstResponder];
    }
    else if(textField == province)
    {
        [address becomeFirstResponder];
    }
    else if(textField == address)
    {
        [zipcode becomeFirstResponder];
    }
    else if(textField == zipcode)
    {
        [genderUI setHidden:NO];
        [zipcode resignFirstResponder];
    }
    
    else if(textField == mobileNumber)
    {
        mobileClicked = NO;
        [work becomeFirstResponder];
        
    }
    else if(textField == work)
    {
        workClicked = NO;
        [nationality becomeFirstResponder];
       
    }
    else if(textField == nationality)
    {
        profileScroll.frame = CGRectMake(0, 0, 780, 1130);
        [textField resignFirstResponder];
        
        
        
    }
    
    

    
    return YES;
    
}


- (void) textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"END_EDITING");
    if(textField == mobileNumber)
    {
        
        
            if(mobileClicked == YES)
            {
                profileScroll.frame = CGRectMake(0, 0, 780, 1130);
                [mobileNumber resignFirstResponder];
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{self.view.frame = CGRectMake(0, 100, 780, 1130);
                                 }
                                 completion:^(BOOL finished){}];
                
                
            }
            mobileClicked = NO;
      

    }
    else if(textField == work)
    {
        if(workClicked == YES)
        {

                profileScroll.frame = CGRectMake(0, 0, 780, 1130);
                [work resignFirstResponder];
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{self.view.frame = CGRectMake(0, 100, 780, 1130);
                                 }
                                 completion:^(BOOL finished){}];
 
        }
        workClicked = NO;
        
    }
    else if(textField == nationality)
    {
       
    
                profileScroll.frame = CGRectMake(0, 0, 780, 1130);
                [work resignFirstResponder];
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{self.view.frame = CGRectMake(0, 100, 780, 1130);
                                 }
                                 completion:^(BOOL finished){}];

    }

}








-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if((textField == zipcode) || (textField == mobileNumber))
    {
        // Check for non-numeric characters
        NSUInteger lengthOfString = string.length;
        for (NSInteger index = 0; index < lengthOfString; index++)
        {
            unichar character = [string characterAtIndex:index];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        // Check for total length
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        int maxSize = 0;
        if(textField == zipcode)
            maxSize = 4;
        else if(textField == mobileNumber)
            maxSize = 11;
        
        if(textField.text.length > maxSize - 1)
        {
            if([string isEqualToString:@""] && range.length == 1)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }else
        {
            if (proposedNewLength > 6)
                return YES;
        }
        
        
    }
    
    
    
    
    
    if (textField == nationality)
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
        
        if([string isEqualToString:@""] && range.length == 1)
        {
            return YES;
        }else if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else {
        return YES;
    }
    
    
    
    return YES;
}





- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}









//FOR GENDER================================================>

-(void)selectGender{
    
    genderUI = [[UIView alloc] initWithFrame:CGRectMake(169, 707, 434, 58)];
    [genderUI setBackgroundColor:[UIColor blackColor]];
    
    
    UILabel *male = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 430, 26)];
    [male setFont:[UIFont fontWithName:nil size:20.0f]];
    [male setBackgroundColor:[UIColor whiteColor]];
    [male setTextAlignment:NSTextAlignmentCenter];
    [male setText:@"Male"];
    
    UIControl *maleLabel = [[UIControl alloc] initWithFrame:male.frame];
    [maleLabel addTarget:self action:@selector(maleSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *female = [[UILabel alloc] initWithFrame:CGRectMake(2, 30, 430, 26)];
    [female setFont:[UIFont fontWithName:nil size:20.0f]];
    [female setBackgroundColor:[UIColor whiteColor]];
    [female setTextAlignment:NSTextAlignmentCenter];
    [female setText:@"Female"];
    
    UIControl *femaleLabel = [[UIControl alloc] initWithFrame:female.frame];
    [femaleLabel addTarget:self action:@selector(femaleSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [genderUI addSubview:male];
    [genderUI addSubview:female];
    [genderUI addSubview:maleLabel];
    [genderUI addSubview:femaleLabel];
    
    
    
    [profileScroll addSubview:genderUI];
    [genderUI setHidden:YES];
    
}

-(void) maleSelected:(id)sender{
    gender.text = @"Male";
    [mobileNumber becomeFirstResponder];
    [genderUI setHidden:YES];
    genderClicked = YES;
    NSLog(@"%hhu", genderClicked);
//    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{self.view.frame = CGRectMake(0, -150, 780, 1130); }
//                     completion:^(BOOL finished){}];


}

-(void) femaleSelected:(id)sender{
    gender.text = @"Female";
    [mobileNumber becomeFirstResponder];
    [genderUI setHidden:YES];
    genderClicked = YES;
    NSLog(@"%hhu", genderClicked);
//    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{self.view.frame = CGRectMake(0, -150, 780, 1130); }
//                     completion:^(BOOL finished){}];

}

-(void) showGenderSelection:(id)sender{
    [genderUI setHidden:NO];
}

//END GENDER================================================>



-(void) openImageSelection{
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = CGRectGetWidth(screen);
    //Bonus height.
    CGFloat height = CGRectGetHeight(screen);
    
    
    backgroundSelectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [backgroundSelectionView setBackgroundColor:[UIColor blackColor]];
    [backgroundSelectionView setOpaque:YES];
    [backgroundSelectionView setAlpha:0.5f];
    
    
    imageSelectionView = [[UIView alloc] initWithFrame:CGRectMake((width/2 - 107), (width/2 - 35), 215, 70)];
    [imageSelectionView setBackgroundColor:[UIColor whiteColor]];
    
    //CAMERA
    UIImageView *cameraBackground = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 60)];
    [cameraBackground setImage:[UIImage imageNamed:@"headerbackground.png"]];
    
    UIImageView *cameraImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 5, 30, 30)];
    [cameraImage setImage:[UIImage imageNamed:@"account_camera.png"]];
    
    UILabel *cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 100, 25)];
    [cameraLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [cameraLabel setTextAlignment:NSTextAlignmentCenter];
    [cameraLabel setTextColor:[UIColor whiteColor]];
    [cameraLabel setText:@"Camera"];
    
    
    //GALLERY
    UIImageView *galleryBackground = [[UIImageView alloc] initWithFrame:CGRectMake(110, 5, 100, 60)];
    [galleryBackground setImage:[UIImage imageNamed:@"headerbackground.png"]];
    
    UIImageView *galleryImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 5, 30, 30)];
    [galleryImage setImage:[UIImage imageNamed:@"account_sdcard.png"]];
    
    UILabel *galleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 100, 25)];
    [galleryLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [galleryLabel setTextAlignment:NSTextAlignmentCenter];
    [galleryLabel setTextColor:[UIColor whiteColor]];
    [galleryLabel setText:@"SD Card"];
    
    
    
    UIControl *cameraMask1 = [[UIControl alloc] initWithFrame:cameraBackground.frame];
    [cameraMask1 addTarget:self action:@selector(cameraSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl *galleryMask1 = [[UIControl alloc] initWithFrame:galleryBackground.frame];
    [galleryMask1 addTarget:self action:@selector(gallerySelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [cameraBackground addSubview:cameraImage];
    [cameraBackground addSubview:cameraLabel];
    
    [galleryBackground addSubview:galleryImage];
    [galleryBackground addSubview:galleryLabel];
    
    
    
    [imageSelectionView addSubview:cameraBackground];
    
    [imageSelectionView addSubview:galleryBackground];
    
    [imageSelectionView addSubview:cameraMask1];
    
    [imageSelectionView addSubview:galleryMask1];
    
    
    [profileScroll addSubview:backgroundSelectionView];
    
    [profileScroll addSubview:imageSelectionView];
    
    
    
}
-(void)cameraSelected:(id)sender{
    
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate         = self;
    picker.allowsEditing    = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
    
}
-(void)gallerySelected:(id)sender{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate         = self;
    picker.allowsEditing    = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}




// SAVING DATA TO PAYLIST====================================>
-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    
    [saveData initSaveData:finalCountry forKey:@"country"];
    [saveData initSaveData:finalProvince forKey:@"provinceCity"];
    [saveData initSaveData:finalAddress forKey:@"permanentAdd"];
    [saveData initSaveData:finalZipcode forKey:@"zipcode"];
    [saveData initSaveData:finalGender forKey:@"gender"];
    
    [saveData initSaveData:finalNumber forKey:@"mobileno"];
    [saveData initSaveData:finalNationality forKey:@"nationality"];
    [saveData initSaveData:finalWork forKey:@"natureOfWork"];
    
    [saveData initSaveData:strImage1 forKey:@"photo1"];
    [saveData initSaveData:strImage2 forKey:@"photo2"];
    [saveData initSaveData:strImage3 forKey:@"photo3"];
    [saveData initSaveData:strImage4 forKey:@"photo4"];
    
    
    
}

// END SAVING DATA TO PAYLIST====================================>








@end
