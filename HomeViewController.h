//
//  HomeViewController.h
//  iMechanic
//
//  Created by Devin Brooks on 9/23/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface HomeViewController : UITableViewController
{
    NSMutableArray *carArray;
    UILabel *status;
    NSString        *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, retain) NSArray *carArray;

@property (strong, nonatomic) IBOutlet UILabel *status;

@end
