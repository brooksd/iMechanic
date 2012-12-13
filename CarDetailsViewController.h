//
//  CarDetailsViewController.h
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface CarDetailsViewController : UIViewController{
    UILabel *status;
    NSString        *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, retain) IBOutlet UILabel *nickname;
@property (nonatomic, retain) IBOutlet UILabel *makeLabel;
@property (nonatomic, retain) IBOutlet UILabel *modelLabel;
@property (nonatomic, retain) IBOutlet UILabel *mileageLabel;
@property (copy, nonatomic) NSString *carNickname;
-(IBAction)oilChangePressed:(id)sender;
-(IBAction)tireRotationPressed:(id)sender;
-(IBAction)alignmentPressed:(id)sender;

@end
