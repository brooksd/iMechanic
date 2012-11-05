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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePressed:(id)sender
{
    // Store To Database
    [self.navigationController popViewControllerAnimated:YES];
}

@end
