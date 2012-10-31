//
//  AddCarBasicViewController.h
//  iMechanic
//
//  Created by Devin Brooks on 9/24/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface CarInfoViewController : UITableViewController <UITextFieldDelegate>
{
    NSMutableArray *infoArray;
}

@property (nonatomic, retain) NSArray *infoArray;

@end
