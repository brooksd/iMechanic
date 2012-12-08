//
//  HomeViewController.m
//  iMechanic
//
//  Created by Devin Brooks on 9/23/12.
//  Copyright (c) 2012 Devin Brooks. All rights reserved.
//

#import "HomeViewController.h"
#import "CarInfoViewController.h"
#import "CarDetailsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize carArray, status;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"iMechanic";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    // Do any additional setup after loading the view from its nib.
    /*////////////////////////////////////////////////////////////
    //// Query car database and place car nicknames in array /////
    ////////////////////////////////////////////////////////////*/

    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    
    self.toolbarItems = [NSArray arrayWithObjects: flexSpace, addButton, flexSpace, nil];
}

- (void)addButtonPressed
{
    CarInfoViewController *addCar = [[CarInfoViewController alloc] init];
    
    [self.navigationController pushViewController:addCar animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [carArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [carArray objectAtIndex:indexPath.row];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)viewWillAppear:(BOOL)animated {
    NSMutableArray *initCars = [[NSMutableArray alloc] initWithObjects: nil];
    self.carArray = initCars;
    const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
    sqlite3_stmt *statement;
    NSString *nickname;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT nickname FROM carinfo"];
        
        const char *query_stmt = [querySQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement)==SQLITE_ROW)
            {
                do {
                    nickname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    [initCars addObject:nickname];
                } while (sqlite3_step(statement)==SQLITE_ROW);
            }
        }
    }
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationController.toolbarHidden = NO;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *carNickname = cell.textLabel.text;
    
    CarDetailsViewController *carDetails = [[CarDetailsViewController alloc] init];
    carDetails.carNickname = carNickname;
    [self.navigationController pushViewController:carDetails animated:YES];
}

@end
