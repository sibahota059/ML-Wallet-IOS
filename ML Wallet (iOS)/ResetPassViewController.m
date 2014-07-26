//
//  ResetPassViewController.m
//  ML Wallet
//
//  Created by ml on 7/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ResetPassViewController.h"
#import "UITextfieldAnimate.h"

@interface ResetPassViewController ()

@end

@implementation ResetPassViewController
{
    UITextfieldAnimate *textAnimate;
}

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
    self.navigationController.navigationBarHidden = NO;
    
    
    //Define
    searchWhereOptions = [[NSMutableArray alloc] init];
    [searchWhereOptions addObject:@"What is your school in sixth grade?"];
    [searchWhereOptions addObject:@"What's your childhood nickname?"];
    [searchWhereOptions addObject:@"What's your mom's middle name?"];
    [searchWhereOptions addObject:@"What city was your first job?"];
    [searchWhereOptions addObject:@"What is your favorite movie?"];
    [searchWhereOptions addObject:@"What is your favorite TV program?"];
    [searchWhereOptions addObject:@"What city were you born?"];
    [searchWhereOptions addObject:@"Where did your parent's meet?"];
    [searchWhereOptions addObject:@"Whats your dad's middle name?"];
    
    // default list option to select
    selectedOption = 0;
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
        else //4 inc below
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground5.png"]]];
    }

    [self define];
    
}
#pragma mark - Define
- (void)define
{
    self.lblAnswer.delegate         = self;
    self.lblEmail.delegate          = self;
    self.lblSecQuestion.delegate    = self;
    self.lblUsername.delegate       = self;
    textAnimate = [UITextfieldAnimate new];
}

#pragma mark  - UITextFieldDelegate
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
}
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.lblUsername) {
        [self.lblEmail becomeFirstResponder];
        [self.lblUsername resignFirstResponder];
    } else if (textField == self.lblEmail) {
        [self.lblEmail resignFirstResponder];
        [self.lblAnswer becomeFirstResponder];
    } else if (textField == self.lblAnswer) {
        [self.lblAnswer resignFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark -Data Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [searchWhereOptions count];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width - 120, [pickerView rowSizeForComponent:component].height)];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        retval.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        retval.font = [UIFont systemFontOfSize:22];
    }
    
    retval.text = [searchWhereOptions objectAtIndex:row];
    return retval;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [searchWhereOptions objectAtIndex:row];
    
}

// this method runs whenever the user changes the selected list option

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // update label text to show selected option
    
    searchWhere.text = [searchWhereOptions objectAtIndex:row];
    
    // keep track of selected option (for next time we open the picker)
    
    selectedOption = row;
    
    NSLog(@"Select : %@", [searchWhereOptions objectAtIndex:row]);
    
}


- (IBAction)showSearchWhereOptions:(id)sender {
    
    // create action sheet
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Secret Question" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    // create frame for picker view
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    // create picker view
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerView.showsSelectionIndicator = YES;
    
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    // set selected option to what was previously selected
    
    [pickerView selectRow:selectedOption inComponent:0 animated:NO];
    
    // add picker view to action sheet
    
    [actionSheet addSubview:pickerView];
    
//    [pickerView release];
    
    // create close button to hide action sheet
    
    UISegmentedControl *select = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
    
    select.momentary = YES;
    
    select.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    
//    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    
    select.tintColor = [UIColor blackColor];
    
    // link close button to our dismissActionSheet method
    
    [select addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:select];
    
//    [closeButton release];
    
    // show action sheet
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 5.0f, 400, 485)];
    
}
- (void) dismissActionSheet {
    
    // hide action sheet
    self.SecQuestion.text = [searchWhereOptions objectAtIndex:selectedOption];
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}



@end
