//
//  CarDetailsViewController.h
//  iMechanic
//
//  Created by Devin Brooks on 10/10/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
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

@property (nonatomic, retain) IBOutlet UILabel *mpdLabel;

@property (nonatomic, retain) IBOutlet UIImageView *oilAlert;

@property (nonatomic, retain) IBOutlet UIImageView *tireRotationAlert;

@property (nonatomic, retain) IBOutlet UIImageView *alignmentAlert;

@property (copy, nonatomic) NSString *carNickname;

-(IBAction)oilChangePressed:(id)sender;

-(IBAction)tireRotationPressed:(id)sender;

-(IBAction)alignmentPressed:(id)sender;

@end
