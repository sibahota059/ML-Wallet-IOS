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



@interface EditAccountInformationPad ()

@end

@implementation EditAccountInformationPad

EditAccountInfoWebService *editAccountInfoWS;

MBProgressHUD *HUD;

UIImage *image1, *image2, *image3, *image4;

UIImageView *imageView1, *imageView2, *imageView3, *imageView4;
UIImageView *userImage;
UIScrollView *profileScroll;

UIImageView *profileImage;

UILabel *profileName, *profileEmail, *profilePhone;

NSDictionary *loadData;

NSData *data1, *data2, *data3, *data4;

UITextField *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


NSString *wallet, *firstNameValue, *middleNameValue, *lastNameValue, *countryValue, *provinceValue, *addressValue, *zipcodeValue, *genderValue, *birthdateValue, *ageValue, *mobileNumberValue, *emailValue, *workValue, *nationalityValue, *photo1Value, *photo2Value, *photo3Value, *photo4Value, *answer1, *answer2, *answer3, *question1, *question2, *question3;

NSString *finalCountry, *finalProvince, *finalAddress, *finalZipcode, *finalGender, *finalNumber, *finalWork, *finalNationality;

int whichImage1, whichImage2, whichImage3, whichImage4;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(768, 1700)];
    
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
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(110, 2, 106, 106)];
    imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 106, 106)];
    imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(326, 2, 106, 106)];
    
    
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
    UIView *countryOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 425, 434, 35)];
    [countryOutline setBackgroundColor:[UIColor redColor]];
    country = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [country setBackgroundColor:[UIColor whiteColor]];
    [countryOutline addSubview:country];
    
    
    
    //Province
    UIView *provinceOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 495, 434, 35)];
    [provinceOutline setBackgroundColor:[UIColor redColor]];
    province = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [province setBackgroundColor:[UIColor whiteColor]];
    [provinceOutline addSubview:province];
    
    
    //Address
    UIView *addressOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 565, 434, 35)];
    [addressOutline setBackgroundColor:[UIColor redColor]];
    address = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [address setBackgroundColor:[UIColor whiteColor]];
    [addressOutline addSubview:address];
    
    
    
    //ZipCode
    UIView *zipcodeOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 635, 434, 35)];
    [zipcodeOutline setBackgroundColor:[UIColor redColor]];
    zipcode = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [zipcode setBackgroundColor:[UIColor whiteColor]];
    [zipcodeOutline addSubview:zipcode];
    
    
    
    //Gender
    UIView *genderOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 705, 434, 35)];
    [genderOutline setBackgroundColor:[UIColor redColor]];
    gender = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [gender setBackgroundColor:[UIColor whiteColor]];
    [genderOutline addSubview:gender];
    
    
    
    //Mobile Number
    UIView *numberOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 775, 434, 35)];
    [numberOutline setBackgroundColor:[UIColor redColor]];
    mobileNumber = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [mobileNumber setBackgroundColor:[UIColor whiteColor]];
    [numberOutline addSubview:mobileNumber];
    
    
    //Work
    UIView *workOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 845, 434, 35)];
    [workOutline setBackgroundColor:[UIColor redColor]];
    work = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [work setBackgroundColor:[UIColor whiteColor]];
    [workOutline addSubview:work];
    
    
    
    //Nationality
    UIView *nationalityOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 915, 434, 35)];
    [nationalityOutline setBackgroundColor:[UIColor redColor]];
    nationality = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [nationality setBackgroundColor:[UIColor whiteColor]];
    [nationalityOutline addSubview:nationality];
    
    
    [profileScroll addSubview:countryOutline];
    [profileScroll addSubview:provinceOutline];
    [profileScroll addSubview:addressOutline];
    [profileScroll addSubview:zipcodeOutline];
    [profileScroll addSubview:genderOutline];
    [profileScroll addSubview:numberOutline];
    [profileScroll addSubview:workOutline];
    [profileScroll addSubview:nationalityOutline];
    
    
    
    
    
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
    
    CGSize size = CGSizeMake(150, 150);
    
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    resultImage = [self imageWithImage:resultImage scaledToSize:size];
    
    NSData *imgData= UIImageJPEGRepresentation(resultImage,0.0);
    
    if(whichImage1 == 1)
    {
        data1 = imgData;
        image1 = [[UIImage alloc] initWithData:data1];
        imageView1.image = image1;
        
    }
    else if(whichImage2 == 1)
    {
        data2 = imgData;
        image2 = [[UIImage alloc] initWithData:data2];
        imageView2.image = image2;
        
    }
    else if(whichImage3 == 1)
    {
        data3 = imgData;
        image3 = [[UIImage alloc] initWithData:data3];
        imageView3.image = image3;
        
    }
    else if(whichImage4 == 1)
    {
        data4 = imgData;
        image4 = [[UIImage alloc] initWithData:data4];
        imageView4.image = image4;
        
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
    
    
    
    if([finalCountry isEqualToString:@""] || [finalProvince isEqualToString:@""] || [finalAddress isEqualToString:@""] || [finalZipcode isEqualToString:@""] || [finalGender isEqualToString:@""] || [finalNumber isEqualToString:@""] || [finalWork isEqualToString:@""] || [finalNationality isEqualToString:@""])
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
        [editAccountInfoWS wallet:wallet country:finalCountry province:finalProvince address:finalAddress zipcode:finalZipcode gender:finalGender mnumber:finalNumber work:finalWork nationality:finalNationality photo1:image1 photo2:image2 photo3:image3 photo4:image4];
        [self displayProgressBar];
        
    }
    
    
    
    
    
    
}

-(void)didFinishEditingAccount:(NSString *)indicator andError:(NSString *)getError{
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [self dismissProgressBar];
    
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
                     animations:^{self.view.frame = CGRectMake(0, 100, 320, 750); }
                     completion:^(BOOL finished){}];
    
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
















@end
