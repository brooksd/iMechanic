//
//  HomeViewController.m
//  iMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
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
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Car List";
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* deleteNickname = cell.textLabel.text;
    [carArray removeObjectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        const char *dbpath = [@"/Users/jakelogan/carsdata.sqlite" UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"DELETE FROM carinfo WHERE nickname = \"%@\"",
                                   deleteNickname];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,-1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
            insertSQL = [NSString stringWithFormat:
                                   @"DELETE FROM oilinfo WHERE nickname = \"%@\"",
                                   deleteNickname];
            
            insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,-1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
            insertSQL = [NSString stringWithFormat:
                                   @"DELETE FROM tireinfo WHERE nickname = \"%@\"",
                                   deleteNickname];
            
            insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,-1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
            insertSQL = [NSString stringWithFormat:
                                   @"DELETE FROM aligninfo WHERE nickname = \"%@\"",
                                   deleteNickname];
            
            insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt,-1, &statement, NULL);
            sqlite3_step(statement);
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        [tableView reloadData];
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
    sqlite3_close(contactDB);
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationController.toolbarHidden = NO;
}

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
