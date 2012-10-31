//
//  UpdateMaintenanceInfoViewController.h
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMaintenanceInfoViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *carNicknameLabel;

@property (nonatomic, retain) IBOutlet UILabel *maintenanceTypeLabel;

@property (copy, nonatomic) NSString *carNickname;

@property (copy, nonatomic) NSString *maintenanceType;

-(IBAction)savePressed:(id)sender;

@end
