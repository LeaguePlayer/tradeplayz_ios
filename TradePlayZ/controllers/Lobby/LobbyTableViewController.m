//
//  LobbyTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LobbyTableViewController.h"
#import "TournamentViewController.h"
#import "TournamentTableViewCell.h"

@interface LobbyTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* tournamentCellIdentifier = @"tournamentCell";

@implementation LobbyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35.f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.tableHeaderView = headerView;
    
    [self registerCell];
    
    
    self.title = [MCLocalization stringForKey:@"tournaments"];
}

- (void)registerCell
{
    [self.tableView registerClass:[TournamentTableViewCell class] forCellReuseIdentifier:tournamentCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initTableData];
    [self.tableView reloadData];
}

- (void)initTableData
{
    self.tableData = @[
                       
                       
                       @{@"type":tournamentCellIdentifier,
                         @"id":@"4",
                         @"date_begin":@"9:30",
                         @"prize_pool":@"4 000 000 TPZ",
                         @"registred_participants":@"12 833"},
                       @{@"type":tournamentCellIdentifier,
                         @"id":@"4",
                         @"date_begin":@"9:31",
                         @"prize_pool":@"4 000 000 TPZ",
                         @"registred_participants":@"12 833"},
                       @{@"type":tournamentCellIdentifier,
                         @"id":@"4",
                         @"date_begin":@"9:32",
                         @"prize_pool":@"4 000 000 TPZ",
                         @"registred_participants":@"12 833"},
                       ];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.tableData count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    UITableViewCell* cellDef;
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:tournamentCellIdentifier]) {
        TournamentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tournamentCellIdentifier];
        
        
        [cell setPrizePoolText:[dictionaryCell objectForKey:@"prize_pool"]];
        [cell setTime:[dictionaryCell objectForKey:@"date_begin"]];
        
        cellDef = cell;
    }
    
    
    
    
    
    return cellDef;
}

@end
