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
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carNicknameLabel.text = self.carNickname;
    
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement2;
    NSString* date;
    NSString* mileage;
    NSString *querySQL;
    if (self.title==@"Oil Change"){
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage FROM oilinfo WHERE nickname= \"%@\"",self.carNickname];
    }else if (self.title==@"Tire Rotation"){
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage FROM tireinfo WHERE nickname= \"%@\"",self.carNickname];
    }else if (self.title==@"Alignment"){
        querySQL=[NSString stringWithFormat:@"SELECT date, mileage FROM aligninfo WHERE nickname= \"%@\"",self.carNickname];
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
    }
    sqlite3_finalize(statement2);
    sqlite3_close(contactDB);
    UIImage *image = [UIImage imageNamed: @"AlertIcon.png"];
    [maintenanceAlert setImage:image];
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
