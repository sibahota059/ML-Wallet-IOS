//
//  ProfileInformation.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileInformation.h"
#import "UpdateInformation.h"
#import "UICreationMethods.h"
#import "ProfileImage.h"
#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "AccountMain.h"
#import "ProfileLabel.h"
#import "QuestionVerificationDialog.h"
#import "EditInformation.h"

@interface ProfileInformation ()


@end

@implementation ProfileInformation

@synthesize profileScroll;
@synthesize editDialog;
UIImageView *radioButtonImage1;
UIImageView *radioButtonImage2;
UIImageView *radioButtonImage3;

NSString *question_1, *question_2, *question_3;

UILabel *selectedQuestion;

ProfileImage *profileImage;


QuestionVerificationDialog *dialog;


UIImageView *userImage, *image1, *image2, *image3, *image4;



//DECLARE VARIABLES

UIScrollView *profileScroll;

int profileOutlineWidth;
int profileOutlineHeight;

int labelX;
int labelValueX;

int outlineX;
int outlineWidth;
int outlineHeight;

int imageY;
int personalY;
int locationY;
int contactY;


ProfileLabel *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


ProfileOutline *firstNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;



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
    
    question_1 = @"Who are you?";
    question_2 = @"Whar are you said?";
    question_3 = @"How come you are said that?";
    
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 600)];
    
    
    
    //INTANTIATE THE VARIABLES
    labelX = 10;
    labelValueX = 0;
    
    outlineX = 10;
    outlineWidth = 300;
    
    
    profileOutlineWidth = 280;
    profileOutlineHeight = 25;
    
    imageY = 20;
    personalY = 190;
    locationY = 640;
    contactY = 890;
    
    
    [self createImageInfo];
    [self createPersonalLabel];
    [self createPersonalValue];
    
    //END
    
    
    //CREATE DIALOG
    
    dialog = [[QuestionVerificationDialog alloc] initWithFrame:CGRectMake(0, 35, 280, 1120) addTarget:self action:@selector(goToEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    [dialog setHidden:YES];

    //CREATE DIALOG END

    
    [self.view addSubview:profileScroll];
    [self.view addSubview:dialog];
    
    [self addNavigationBarButton];
    
    
}

-(void) viewWillAppear:(BOOL)animated{

    if(![dialog isHidden])
    {
        [dialog setHidden:YES];
    }


}







#pragma OTHER METHODS

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) goToEdit:(id)sender{
    
   /* UpdateInformation *updateInformation = [[UpdateInformation alloc] initWithNibName:@"UpdateInformation" bundle:nil];
    [dialog setHidden:YES];
    [self fadeInAnimation:dialog];
    [self.navigationController pushViewController:updateInformation animated:YES]; */
    
    EditInformation *editInformation = [[EditInformation alloc] initWithNibName:@"EditInformation" bundle:nil];
    [self fadeInAnimation:dialog];
    [self.navigationController pushViewController:editInformation animated:YES];
    
}

-(void)editPressed:(id)sender{
    
    [dialog setHidden:!dialog.hidden];
    
    [self fadeInAnimation:dialog];
    
}

-(void) addNavigationBarButton{
    
    
    
    self.title = @"My Profile";
    
    //RIGHT NAVIGATION BUTTON
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
//      [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [backView addSubview:backButton];
    
    
//    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
//    [backNavButton setStyle:UIBarButtonItemStyleBordered];


    //RIGHT NAVIGATION BUTTON
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
   [editButton setImage:[UIImage imageNamed:@"my_edit.png"] forState:UIControlStateNormal];
    
  //[editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [editView addSubview:editButton];
    
    UIBarButtonItem *editNavButton = [[UIBarButtonItem alloc] initWithCustomView:editView];
    [editNavButton setStyle:UIBarButtonItemStyleBordered];
    [editNavButton setTarget:self];
    [editNavButton setAction:@selector(editPressed:)];
    

    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];//    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:editNavButton];
    
}

-(void)backPressed:(id)sender{

    [self.navigationController  popViewControllerAnimated:YES];

}









#pragma mark - CREATE UI

-(void) createImageInfo{
    

    profileImage = [[ProfileImage alloc] initWithProfileImage:[UIImage imageNamed:@"rene.jpg"] x:20 y:20];
    
    UILabel *profileName = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 300, 25)];
    [profileName setFont:[UIFont fontWithName:nil size:15.0f]];
    [profileName setText:@"Harry Cobrado Lingad"];
    
    UILabel *profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 300, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:13.0f]];
    [profilePhone setText:@"09273444456"];
    
    UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(130, 76, 300, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileEmail setText:@"harry@yahoo.com"];
    
    
    
    
    
    
    
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
    
    
    [profileScroll addSubview:imageCollectionView];
    
    
}



-(void) createPersonalLabel{
    
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 180, 25)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
    [accountInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Profile Information"];

    
    //ProfileInformationLabel
    
    UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, 100, 25)];
    [profileFirstName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileFirstName setTextColor:[UIColor grayColor]];
    [profileFirstName setText:@"First Name: "];
    
    UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(20, 285, 100, 25)];
    [profileMiddleName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileMiddleName setTextColor:[UIColor grayColor]];
    [profileMiddleName setText:@"Middle Name: "];
    
    UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(20, 305, 100, 25)];
    [profileLastName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileLastName setTextColor:[UIColor grayColor]];
    [profileLastName setText:@"Last Name: "];
    
    UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(20, 325, 100, 25)];
    [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileCountry setTextColor:[UIColor grayColor]];
    [profileCountry setText:@"Country: "];
    
    UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, 345, 100, 25)];
    [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileProvince setTextColor:[UIColor grayColor]];
    [profileProvince setText:@"Province: "];
    
    UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 365, 100, 25)];
    [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileAddress setTextColor:[UIColor grayColor]];
    [profileAddress setText:@"Address: "];
    
    UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(20, 385, 100, 25)];
    [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileZipcode setTextColor:[UIColor grayColor]];
    [profileZipcode setText:@"Zipcode: "];
    
    UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(20, 405, 100, 25)];
    [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileGender setTextColor:[UIColor grayColor]];
    [profileGender setText:@"Gender: "];
    
    UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(20, 425, 100, 25)];
    [profileBirthdate setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileBirthdate setTextColor:[UIColor grayColor]];
    [profileBirthdate setText:@"Birthdate: "];
    
    UILabel *profileAge = [[UILabel alloc] initWithFrame:CGRectMake(20, 445, 100, 25)];
    [profileAge setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileAge setTextColor:[UIColor grayColor]];
    [profileAge setText:@"Age: "];
    
    UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 465, 100, 25)];
    [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNumber setTextColor:[UIColor grayColor]];
    [profileNumber setText:@"Mobile Number: "];
    
    UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, 485, 100, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileEmail setTextColor:[UIColor grayColor]];
    [profileEmail setText:@"Email Address: "];
    
    UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 505, 100, 25)];
    [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileWork setTextColor:[UIColor grayColor]];
    [profileWork setText:@"Nature of Work: "];
    
    UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(20, 525, 100, 25)];
    [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNationality setTextColor:[UIColor grayColor]];
    [profileNationality setText:@"Nationality: "];
    
    
    [profileScroll addSubview:accountInfoLabel];
    
    [profileScroll addSubview:profileFirstName];
    [profileScroll addSubview:profileMiddleName];
    [profileScroll addSubview:profileLastName];
    [profileScroll addSubview:profileCountry];
    [profileScroll addSubview:profileProvince];
    [profileScroll addSubview:profileAddress];
    [profileScroll addSubview:profileZipcode];
    [profileScroll addSubview:profileGender];
    [profileScroll addSubview:profileBirthdate];
    [profileScroll addSubview:profileAge];
    [profileScroll addSubview:profileNumber];
    [profileScroll addSubview:profileEmail];
    [profileScroll addSubview:profileWork];
    [profileScroll addSubview:profileNationality];

    
    
}




-(void) createPersonalValue{
    

    
    
    //ProfileInformationLabel
    
    UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(130, 265, 180, 25)];
    [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
    [firstName setText:@"Harry"];
    
    UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake(130, 285, 180, 25)];
    [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
    [middleName setText:@"Cobrado"];
    
    UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(130, 305, 180, 25)];
    [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
    [lastName setText:@"Lingad"];
    
    UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake(130, 325, 180, 25)];
    [country setFont:[UIFont fontWithName:nil size:13.0f]];
    [country setText:@"Phillipines"];
    
    UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake(130, 345, 180, 25)];
    [province setFont:[UIFont fontWithName:nil size:13.0f]];
    [province setText:@"Davao"];
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(130, 365, 180, 25)];
    [address setFont:[UIFont fontWithName:nil size:13.0f]];
    [address setText:@"Manalili Cebu City"];
    
    UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake(130, 385, 180, 25)];
    [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
    [zipcode setText:@"6000"];
    
    UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake(130, 405, 180, 25)];
    [gender setFont:[UIFont fontWithName:nil size:13.0f]];
    [gender setText:@"Male"];
    
    UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake(130, 425, 180, 25)];
    [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
    [birthdate setText:@"Nov. 11, 1985"];
    
    UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(130, 445, 180, 25)];
    [age setFont:[UIFont fontWithName:nil size:13.0f]];
    [age setText:@"19"];
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(130, 465, 180, 25)];
    [number setFont:[UIFont fontWithName:nil size:13.0f]];
    [number setText:@"09273444456"];
    
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(130, 485, 180, 25)];
    [email setFont:[UIFont fontWithName:nil size:13.0f]];
    [email setText:@"harry@yahoo.com"];
    
    UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(130, 505, 180, 25)];
    [work setFont:[UIFont fontWithName:nil size:13.0f]];
    [work setText:@"Programmer"];
    
    UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake(130, 525, 180, 25)];
    [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
    [nationality setText:@"Phillipines"];
    
    
    
    
    
    
    [profileScroll addSubview:firstName];
    [profileScroll addSubview:middleName];
    [profileScroll addSubview:lastName];
    [profileScroll addSubview:country];
    [profileScroll addSubview:province];
    [profileScroll addSubview:address];
    [profileScroll addSubview:zipcode];
    [profileScroll addSubview:gender];
    [profileScroll addSubview:birthdate];
    [profileScroll addSubview:age];
    [profileScroll addSubview:number];
    [profileScroll addSubview:email];
    [profileScroll addSubview:work];
    [profileScroll addSubview:nationality];
    
    
    
}














#pragma ANIMATION

-(void)fadeInAnimation:(UIView *) aView{
    CATransition *transition = [CATransition animation];
    transition.type = kCAAnimationRotateAuto;
    transition.duration = 0.5f;
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
    
}

-(void) moveUpAnimation:(UIView *) aView
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.5f;
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
}




- (BOOL)prefersStatusBarHidden{
    return YES;
}






@end
