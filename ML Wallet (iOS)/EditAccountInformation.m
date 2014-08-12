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

@interface EditAccountInformation ()

@end

@implementation EditAccountInformation

ProfileImage *profileImage;
UIImageView *userImage, *image1, *image2, *image3, *image4;
UIScrollView *profileScroll;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 850)];
    
    
    [self createImageInfo];
    [self createAccountLabel];
    [self createAccountValue];

    
    [self.view addSubview:profileScroll];
    [self addNavigationBarButton];
}


-(void) createImageInfo{
    
    
    profileImage = [[ProfileImage alloc] initWithProfileImage:[UIImage imageNamed:@"rene.jpg"] x:20 y:20];
    
    UILabel *profileName = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 25)];
    [profileName setFont:[UIFont fontWithName:nil size:15.0f]];
    [profileName setText:@"Harry Cobrado Lingad"];
    
    UILabel *profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 180, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:13.0f]];
    [profilePhone setText:@"09273444456"];
    
    UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(130, 66, 180, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileEmail setText:@"harry@yahoo.com"];
    
    UIButton *browsePicture = [[UIButton alloc] initWithFrame:CGRectMake(130, 95, 150, 25)];
    [browsePicture setBackgroundColor:[UIColor redColor]];
    [browsePicture setTitle:@"Browse Picture" forState:UIControlStateNormal];
    
  
    
    
    
    ProfileOutline *imageCollectionView = [[ProfileOutline alloc] initWithFrame:CGRectMake(15, 150, 290, 74)];
    
    image1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 70, 70)];
    [image1 setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    image2 = [[UIImageView alloc] initWithFrame:CGRectMake(74, 2, 70, 70)];
    [image2 setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    image3 = [[UIImageView alloc] initWithFrame:CGRectMake(146, 2, 70, 70)];
    [image3 setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    image4 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 70, 70)];
    [image4 setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    
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
    UITextField *country = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [country setBackgroundColor:[UIColor whiteColor]];
    [countryOutline addSubview:country];
    
    
    
    //Province
    UIView *provinceOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 350, 280, 30)];
    [provinceOutline setBackgroundColor:[UIColor redColor]];
    UITextField *province = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [province setBackgroundColor:[UIColor whiteColor]];
    [provinceOutline addSubview:province];
    
    
    //Address
    UIView *addressOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 410, 280, 30)];
    [addressOutline setBackgroundColor:[UIColor redColor]];
    UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [address setBackgroundColor:[UIColor whiteColor]];
    [addressOutline addSubview:address];
    
    
    
    //ZipCode
    UIView *zipcodeOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 470, 280, 30)];
    [zipcodeOutline setBackgroundColor:[UIColor redColor]];
    UITextField *zipcode = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [zipcode setBackgroundColor:[UIColor whiteColor]];
    [zipcodeOutline addSubview:zipcode];
    
    
    
    //Gender
    UIView *genderOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 530, 280, 30)];
    [genderOutline setBackgroundColor:[UIColor redColor]];
    UITextField *gender = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [gender setBackgroundColor:[UIColor whiteColor]];
    [genderOutline addSubview:gender];
    
    
    
    //Mobile Number
    UIView *numberOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 590, 280, 30)];
    [numberOutline setBackgroundColor:[UIColor redColor]];
    UITextField *number = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [number setBackgroundColor:[UIColor whiteColor]];
    [numberOutline addSubview:number];
    
    
    //Email
    UIView *emailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 650, 280, 30)];
    [emailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *email = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [email setBackgroundColor:[UIColor whiteColor]];
    [emailOutline addSubview:email];
    
    
    
    //Work
    UIView *workOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 710, 280, 30)];
    [workOutline setBackgroundColor:[UIColor redColor]];
    UITextField *work = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [work setBackgroundColor:[UIColor whiteColor]];
    [workOutline addSubview:work];
    
    
    
    //Nationality
    UIView *nationalityOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 770, 280, 30)];
    [nationalityOutline setBackgroundColor:[UIColor redColor]];
    UITextField *nationality = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
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
