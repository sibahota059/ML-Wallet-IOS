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

EditAccountInfoWebService *editAccountInfoWS;

UIImageView *profileImage;
UIImageView *userImage;

UIImage *image1, *image2, *image3, *image4;
UIImageView *imageView1, *imageView2, *imageView3, *imageView4;
UIScrollView *profileScroll;
NSDictionary *loadData;

NSData *data1, *data2, *data3, *data4;

NSString *wallet, *firstNameValue, *middleNameValue, *lastNameValue, *countryValue, *provinceValue, *addressValue, *zipcodeValue, *genderValue, *birthdateValue, *ageValue, *mobileNumberValue, *emailValue, *workValue, *nationalityValue, *photo1Value, *photo2Value, *photo3Value, *photo4Value, *answer1, *answer2, *answer3, *question1, *question2, *question3;

UITextField *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;

 UILabel *profileName, *profilePhone, *profileEmail;

int whichImage1, whichImage2, whichImage3, whichImage4;


NSString *EDITACCOUNT_VAL_ERROR = @"Validation Error";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 850)];
    
    editAccountInfoWS = [EditAccountInfoWebService new];
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    [self initializeImageIndicator];
    
    [self loadFromPlaylist];
    [self createImageInfo];
    [self createAccountLabel];
    [self createAccountValue];
    [self setInfo];

    
    [self.view addSubview:profileScroll];
    [self addNavigationBarButton];
    editAccountInfoWS.delegate = self;
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
    
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 70, 70)];
    
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(74, 2, 70, 70)];
    
    imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(146, 2, 70, 70)];
    
    imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 70, 70)];
    
    
    [imageCollectionView addSubview:imageView1];
    [imageCollectionView addSubview:imageView2];
    [imageCollectionView addSubview:imageView3];
    [imageCollectionView addSubview:imageView4];
    
    
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
                                                                                                             
    
    [profileScroll addSubview:profileImage];
    [profileScroll addSubview:profileName];
    [profileScroll addSubview:profilePhone];
    [profileScroll addSubview:profileEmail];
    [profileScroll addSubview:browsePicture];
    
    [profileScroll addSubview:imageCollectionView];
    
    
}




-(void)imageClicked1:(id)sender{
    
    [profileImage setImage:[UIImage imageWithData:data1]];
    [self initializeImageIndicator];
    whichImage1 = 1;
}

-(void)imageClicked2:(id)sender{
    
    [profileImage setImage:[UIImage imageWithData:data2]];
    [self initializeImageIndicator];
    whichImage2 = 1;
}

-(void)imageClicked3:(id)sender{
    
    [profileImage setImage:[UIImage imageWithData:data3]];
    [self initializeImageIndicator];
    whichImage3 = 1;
}

-(void)imageClicked4:(id)sender{
    
    [profileImage setImage:[UIImage imageWithData:data4]];
    [self initializeImageIndicator];
    whichImage4 = 1;
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
    
    
    mobileNumber.delegate = self;
    email.delegate = self;
    work.delegate = self;
    nationality.delegate = self;
    
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
    
    data1 = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    image1 = [[UIImage alloc] initWithData:data1];
    imageView1.image = image1;
    
    
    data2 = [[NSData alloc]initWithBase64EncodedString:photo2Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    image2 = [[UIImage alloc] initWithData:data2];
    imageView2.image = image2;
    
    data3 = [[NSData alloc]initWithBase64EncodedString:photo3Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    image3 = [[UIImage alloc] initWithData:data3];
    imageView3.image = image3;
    
    
    data4 = [[NSData alloc]initWithBase64EncodedString:photo4Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    image4 = [[UIImage alloc] initWithData:data4];
    imageView4.image = image4;
    
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
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate         = self;
    picker.allowsEditing    = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self.navigationController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(whichImage1 == 1)
    {
        [imageView1 setImage:resultImage];
        image1 = resultImage;
    }
    else if(whichImage2 == 1)
    {
        [imageView2 setImage:resultImage];
        image2 = resultImage;

    }
    else if(whichImage3 == 1)
    {
        [imageView3 setImage:resultImage];
        image3 = resultImage;

    }
    else if(whichImage4 == 1)
    {
        [imageView4 setImage:resultImage];
        image4 = resultImage;

    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
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
    
     UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:EDITACCOUNT_VAL_ERROR message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    if([country.text isEqualToString:@""] || [province.text isEqualToString:@""] || [address.text isEqualToString:@""] || [zipcode.text isEqualToString:@""] || [gender.text isEqualToString:@""] || [mobileNumber.text isEqualToString:@""] || [work.text isEqualToString:@""] || [nationality.text isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    else if([[mobileNumberValue substringFromIndex:2] isEqualToString:@"09"])
    {
        [saveAlert setMessage:@"Mobile Number must begin with 09"];
        [saveAlert show];
    }
    else if (mobileNumberValue.length < 10)
    {
        [saveAlert setMessage:@"Mobile Number must have 10 digits."];
        [saveAlert show];
    }
    else
    {
        [editAccountInfoWS wallet:wallet country:countryValue province:provinceValue address:addressValue zipcode:zipcodeValue gender:genderValue mnumber:mobileNumberValue work:workValue nationality:nationalityValue photo1:image1 photo2:image2 photo3:image3 photo4:image4];

    }
    
    
    
    
    
    
}

-(void)didFinishEditingAccount:(NSString *)indicator andError:(NSString *)getError{
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editAccountInfoWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:editAccountInfoWS.respmessage];
        
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{self.view.frame = CGRectMake(0, -100, 320, 568); }
                         completion:^(BOOL finished){}];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{self.view.frame = CGRectMake(0, 100, 320, 568); }
                     completion:^(BOOL finished){}];
    
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void) initializeImageIndicator{
    whichImage1 = 0;
    whichImage2 = 0;
    whichImage3 = 0;
    whichImage4 = 0;
}
@end
