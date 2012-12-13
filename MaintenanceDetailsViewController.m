//
//  MaintenanceDetailsViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "MaintenanceDetailsViewController.h"
#import "UpdateMaintenanceInfoViewController.h"

@interface MaintenanceDetailsViewController ()

@end

@implementation MaintenanceDetailsViewController

@synthesize carNicknameLabel;
@synthesize carNickname;
@synthesize maintenanceAlert;
@synthesize mileageLabel;
@synthesize reminderLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carNicknameLabel.text = self.carNickname;
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement2;
    NSString* date;
    NSString* mileage;
    NSString* interval;
    NSString *querySQL;
    if (self.title==@"Oil Change")
    {
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage, interval FROM oilinfo WHERE nickname= \"%@\"",self.carNickname];
    }
    else if (self.title==@"Tire Rotation")
    {
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage, interval FROM tireinfo WHERE nickname= \"%@\"",self.carNickname];
    }
    else if (self.title==@"Alignment")
    {
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage, interval FROM aligninfo WHERE nickname= \"%@\"",self.carNickname];
    }
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_open(dbpath, &contactDB);
    sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement2, NULL);
    if(sqlite3_step(statement2)==SQLITE_ROW)
    {
        date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
        self.maintenanceDateLabel.text = date;
        mileage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
        self.mileageLabel.text = mileage;
        interval = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
        sqlite3_finalize(statement2);
    }
        int mileageInt = [mileage intValue];
        int intervalInt = [interval intValue];
        if (self.title==@"Oil Change")
        {
            if (mileageInt==0){
                self.reminderLabel.text = @"There is currently no data for tire rotation.  Please update info.";
            } else{
            self.reminderLabel.text=[NSString stringWithFormat:@"You are projected for your next oil change at %d miles!",mileageInt + intervalInt];
            }
        }else if (self.title==@"Tire Rotation"){
            if (mileageInt==0){
                self.reminderLabel.text = @"There is currently no data for tire rotation.  Please update info.";
            }else{
                self.reminderLabel.text=[NSString stringWithFormat:@"You are projected for your next tire rotation at %d miles!", mileageInt + intervalInt];
            }
        }else if (self.title==@"Alignment"){
            if (mileageInt==0){
                self.reminderLabel.text = @"There is currently no data for wheel alignment.  Please update info.";
            }else{
            self.reminderLabel.text=[NSString stringWithFormat:@"You are projected for your next wheel alignment at %d miles!",mileageInt + intervalInt];
            }
        }
    sqlite3_close(contactDB);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)updateInfoPressed:(id)sender
{
    UpdateMaintenanceInfoViewController *newMaintenanceInfo = [[UpdateMaintenanceInfoViewController alloc] init];
    newMaintenanceInfo.title = @"Update Info";
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
