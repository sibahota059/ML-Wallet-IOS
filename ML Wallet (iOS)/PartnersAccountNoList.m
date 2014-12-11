//
//  PartnersAccountNoList.m
//  ML Wallet
//
//  Created by mm20-18 on 11/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "PartnersAccountNoList.h"
#import "EditInformationCell.h"

@implementation PartnersAccountNoList
{
    NSMutableArray *testArray;
}

@synthesize cancelButton;
@synthesize deleteButton;
@synthesize accountNo;
@synthesize accountNoList;

UITableView *accountNoListTable;

- (id)initWithFrame:(CGRect)frame accountNoListPar:(NSMutableArray *)accountNoListPar
{
    self = [super initWithFrame:frame];
    if (self) {
        
        testArray = [accountNoListPar valueForKey:@"AccountNo"];
        
//        int i = 0;
//        while(i < [accountNoListPar count])
//        {
//            [testArray addObject:[accountNoListPar valueForKey:@"AccountNo"]];
//        }
        
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        [title setText:@"Choose Account Number:"];
        [title setTextColor:[UIColor whiteColor]];
        [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        title.textAlignment = NSTextAlignmentCenter;
        [title setBackgroundColor:[UIColor blackColor]];

        accountNoListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 280, 220)];

        accountNoListTable.delegate = self;
        accountNoListTable.dataSource = self;
        
        
                //CANCEL BUTTON
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 120, 30)];
        
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                                forState:UIControlStateNormal];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setTintColor:[UIColor whiteColor]];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        
        //DELETE BUTTON
        deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 260, 120, 30)];
        
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                                forState:UIControlStateNormal];
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [deleteButton setTintColor:[UIColor whiteColor]];
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        

        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:title];
        [self addSubview:accountNoListTable];
        [self addSubview:cancelButton];
        [self addSubview:deleteButton];
        
    
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [testArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"EditInformationCell";
    
//    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 50)];
//    UIImageView *accessoryViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIndicator.png"]];
//    [accessoryView addSubview:accessoryViewImage];
//    accessoryViewImage.center = CGPointMake(12, 25);
    
    EditInformationCell *cell = (EditInformationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditInformationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    [cell setAccessoryView:accessoryView];
    cell.textLabel.text = [testArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.accountNo = [testArray objectAtIndex:indexPath.row];
//    backgroundDim = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ [ UIScreen mainScreen ] bounds ].size.width, [ [ UIScreen mainScreen ] bounds ].size.height)];
//    [backgroundDim setBackgroundColor:[UIColor blackColor]];
//    [backgroundDim setAlpha:0.6f];
//    
//    partnersAccountNo = [[PartnersAccountNoList alloc] initWithFrame:CGRectMake(20, 20, 280, 300)];
//    
//    [partnersAccountNo.cancelButton addTarget:self action:@selector(cancelMethod:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:backgroundDim];
//    [self.view addSubview:partnersAccountNo];
    
//    partnersAccountNo.hidden = NO;
    
}


-(void)delete:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account number to be deleted" message:self.accountNo delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}


@end
