//
//  MaintenanceDetailsViewController.h
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MaintenanceDetailsViewController : UIViewController {
    UILabel *status;
    NSString        *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, retain) IBOutlet UILabel *carNicknameLabel;

@property (nonatomic, retain) IBOutlet UILabel *maintenanceDateLabel;

@property (nonatomic, retain) IBOutlet UILabel *mileageLabel;

@property (copy, nonatomic) NSString *carNickname;

@property (nonatomic, retain) IBOutlet UIImageView *maintenanceAlert;

-(IBAction)updateInfoPressed:(id)sender;

@end
