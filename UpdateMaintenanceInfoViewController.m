//
//  UpdateMaintenanceInfoViewController.m
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import "UpdateMaintenanceInfoViewController.h"

@interface UpdateMaintenanceInfoViewController ()

@end

@implementation UpdateMaintenanceInfoViewController

@synthesize carNicknameLabel;
@synthesize maintenanceTypeLabel;
@synthesize carNickname;
@synthesize maintenanceType;

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
    
    self.carNicknameLabel.text = self.carNickname;
    self.maintenanceTypeLabel.text = self.maintenanceType;
    self.date.returnKeyType = UIReturnKeyDone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePressed:(id)sender
{
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *tirestatement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO test (value, testname) VALUES (\"%@\", \"%@\")",
                               self.date.text, self.mileage.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt,
                           -1, &tirestatement, NULL);
        sqlite3_step(tirestatement);
        sqlite3_finalize(tirestatement);
    }
    sqlite3_close(contactDB);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backgroundTouched:(id)sender
{
    [self.date resignFirstResponder];
    [self.mileage resignFirstResponder];
}

@end
