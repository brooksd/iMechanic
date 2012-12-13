//
//  AddCarBasicViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "CarInfoViewController.h"
#import "MaintenanceInfoViewController.h"

@interface CarInfoViewController ()

@end

@implementation CarInfoViewController

@synthesize infoArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Car Info";
    self.navigationController.toolbarHidden = YES;
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonPressed)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.rightBarButtonItem = nextButton;
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextButtonPressed
{
    
    UITextField *makeField= (UITextField*)[self.tableView viewWithTag:100];
    UITextField *modelField= (UITextField*)[self.tableView viewWithTag:101];
    UITextField *mileageField= (UITextField*)[self.tableView viewWithTag:102];
    UITextField *nicknameField= (UITextField*)[self.tableView viewWithTag:103];
    MaintenanceInfoViewController *maintInfo = [[MaintenanceInfoViewController alloc] init];
    maintInfo.nickname = nicknameField.text;
    maintInfo.make=makeField.text;
    maintInfo.model=modelField.text;
    maintInfo.mileage=mileageField.text;
    [self.navigationController pushViewController:maintInfo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([indexPath section] == 0)
        {
            UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
            inputField.adjustsFontSizeToFitWidth = YES;
            inputField.textColor = [UIColor blueColor];
            if ([indexPath row] == 0)
            {
                inputField.tag = 100;
                cell.textLabel.text = @"Make";
                inputField.placeholder = @"Ex. Honda";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 1)
            {
                inputField.tag = 101;
                cell.textLabel.text = @"Model";
                inputField.placeholder = @"Ex. Accord";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 2)
            {
                inputField.tag = 102;
                cell.textLabel.text = @"Mileage";
                inputField.placeholder = @"Ex. 100000";
                inputField.keyboardType = UIKeyboardTypeNumberPad;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 3)
            {
                inputField.tag = 103;
                cell.textLabel.text = @"Nickname";
                inputField.placeholder = @"Ex. Son's Car";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyDone;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            inputField.autocorrectionType = UITextAutocorrectionTypeNo;
            inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            inputField.clearButtonMode = UITextFieldViewModeNever;
            inputField.delegate = self;
            [inputField setEnabled: YES];
            [cell addSubview:inputField];            
        }
    }
    return cell;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(theTextField.tag == 102)
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                UIAlertView *invalidInput = [[UIAlertView alloc] initWithTitle:@"Invalid Input"
                    message:@"Only numeric input allowed." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [invalidInput show];
                return NO;
            }
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [self.tableView viewWithTag:nextTag];
    
    if (nextResponder)
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - Table view delegate

@end
