//
//  HomeViewController.h
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
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
