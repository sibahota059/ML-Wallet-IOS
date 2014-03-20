//
//  UpdateInformation.m
//  Account
//
//  Created by mm20-18 on 2/26/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "UpdateInformation.h"
#import "AccountQuestion.h"
#import "ProfileOutline.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "ProfileHeader.h"
#import "ProfileImage.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface UpdateInformation ()

@end

@implementation UpdateInformation

@synthesize updateProfileScrollView;

UIImageView *userImage, *image1, *image2, *image3, *image4;

ProfileImage *userMainImage;

ProfileTextField *firstNameTF, *middleNameTF, *lastNameTF, *genderTF, *birthDateTF, *ageTF, *nationalityTF, *workTF;
ProfileTextField *countryTF, *provinceTF, *addressTF, *zipcodeTF;
ProfileTextField *emailTF, *numberTF;


int outlineX = 10;
int outlineWidth = 300;

int commonX = 10;
int textFieldWidth = 280;
int textFieldHeight = 30;


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
    
    updateProfileScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    [updateProfileScrollView setScrollEnabled:YES];
    [updateProfileScrollView setContentSize:CGSizeMake(320, 1780)];
    

    [self createImageSelectionView];
    [self createPersonalInfoView];
    [self createLocationInfoView];
    [self createContactInfoView];
    
    

    

    firstNameTF.delegate = self;
    middleNameTF.delegate = self;
    lastNameTF.delegate = self;
    genderTF.delegate = self;
    birthDateTF.delegate = self;
    ageTF.delegate = self;
    nationalityTF.delegate = self;
    workTF.delegate = self;
    
    countryTF.delegate = self;
    provinceTF.delegate = self;
    addressTF.delegate = self;
    zipcodeTF.delegate = self;
    
    emailTF.delegate = self;
    numberTF.delegate = self;
    
    
    
    [self addNavigationBarButton];
    
    [self.view addSubview:updateProfileScrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Create UI_VIEW

-(void) createImageSelectionView{
    
    ProfileOutline *facialOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, 20, outlineWidth, 269)];
    
    ProfileHeader *facialHeader = [[ProfileHeader alloc] initWithValue:@" Facial Information" x:5 y:-10 width:150];
    
    
    //USER PROFILE IMAGE
    
    
    userMainImage = [[ProfileImage alloc] initWithProfileImage:[UIImage imageNamed:@"rene.jpg"] x:108 y:20];
 
    //Browse file Button
    
    UIButton *browseButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 140, 150, 35)];
    [browseButton setTitle:@"Browse picture" forState:UIControlStateNormal];
    [browseButton setBackgroundColor:[UIColor redColor]];
    [browseButton setTintColor:[UIColor whiteColor]];
    
   
    

    //IMAGE COLLECTION
    
    ProfileOutline *imageCollectionView = [[ProfileOutline alloc] initWithFrame:CGRectMake(5, 190, 290, 74)];
    
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
    
    
    
    [facialOutline addSubview:facialHeader];
    [facialOutline addSubview:userMainImage];
    [facialOutline addSubview:browseButton];
    [facialOutline addSubview:imageCollectionView];
    
    [updateProfileScrollView addSubview:facialOutline];
    
//    [updateProfileScrollView addSubview: userMainImage];
//    [updateProfileScrollView addSubview:browseButton];
//    [updateProfileScrollView addSubview:imageCollectionView];
    
    
    
    

}

-(void) createPersonalInfoView{
    
    
    ProfileLabel *firstNameLbl, *middleNameLbl, *lastNameLbl, *genderLbl, *birthDateLbl, *ageLbl, *nationalityLbl, *workLbl;
    
    ProfileOutline *personalLayout = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, 310, outlineWidth, 465)];
    
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Personal Information" x:5 y:-10 width:170];
    
    
    //PERSONAL INFORMATION
    
    //First name
    firstNameLbl = [[ProfileLabel alloc] initWithStatus:@"First Name" x:commonX y:5 myColor:[UIColor blackColor]];
    firstNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 30, textFieldWidth, textFieldHeight) word:@"Firstname"];
    
    //Middle name
    middleNameLbl = [[ProfileLabel alloc] initWithStatus:@"Middle Name" x:commonX y:60 myColor:[UIColor blackColor]];
    middleNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 85, textFieldWidth, textFieldHeight) word:@"Middle Name"];
    
    //Last name
    lastNameLbl = [[ProfileLabel alloc] initWithStatus:@"Last Name" x:commonX y:115 myColor:[UIColor blackColor]];
    lastNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 140, textFieldWidth, textFieldHeight) word:@"Last Name"];
    
    //Gender
    genderLbl = [[ProfileLabel alloc] initWithStatus:@"Gender" x:commonX y:170 myColor:[UIColor blackColor]];
    genderTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 195, textFieldWidth, textFieldHeight) word:@"Gender"];
    
    //BirthDate
    birthDateLbl = [[ProfileLabel alloc] initWithStatus:@"Birthdate" x:commonX y:225 myColor:[UIColor blackColor]];
    birthDateTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 250, textFieldWidth, textFieldHeight) word:@"Birthdate"];

    //Age
    ageLbl = [[ProfileLabel alloc] initWithStatus:@"Age" x:commonX y:280 myColor:[UIColor blackColor]];
    ageTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 305, textFieldWidth, textFieldHeight) word:@"Age"];
    
    //Nationality
    nationalityLbl = [[ProfileLabel alloc] initWithStatus:@"Nationality" x:commonX y:335 myColor:[UIColor blackColor]];
    nationalityTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 360, textFieldWidth, textFieldHeight) word:@"Nationality"];

    
    //Nature of Work
    workLbl = [[ProfileLabel alloc] initWithStatus:@"Nature of Work" x:commonX y:390 myColor:[UIColor blackColor]];
    workTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 415, textFieldWidth, textFieldHeight) word:@"Nature of Work"];
    

    //ADDING IN PERSONAL INFORMATION
    
    [personalLayout addSubview:personalHeader];
    
    [personalLayout addSubview:firstNameLbl];
    [personalLayout addSubview:firstNameTF];
    
    [personalLayout addSubview:middleNameLbl];
    [personalLayout addSubview:middleNameTF];
    
    [personalLayout addSubview:lastNameLbl];
    [personalLayout addSubview:lastNameTF];
    
    [personalLayout addSubview:genderLbl];
    [personalLayout addSubview:genderTF];
    
    [personalLayout addSubview:birthDateLbl];
    [personalLayout addSubview:birthDateTF];
    
    [personalLayout addSubview:ageLbl];
    [personalLayout addSubview:ageTF];
    
    [personalLayout addSubview:nationalityLbl];
    [personalLayout addSubview:nationalityTF];
    
    [personalLayout addSubview:workLbl];
    [personalLayout addSubview:workTF];

    [updateProfileScrollView addSubview:personalLayout];
    
}

-(void) createLocationInfoView{
    
    
    ProfileLabel *countryLbl, *provinceLbl, *addressLbl, *zipcodeLbl;
    
    ProfileOutline *locationLayout = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, 795, outlineWidth, 245)];

    ProfileHeader *locationHeader = [[ProfileHeader alloc] initWithValue:@" Location Information" x:5 y:-10 width:170];
    
    
    //LOCATION INFORMATION
    
    //Country
    countryLbl = [[ProfileLabel alloc] initWithStatus:@"Country" x:commonX y:5 myColor:[UIColor blackColor]];
    countryTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 30, textFieldWidth, textFieldHeight) word:@"Country"];
  
    
    //Province
    provinceLbl = [[ProfileLabel alloc] initWithStatus:@"Province" x:commonX y:60 myColor:[UIColor blackColor]];
    provinceTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 85, textFieldWidth, textFieldHeight) word:@"Province"];
    
    
    //Permanent Address
    addressLbl = [[ProfileLabel alloc] initWithStatus:@"Permanent Address" x:commonX y:115 myColor:[UIColor blackColor] width:150];
    addressTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 140, textFieldWidth, textFieldHeight) word:@"Permanent Address"];
    
    
    //Zipcode
    zipcodeLbl = [[ProfileLabel alloc] initWithStatus:@"Zipcode" x:commonX y:170 myColor:[UIColor blackColor]];
    zipcodeTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 195, textFieldWidth, textFieldHeight) word:@"Zipcode"];
    
    
    //ADDING IN PERSONAL INFORMATION
    
    [locationLayout addSubview:locationHeader];
    
    [locationLayout addSubview:countryLbl];
    [locationLayout addSubview:countryTF];
    
    [locationLayout addSubview:provinceLbl];
    [locationLayout addSubview:provinceTF];
    
    [locationLayout addSubview:addressLbl];
    [locationLayout addSubview:addressTF];
    
    [locationLayout addSubview:zipcodeLbl];
    [locationLayout addSubview:zipcodeTF];
    
    [updateProfileScrollView addSubview:locationLayout];
    

}

-(void) createContactInfoView{

    ProfileLabel *emailLbl, *numberLbl;
    
    ProfileOutline *contactLayout = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, 1060, outlineWidth, 135)];
    
    ProfileHeader *contactHeader = [[ProfileHeader alloc] initWithValue:@" Contact Information" x:5 y:-10 width:160];

    
    
    //CONTACT INFORMATION
    
    //Email
    emailLbl = [[ProfileLabel alloc] initWithStatus:@"Email Address" x:commonX y:5 myColor:[UIColor blackColor]];
    emailTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 30, textFieldWidth, textFieldHeight) word:@"Email Address"];
    
    //Mobile
    numberLbl = [[ProfileLabel alloc] initWithStatus:@"Mobile Number" x:commonX y:60 myColor:[UIColor blackColor]];
    numberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonX, 85, textFieldWidth, textFieldHeight) word:@"Mobile Number"];

    
    
    //ADDING IN CONTACT INFORMATION
    
    [contactLayout addSubview:contactHeader];
    
    [contactLayout addSubview:emailLbl];
    [contactLayout addSubview:emailTF];
    
    [contactLayout addSubview:numberLbl];
    [contactLayout addSubview:numberTF];
    
    [updateProfileScrollView addSubview:contactLayout];

}





#pragma mark - Create - Navigation

-(void) addNavigationBarButton {
    
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];

    
    
    
    
 
//    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPressed:)];
    
    
    //RIGHT NAVIGATION BUTTON
    UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [questionButton setImage:[UIImage imageNamed:@"question_profile.png"] forState:UIControlStateNormal];
    [questionButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [questionView addSubview:questionButton];
    
    UIBarButtonItem *questionNavButton = [[UIBarButtonItem alloc] initWithCustomView:questionView];
    [questionNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setRightBarButtonItem:questionNavButton];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}

-(void) nextPressed:(id) sender{
    
    AccountQuestion *accountQuestion = [[AccountQuestion alloc] initWithNibName:@"AccountQuestion" bundle:nil];
    
    [self.navigationController pushViewController:accountQuestion animated:YES];

}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}









-(void) selectImage:(id)sender{

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    


}














#pragma mark - USING DELEGATE

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{self.updateProfileScrollView.frame = CGRectMake(0, -150, 320, 1000); }
                     completion:^(BOOL finished){}];
    
    [self.view addSubview:self.updateProfileScrollView];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{updateProfileScrollView.frame = CGRectMake(0, 20, 320, 1000); }
                     completion:^(BOOL finished){}];


    [firstNameTF resignFirstResponder];
    [middleNameTF resignFirstResponder];
    [lastNameTF resignFirstResponder];
    [genderTF resignFirstResponder];
    [birthDateTF resignFirstResponder];
    [ageTF resignFirstResponder];
    [nationalityTF resignFirstResponder];
    [workTF resignFirstResponder];
    
    [countryTF resignFirstResponder];
    [provinceTF resignFirstResponder];
    [addressTF resignFirstResponder];
    [zipcodeTF resignFirstResponder];

    [emailTF resignFirstResponder];
    [numberTF resignFirstResponder];
    
    return YES;
}







@end
