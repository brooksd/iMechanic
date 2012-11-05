//
//  MaintenanceDetailsViewController.m
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import "MaintenanceDetailsViewController.h"
#import "UpdateMaintenanceInfoViewController.h"

@interface MaintenanceDetailsViewController ()

@end

@implementation MaintenanceDetailsViewController

@synthesize carNicknameLabel;
@synthesize carNickname;
@synthesize maintenanceAlert;

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
    sqlite3 *contactDB; //Declaring pointer to database
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement;
    NSString *date;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT oilChangeDate, tireDate, alignDate, oilMiles, tireMiles, alignMiles FROM carsdate WHERE nickname= \"%@\"",self.carNickname];
        
        const char *query_stmt = [querySQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                if(self.title == @"Oil Change")
                {
                date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                self.maintenanceDateLabel.text = date;
                NSString *mileage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                self.mileageLabel.text = mileage;
                }else if(self.title == @"Tire Rotation"){
                    date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    self.maintenanceDateLabel.text = date;
                    NSString *mileage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    self.mileageLabel.text = mileage;
                }else if(self.title == @"Alignment"){
                    date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    self.maintenanceDateLabel.text = date;
                    NSString *mileage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                    self.mileageLabel.text = mileage;
                }
            }
        }
        sqlite3_close(contactDB);
    }
    
    UIImage *image = [UIImage imageNamed: @"AlertIcon.png"];
    [maintenanceAlert setImage:image];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateInfoPressed:(id)sender
{
    UpdateMaintenanceInfoViewController *newMaintenanceInfo = [[UpdateMaintenanceInfoViewController alloc] init];
    newMaintenanceInfo.title = @"Update Info: ";
    newMaintenanceInfo.carNickname = self.carNickname;
    if(self.title == @"Oil Change")
    {
        newMaintenanceInfo.maintenanceType = @"Update Oil Change";
    }
    else if(self.title == @"Tire Rotation")
    {
        newMaintenanceInfo.maintenanceType = @"Update Tire Rotation";
    }
    else
    {
        newMaintenanceInfo.maintenanceType = @"Update Alignment";
    }
    [self.navigationController pushViewController:newMaintenanceInfo animated:YES];
}

@end
