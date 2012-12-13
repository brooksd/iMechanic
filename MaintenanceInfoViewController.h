//
//  MaintenanceInfoViewController.h
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MaintenanceInfoViewController : UITableViewController <UITextFieldDelegate>
{
    NSMutableArray *infoArray;
    UILabel *status;
    NSString *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *make;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *mileage;

@end
