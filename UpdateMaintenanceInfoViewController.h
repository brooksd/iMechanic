//
//  UpdateMaintenanceInfoViewController.h
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface UpdateMaintenanceInfoViewController : UIViewController <UITextFieldDelegate>
{
    UILabel *status;
    NSString *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, retain) IBOutlet UILabel *carNicknameLabel;
@property (nonatomic, retain) IBOutlet UILabel *maintenanceTypeLabel;
@property (retain, nonatomic) IBOutlet UITextField *date;
@property (retain, nonatomic) IBOutlet UITextField *mileage;
@property (copy, nonatomic) NSString *carNickname;
@property (copy, nonatomic) NSDate *updateDate;
@property (copy, nonatomic) NSString *maintenanceType;
-(IBAction)savePressed:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
