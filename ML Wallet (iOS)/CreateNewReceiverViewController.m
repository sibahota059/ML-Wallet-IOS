//
//  CreateNewReceiverViewController.m
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "CreateNewReceiverViewController.h"
#import "UIAlertView+alertMe.h"
#import "MBProgressHUD.h"
#import "ServiceConnection.h"
#import "ReceiverMenuListViewController.h"
#import "UITextfieldAnimate.h"
#import "NSDictionary+LoadWalletData.h"

@interface CreateNewReceiverViewController ()

@end

@implementation CreateNewReceiverViewController
{
    NSString *walletno;
    
    UITextfieldAnimate *textAnimate;
}
@synthesize responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get Walletno
    NSDictionary *dic = [NSDictionary initRead_LoadWallet_Data];
    walletno = [dic objectForKey:@"walletno"];
    
    //Check if EDIT or NOT
    NSLog(@"IS Edit : %d", self.isEdit);
    if (self.isEdit) {
        self.txtFirstName.text  = self.fname;
        self.txtLastName.text   = self.lname;
        self.txtMiddleName.text = self.mname;
        self.txtAddress.text    = self.addrs;
        [self.txtRelation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.txtRelation.titleLabel.text = self.rlate;
        if (self.image != [UIImage imageNamed:@"noImage.png"]) {
           self.rec_image.image    = self.image;
        }
        
    }

    //relationView
    self.relationView.hidden = YES;
    
    //SetUP Loader
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    //Set Navigator
    [self navigator];
    [self.MyScrollview setScrollEnabled:YES];
    
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.MyScrollview setContentSize:CGSizeMake(320, 568)];
        }
        else //4 inc below
        {
            [self.MyScrollview setContentSize:CGSizeMake(320, 500)];
        }
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //UIText Delagate
    textAnimate = [UITextfieldAnimate new];
    self.txtFirstName.delegate  = self;
    self.txtLastName.delegate   = self;
    self.txtMiddleName.delegate = self;
    self.txtAddress.delegate    = self;
}

#pragma mark - UITextfield Delegate
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
}
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtFirstName)
    {
        [self.txtMiddleName becomeFirstResponder];
        [self.txtFirstName resignFirstResponder];
    }
    else if (textField == self.txtMiddleName)
    {
        [self.txtMiddleName resignFirstResponder];
        [self.txtLastName becomeFirstResponder];
    }
    else if (textField == self.txtLastName)
    {
        [self.txtLastName resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }
    else if (textField == self.txtAddress)
    {
        [self.txtAddress resignFirstResponder];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ((self.txtFirstName == textField) ||
         (self.txtLastName == textField) ||
         (self.txtMiddleName == textField) ||
         (self.txtAddress  == textField))
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        
        if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
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

}


#pragma Start #Navigator
- (void)navigator
{
    self.title = @"New Receiver";
    UIBarButtonItem *buttonAddReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save.png"] style:UIBarButtonItemStyleDone  target:self action:@selector(saveReceiver)];
    self.navigationItem.rightBarButtonItem = buttonAddReceiver;
}

#pragma mark - Encode Image to String & Resize Image
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
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
/*
- (void) imageRequest {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myurltouploadimage.com/services/v1/upload.json"]];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/design%i.png",docDir, designNum];
    NSLog(@"%@",path);
    
    NSData *imageData = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:path]);
    [Base64 initialize];
    NSString *imageString = [Base64 encode:imageData];
    
    NSArray *keys = [NSArray arrayWithObjects:@"design",nil];
    NSArray *objects = [NSArray arrayWithObjects:imageString,nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:kNilOptions error:&error];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"Image uploaded");
    
}
*/

#pragma Start #Save New Receiver
- (void)saveReceiver
{
    NSString *lname     = self.txtLastName.text;
    NSString *mname     = self.txtMiddleName.text;
    NSString *fname     = self.txtFirstName.text;
    NSString *address   = self.txtAddress.text;
    NSString *relation  = self.txtRelation.titleLabel.text;
    UIImage *recImage   = self.rec_image.image;
    NSString *strImage;
    NSArray *arrayString;
    CGSize size = CGSizeMake(200, 200);
    
    NSArray *keys ;
    NSArray *objects ;
    NSDictionary *jsonDictionary ;
    
    if (self.rec_image.image != [UIImage imageNamed:@"noImage.png"]) {
        recImage = [self imageWithImage:recImage scaledToSize:size];
        strImage = [self encodeToBase64String:recImage];
        arrayString = [NSArray arrayWithObject:strImage];
    } else {
        arrayString = [NSArray arrayWithObjects:@"", nil];
    }
    
    //Validation NuLL Value
    if ([lname isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Lastname must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([fname isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Firstname must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([address isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Address must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([relation isEqualToString:@"Relation"]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Relation must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    }
   
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES navigatorItem:self.navigationItem];
    
    self.responseData = [NSMutableData data];
    if (self.isEdit)
    {
        keys = [NSArray arrayWithObjects:@"walletno",@"receiverno",@"fname",@"mname",@"lname",@"relation",@"photo",@"address",nil];
        objects = [NSArray arrayWithObjects:walletno,self.recNo,fname,mname,lname,relation,arrayString,address ,nil];
        jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"updateReceiver"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:kNilOptions error:&error];
        
        [request setHTTPMethod:@"PUT"];
        [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        [NSURLConnection connectionWithRequest:request delegate:self];

    } else {
        //Rest Service
        keys = [NSArray arrayWithObjects:@"walletno",@"fname",@"mname",@"lname",@"relation",@"photo",@"address",nil];
        objects = [NSArray arrayWithObjects:walletno,fname,mname,lname,relation,arrayString,address ,nil];
        jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"addReceiverList"];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
        
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:kNilOptions error:&error];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma mark - NSURLConnection Delegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // convert to JSON
    if (self.responseData == nil) {
        [UIAlertView myCostumeAlert:@"Exception Error" alertMessage:@"No Data found" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        return;
    }
    
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil) {
        if (self.isEdit) {
            res = [res valueForKey:@"updateReceiverResult"];
        }
        
        NSNumber *respCode = [res valueForKey:@"respcode"];
        NSString *respMesg = [res valueForKey:@"respmessage"];
    
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
            if(self.isEdit)
            {
                [UIAlertView myCostumeAlert:@"Edit Receiver" alertMessage:@"Receiver successfuly edited" delegate:self cancelButton:@"Ok" otherButtons:nil];
            } else {
                [UIAlertView myCostumeAlert:@"Create Receiver" alertMessage:@"New receiver successfuly added" delegate:self cancelButton:@"Ok" otherButtons:nil];
            }
        } else {
             [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
        
    } else {
        [UIAlertView myCostumeAlert:@"Exception Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Ok"]) {
        ReceiverMenuListViewController *bckList = [[ReceiverMenuListViewController alloc] initWithNibName:@"ReceiverMenuListViewController" bundle:nil];
        [self.navigationController pushViewController:bckList animated:YES];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideRelationView {
    [self.view endEditing:YES];
    
    if (self.relationView.hidden) {
            self.relationView.hidden = NO;
    } else {
            self.relationView.hidden = YES;
    }
}

- (IBAction)btnRelation:(id)sender {
    [self hideRelationView];
}

- (IBAction)btnFamily:(id)sender {
    [self.txtRelation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.txtRelation.titleLabel.text = @"Family";
    [self hideRelationView];
}

- (IBAction)btnFriend:(id)sender {
    [self.txtRelation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.txtRelation.titleLabel.text = @"Friend";    
    [self hideRelationView];
}

#pragma mark - Get Photo
- (IBAction)btnGetPhoto:(id)sender {
   
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate         = self;
    picker.allowsEditing    = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self.navigationController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *buttonImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.rec_image.image = buttonImage;
    
    NSLog(@"H and W : %f %f",buttonImage.size.height, buttonImage.size.width);
    
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
@end
