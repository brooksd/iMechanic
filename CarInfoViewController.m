//
//  AddCarBasicViewController.m
//  iMechanic
//
//  Created by Devin Brooks on 9/24/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
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
    if (self) {
        // Custom initialization
    }
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextButtonPressed
{
    MaintenanceInfoViewController *maintInfo = [[MaintenanceInfoViewController alloc] init];
    
    [self.navigationController pushViewController:maintInfo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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
                inputField.tag = 0;
                cell.textLabel.text = @"Make";
                inputField.placeholder = @"Ex. Honda";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 1)
            {
                inputField.tag = 1;
                cell.textLabel.text = @"Model";
                inputField.placeholder = @"Ex. Accord";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 2)
            {
                inputField.tag = 2;
                cell.textLabel.text = @"Mileage";
                inputField.placeholder = @"Ex. 100000";
                inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else if([indexPath row] == 3)
            {
                inputField.tag = 3;
                cell.textLabel.text = @"Nickname";
                inputField.placeholder = @"Ex. Son's Car";
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyDone;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            inputField.autocorrectionType = UITextAutocorrectionTypeNo;
            inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            inputField.textAlignment = UITextAlignmentLeft;
            inputField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
            inputField.delegate = self;
            [inputField setEnabled: YES];
            [cell addSubview:inputField];            
        }
    }
    return cell;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(theTextField.tag == 2)
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
    // Try to find next responder
    UIResponder* nextResponder = [self.tableView viewWithTag:nextTag];
    
    if (nextResponder)
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
}
*/
@end
