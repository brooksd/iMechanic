//
//  UpdateMaintenanceInfoViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "UpdateMaintenanceInfoViewController.h"

@interface UpdateMaintenanceInfoViewController ()

@end

@implementation UpdateMaintenanceInfoViewController

@synthesize carNicknameLabel;
@synthesize maintenanceTypeLabel;
@synthesize carNickname;
@synthesize maintenanceType;
@synthesize date;
@synthesize mileage;

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
    self.carNicknameLabel.text = self.carNickname;
    self.maintenanceTypeLabel.text = self.maintenanceType;
    self.date.returnKeyType = UIReturnKeyNext;
    self.date.delegate = self;
    self.mileage.delegate = self;
    self.date.tag = 100;
    self.mileage.tag = 101;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePressed:(id)sender
{
    NSString* curMiles;
    int curMilesInt;
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement;
    NSString *querySQL;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        if (self.maintenanceType == @"Update Oil Change"){
            querySQL = [NSString stringWithFormat:
                        @"SELECT mileage FROM oilinfo WHERE nickname = \"%@\"", self.carNickname];
        }
        else if (self.maintenanceType == @"Update Tire Rotation"){
            querySQL = [NSString stringWithFormat:
                        @"SELECT mileage FROM oilinfo WHERE nickname = \"%@\"", self.carNickname];
        }else if (self.maintenanceType == @"Update Alignment"){
            querySQL = [NSString stringWithFormat:
                        @"SELECT mileage FROM oilinfo WHERE nickname = \"%@\"", self.carNickname];
        }
        
        const char *insert_stmt = [querySQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt,
                           -1, &statement, NULL);
        if(sqlite3_step(statement)==SQLITE_ROW)
        {
            curMiles = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            curMilesInt = [curMiles intValue];
        }
        sqlite3_finalize(statement);
        
        int newMiles = [self.mileage.text intValue];
        if(newMiles > curMilesInt)
        {
            if (self.maintenanceType == @"Update Oil Change"){
                querySQL = [NSString stringWithFormat:
                            @"UPDATE oilinfo SET date= \"%@\", mileage = \"%@\" WHERE nickname = \"%@\"",
                            self.date.text, self.mileage.text, self.carNickname];
            }
            else if (self.maintenanceType == @"Update Tire Rotation"){
                querySQL = [NSString stringWithFormat:
                            @"UPDATE tireinfo SET date= \"%@\", mileage = \"%@\" WHERE nickname = \"%@\"",
                            self.date.text, self.mileage.text, self.carNickname];
            }else if (self.maintenanceType == @"Update Alignment"){
                querySQL = [NSString stringWithFormat:
                            @"UPDATE aligninfo SET date= \"%@\", mileage = \"%@\" WHERE nickname = \"%@\"",
                            self.date.text, self.mileage.text, self.carNickname];
            }
            
            insert_stmt = [querySQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,
                               -1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
            querySQL = [NSString stringWithFormat:
                        @"UPDATE carinfo SET mileage = \"%@\" WHERE nickname = \"%@\"",
                        self.mileage.text, self.carNickname];
            insert_stmt = [querySQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,
                               -1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            sqlite3_close(contactDB);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *invalidInput = [[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                                   message:@"New mileage less than current mileage." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [invalidInput show];
            sqlite3_close(contactDB);
            
        }
    }
}

- (IBAction)backgroundTouched:(id)sender
{
    [self.date resignFirstResponder];
    [self.mileage resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
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
    if(textField==self.date){
        return (textField.text.length + string.length <= 10);
    }else if (textField==self.mileage){
        return (textField.text.length + string.length <= 7);
    }
    else{
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [self.view viewWithTag:nextTag];

    if (nextResponder)
    {
        /*UIScrollView* v = (UIScrollView*) self.view ;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:v];
        rc.origin.x = 0 ;
        rc.origin.y -= 60 ;
        
        rc.size.height = 400;
        [v scrollRectToVisible:rc animated:YES];*/
        [nextResponder becomeFirstResponder];
    }
    else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}


@end
