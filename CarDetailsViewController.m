//
//  CarDetailsViewController.m
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
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
@synthesize mpdLabel;
@synthesize oilAlert;
@synthesize tireRotationAlert;
@synthesize alignmentAlert;
@synthesize carNickname;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*self.modelLabel.text = @"Ford";
     self.mileageLabel.text = @"Ford";
     self.mpdLabel.text = @"Ford";*/
    self.title = @"Car Details";
    self.nickname.text=carNickname;
    
    //sqlite3 *contactDB; //Declaring pointer to database
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement;
    NSString *make;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT make, model, mileage, (mileage/10) as mpd FROM carinfo WHERE nickname= \"%@\"",self.carNickname];
        
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
                NSString *mpd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                self.mpdLabel.text = mpd;
            }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
    
    UIImage *image = [UIImage imageNamed: @"AlertIcon.png"];
    [oilAlert setImage:image];
    [tireRotationAlert setImage:image];
    
    [alignmentAlert setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
