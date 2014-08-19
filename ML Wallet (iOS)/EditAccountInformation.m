//
//  EditAccountInformation.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditAccountInformation.h"
#import "ProfileImage.h"
#import "ProfileOutline.h"
#import "ProfileTextField.h"
#import "NSDictionary+LoadWalletData.h"

@interface EditAccountInformation ()

@end

@implementation EditAccountInformation

UIImageView *profileImage;
UIImageView *userImage, *image1, *image2, *image3, *image4;
UIScrollView *profileScroll;
NSDictionary *loadData;

NSString *firstNameValue, *middleNameValue, *lastNameValue, *countryValue, *provinceValue, *addressValue, *zipcodeValue, *genderValue, *birthdateValue, *ageValue, *mobileNumberValue, *emailValue, *workValue, *nationalityValue, *photo1Value, *photo2Value, *photo3Value, *photo4Value, *answer1, *answer2, *answer3, *question1, *question2, *question3;

UITextField *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;

 UILabel *profileName, *profilePhone, *profileEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 850)];
    
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    [self loadFromPlaylist];
    [self createImageInfo];
    [self createAccountLabel];
    [self createAccountValue];
    [self setInfo];

    
    [self.view addSubview:profileScroll];
    [self addNavigationBarButton];
}


-(void) loadFromPlaylist{
    
    
    
    firstNameValue = [loadData objectForKey:@"fname"];
    middleNameValue = [loadData objectForKey:@"mname"];
    lastNameValue = [loadData objectForKey:@"lname"];
    
    countryValue =[loadData objectForKey:@"country"];
    provinceValue =[loadData objectForKey:@"provinceCity"];
    addressValue =[loadData objectForKey:@"permanentAdd"];
    zipcodeValue =[loadData objectForKey:@"zipcode"];
    genderValue =[loadData objectForKey:@"gender"];
    
    mobileNumberValue =[loadData objectForKey:@"mobileno"];
    
    emailValue =[loadData objectForKey:@"emailadd"];
    workValue =[loadData objectForKey:@"natureOfWork"];
    nationalityValue =[loadData objectForKey:@"nationality"];
    
    photo1Value =[loadData objectForKey:@"photo1"];
    photo2Value =[loadData objectForKey:@"photo2"];
    photo3Value =[loadData objectForKey:@"photo3"];
    photo4Value =[loadData objectForKey:@"photo2"];

}


-(void) createImageInfo{
    
    
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    
   
    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 25)];
    [profileName setFont:[UIFont fontWithName:nil size:15.0f]];
    
    profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 180, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:13.0f]];
    
    profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(130, 66, 180, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    
    UIButton *browsePicture = [[UIButton alloc] initWithFrame:CGRectMake(130, 95, 150, 25)];
    [browsePicture setBackgroundColor:[UIColor redColor]];
    [browsePicture addTarget:self action:@selector(selectPicture:) forControlEvents:UIControlEventTouchUpInside];
    [browsePicture setTitle:@"Browse Picture" forState:UIControlStateNormal];
  
    
    
    
    ProfileOutline *imageCollectionView = [[ProfileOutline alloc] initWithFrame:CGRectMake(15, 150, 290, 74)];
    
    image1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 70, 70)];
    
    image2 = [[UIImageView alloc] initWithFrame:CGRectMake(74, 2, 70, 70)];
    
    image3 = [[UIImageView alloc] initWithFrame:CGRectMake(146, 2, 70, 70)];
    
    image4 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 70, 70)];
    
    
    [imageCollectionView addSubview:image1];
    [imageCollectionView addSubview:image2];
    [imageCollectionView addSubview:image3];
    [imageCollectionView addSubview:image4];
    
    [profileScroll addSubview:profileImage];
    [profileScroll addSubview:profileName];
    [profileScroll addSubview:profilePhone];
    [profileScroll addSubview:profileEmail];
    [profileScroll addSubview:browsePicture];
    
    
    [profileScroll addSubview:imageCollectionView];
    
    
}

-(void) createAccountLabel{
    
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 180, 25)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
    [accountInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Profile Information"];
    
    
    //ProfileInformationLabel
    

    
    //Country
    UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, 100, 25)];
    [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileCountry setText:@"Country: "];
    
    
    //Province
    UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, 325, 100, 25)];
    [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileProvince setText:@"Province: "];
    
   
    //Address
    UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 385, 100, 25)];
    [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileAddress setText:@"Address: "];
    
    
    //ZipCode
    UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(20, 445, 100, 25)];
    [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileZipcode setText:@"Zipcode: "];
    
    
    //Gender
    UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(20, 505, 100, 25)];
    [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileGender setText:@"Gender: "];
    
   //Number
    UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 565, 100, 25)];
    [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNumber setText:@"Mobile Number: "];
    
    
    //Email
    UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, 625, 100, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileEmail setText:@"Email Address: "];
    
    
    //Work
    UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 685, 100, 25)];
    [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileWork setText:@"Nature of Work: "];
    
    
    //Nationality
    UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(20, 745, 100, 25)];
    [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNationality setText:@"Nationality: "];
    
    
    [profileScroll addSubview:accountInfoLabel];
    
    [profileScroll addSubview:profileCountry];
    [profileScroll addSubview:profileProvince];
    [profileScroll addSubview:profileAddress];
    [profileScroll addSubview:profileZipcode];
    [profileScroll addSubview:profileGender];
    [profileScroll addSubview:profileNumber];
    [profileScroll addSubview:profileEmail];
    [profileScroll addSubview:profileWork];
    [profileScroll addSubview:profileNationality];
    
}

-(void) createAccountValue{
    

    
    //Country
    UIView *countryOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 290, 280, 30)];
    [countryOutline setBackgroundColor:[UIColor redColor]];
    country = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [country setBackgroundColor:[UIColor whiteColor]];
    [countryOutline addSubview:country];
    
    
    
    //Province
    UIView *provinceOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 350, 280, 30)];
    [provinceOutline setBackgroundColor:[UIColor redColor]];
    province = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [province setBackgroundColor:[UIColor whiteColor]];
    [provinceOutline addSubview:province];
    
    
    //Address
    UIView *addressOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 410, 280, 30)];
    [addressOutline setBackgroundColor:[UIColor redColor]];
    address = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [address setBackgroundColor:[UIColor whiteColor]];
    [addressOutline addSubview:address];
    
    
    
    //ZipCode
    UIView *zipcodeOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 470, 280, 30)];
    [zipcodeOutline setBackgroundColor:[UIColor redColor]];
    zipcode = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [zipcode setBackgroundColor:[UIColor whiteColor]];
    [zipcodeOutline addSubview:zipcode];
    
    
    
    //Gender
    UIView *genderOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 530, 280, 30)];
    [genderOutline setBackgroundColor:[UIColor redColor]];
    gender = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [gender setBackgroundColor:[UIColor whiteColor]];
    [genderOutline addSubview:gender];
    
    
    
    //Mobile Number
    UIView *numberOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 590, 280, 30)];
    [numberOutline setBackgroundColor:[UIColor redColor]];
    mobileNumber = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [mobileNumber setBackgroundColor:[UIColor whiteColor]];
    [numberOutline addSubview:mobileNumber];
    
    
    //Email
    UIView *emailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 650, 280, 30)];
    [emailOutline setBackgroundColor:[UIColor redColor]];
    email = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [email setBackgroundColor:[UIColor whiteColor]];
    [emailOutline addSubview:email];
    
    
    
    //Work
    UIView *workOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 710, 280, 30)];
    [workOutline setBackgroundColor:[UIColor redColor]];
    work = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [work setBackgroundColor:[UIColor whiteColor]];
    [workOutline addSubview:work];
    
    
    
    //Nationality
    UIView *nationalityOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 770, 280, 30)];
    [nationalityOutline setBackgroundColor:[UIColor redColor]];
    nationality = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [nationality setBackgroundColor:[UIColor whiteColor]];
    [nationalityOutline addSubview:nationality];
    
    
    [profileScroll addSubview:countryOutline];
    [profileScroll addSubview:provinceOutline];
    [profileScroll addSubview:addressOutline];
    [profileScroll addSubview:zipcodeOutline];
    [profileScroll addSubview:genderOutline];
    [profileScroll addSubview:numberOutline];
    [profileScroll addSubview:emailOutline];
    [profileScroll addSubview:workOutline];
    [profileScroll addSubview:nationalityOutline];
    
}


-(void) setInfo{
    
    
    
    
    
    
    
    //CONVERTING STRING INTO IMAGE=================================================
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [profileImage setImage:[UIImage imageWithData:data]];
    
    NSData *data1 = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [image1 setImage:[UIImage imageWithData:data1]];
    
    
    NSData *data2 = [[NSData alloc]initWithBase64EncodedString:photo2Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [image2 setImage:[UIImage imageWithData:data2]];
    
    
    NSData *data3 = [[NSData alloc]initWithBase64EncodedString:photo3Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [image3 setImage:[UIImage imageWithData:data3]];
    
    
    NSData *data4 = [[NSData alloc]initWithBase64EncodedString:photo4Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [image4 setImage:[UIImage imageWithData:data4]];
    
    //================================================================================
    
    
    [profileName setText:[NSString stringWithFormat:@"%@ %@. %@",firstNameValue, middleNameValue, lastNameValue]];
    [profilePhone setText:mobileNumberValue];
    [profileEmail setText:emailValue];
    
    [country setPlaceholder:[NSString stringWithFormat:@" %@", countryValue]];
    [province setPlaceholder:[NSString stringWithFormat:@" %@", provinceValue]];
    [address setPlaceholder:[NSString stringWithFormat:@" %@", addressValue]];
    [zipcode setPlaceholder:[NSString stringWithFormat:@" %@", zipcodeValue]];
    [gender setPlaceholder:[NSString stringWithFormat:@" %@", genderValue]];
    [email setPlaceholder:[NSString stringWithFormat:@" %@", emailValue]];
    [mobileNumber setPlaceholder:[NSString stringWithFormat:@" %@", mobileNumberValue]];
    [work setPlaceholder:[NSString stringWithFormat:@" %@", workValue]];
    [nationality setPlaceholder:[NSString stringWithFormat:@" %@", nationalityValue]];
    
    
    
}


-(void) selectPicture:(id)sender{
    
    UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"Message" message:@"To do" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [temp show];
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
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"EditAccountInformation" message:@"SAVE" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [saveAlert show];
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
