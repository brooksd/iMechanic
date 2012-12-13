//
//  CarDetailsViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "MaintenanceDetailsViewController.h"

@interface CarDetailsViewController ()

@end

@implementation CarDetailsViewController

@synthesize nickname;
@synthesize makeLabel;
@synthesize modelLabel;
@synthesize mileageLabel;
@synthesize carNickname;

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
    self.title = @"Car Details";
    self.nickname.text=carNickname;
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement;
    NSString *make;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT make, model, mileage FROM carinfo WHERE nickname= \"%@\"",self.carNickname];
        
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                make = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                self.makeLabel.text = make;
                NSString *model = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                self.modelLabel.text = model;
                NSString *mileage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                self.mileageLabel.text = mileage;
            }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)oilChangePressed:(id)sender
{
    MaintenanceDetailsViewController *oilChangeDetails = [[MaintenanceDetailsViewController alloc] init];
    oilChangeDetails.carNickname = self.carNickname;
    oilChangeDetails.title = @"Oil Change";
    [self.navigationController pushViewController:oilChangeDetails animated:YES];
    
}

-(IBAction)tireRotationPressed:(id)sender
{
    MaintenanceDetailsViewController *tireRotationDetails = [[MaintenanceDetailsViewController alloc] init];
    tireRotationDetails.carNickname = self.carNickname;
    tireRotationDetails.title = @"Tire Rotation";
    [self.navigationController pushViewController:tireRotationDetails animated:YES];
}

-(IBAction)alignmentPressed:(id)sender
{
    MaintenanceDetailsViewController *alignmentDetails = [[MaintenanceDetailsViewController alloc] init];
    alignmentDetails.carNickname = self.carNickname;
    alignmentDetails.title = @"Alignment";
    [self.navigationController pushViewController:alignmentDetails animated:YES];
}

@end
