//
//  MaintenanceInfoViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "MaintenanceInfoViewController.h"

@interface MaintenanceInfoViewController ()

@end

@implementation MaintenanceInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Maintenance Info";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)doneButtonPressed
{
    //Store Car Info To Database
    sqlite3_stmt    *carinfostatement;
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO carinfo (nickname, make, model, mileage) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                               self.nickname, self.make, self.model, self.mileage];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt,
                           -1, &carinfostatement, NULL);
        sqlite3_step(carinfostatement);
        sqlite3_finalize(carinfostatement);
    }
    
    //Prepare Info
    UITextField *oildate= (UITextField*)[self.tableView viewWithTag:100];
    UITextField *oilmiles= (UITextField*)[self.tableView viewWithTag:101];
    UITextField *oilinterval= (UITextField*)[self.tableView viewWithTag:102];
    UITextField *tiredate= (UITextField*)[self.tableView viewWithTag:103];
    UITextField *tiremiles= (UITextField*)[self.tableView viewWithTag:104];
    UITextField *tireinterval= (UITextField*)[self.tableView viewWithTag:105];
    UITextField *aligndate= (UITextField*)[self.tableView viewWithTag:106];
    UITextField *alignmiles= (UITextField*)[self.tableView viewWithTag:107];
    UITextField *aligninterval= (UITextField*)[self.tableView viewWithTag:108];
    
    if([oilmiles.text length] == 0 || [oildate.text length] == 0 || [oilinterval.text length] == 0 )
    {
        UIAlertView *invalidInput = [[UIAlertView alloc] initWithTitle:@"Required Field(s)"
                                                               message:@"You must enter a value for all oil fields." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [invalidInput show];
    }else{
        
        //Store Oil Info To Database
        sqlite3_stmt    *oilstatement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if([oilinterval.text length] == 0)
            {
                oilinterval.text = @"3000";
            }
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO oilinfo (nickname, date, mileage, interval) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                                   self.nickname, oildate.text,oilmiles.text,oilinterval.text];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,-1, &oilstatement, NULL);
            sqlite3_step(oilstatement);
            sqlite3_finalize(oilstatement);
        }
        
        //Store Tire Info To Database
        sqlite3_stmt    *tirestatement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if([tiredate.text length] == 0)
            {
                tiredate.text = @"N/A";
            }
            if([tiremiles.text length] == 0)
            {
                tiremiles.text = @"N/A";
            }
            if([tireinterval.text length] == 0)
            {
                tireinterval.text = @"6000";
            }
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO tireinfo (nickname, date, mileage, interval) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                                   self.nickname, tiredate.text, tiremiles.text, tireinterval.text];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,
                               -1, &tirestatement, NULL);
            sqlite3_step(tirestatement);
            sqlite3_finalize(tirestatement);
        }
        
        //Store Alignment Info To Database
        sqlite3_stmt    *alignstatement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if([aligndate.text length] == 0)
            {
                aligndate.text = @"N/A";
            }
            if([alignmiles.text length] == 0)
            {
                alignmiles.text = @"N/A";
            }
            if([aligninterval.text length] == 0)
            {
                aligninterval.text = @"6000";
            }
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO aligninfo (nickname, date, mileage, interval) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                                   self.nickname, aligndate.text,alignmiles.text,aligninterval.text];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,
                               -1, &alignstatement, NULL);
            sqlite3_step(alignstatement);
            sqlite3_finalize(alignstatement);
        }
        sqlite3_close(contactDB);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
        inputField.adjustsFontSizeToFitWidth = YES;
        inputField.textColor = [UIColor blueColor];
        if ([indexPath row] == 0)
        {
            inputField.tag = ([indexPath section] * 3 + 100);
            cell.textLabel.text = @"Date";
            inputField.placeholder = @"Ex. mm-dd-yyyy";
            inputField.keyboardType = UIKeyboardTypeDefault;
            inputField.returnKeyType = UIReturnKeyNext;
        }
        else if([indexPath row] == 1)
        {
            inputField.tag = ([indexPath section] * 3 + 101);
            cell.textLabel.text = @"Mileage";
            inputField.placeholder = @"Ex. 100000";
            inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            inputField.returnKeyType = UIReturnKeyNext;
        }
        else if([indexPath row] == 2)
        {
            inputField.tag = ([indexPath section] * 3 + 102);
            cell.textLabel.text = @"Interval";
            inputField.placeholder = @"Ex. 3000";
            inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            if([indexPath section] != 2)
            {
                inputField.returnKeyType = UIReturnKeyNext;
            }
            else
            {
                inputField.returnKeyType = UIReturnKeyDone;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        inputField.autocorrectionType = UITextAutocorrectionTypeNo;
        inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        inputField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
        inputField.delegate = self;
        [inputField setEnabled: YES];
        [cell addSubview:inputField];
    }
    return cell;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if((theTextField.tag % 3) != 0)
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-"];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Last Oil Change";
    }
    if (section == 1)
    {
        return @"Last Tire Rotation";
    }
    if (section == 2)
    {
        return @"Last Alignment";
    }
    return 0;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [self.tableView viewWithTag:nextTag];
    
    if (nextResponder)
    {
        // Found next responder, so set it
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(nextTag-100) % 3 inSection:(nextTag-100) / 3];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [nextResponder becomeFirstResponder];
    }
    else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
