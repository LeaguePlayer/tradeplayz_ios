//
//  HistoryTradeTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "HistoryTradeTableViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryTradeTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end


//cells
static NSString* historyCellIdentifier = @"historyCell";

@implementation HistoryTradeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [MCLocalization stringForKey:@"TradeHistory"];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [headerView setBackgroundColor:[UIColor clearColor]];

    self.tableView.tableHeaderView = headerView;
    
    
   
   
    
    
    [self registerCell];
}


- (void)registerCell
{
    [self.tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:historyCellIdentifier];
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
                       
                       
                       @{@"type":historyCellIdentifier,
                         @"date_begin":@"12.08.17",
                         @"time_begin":@"9:30",
                         @"result":@"10 000",
                         @"prize_pool":@"4 000 000",
                         @"buy_in":@"FREE ROLL"},
                       
                       @{@"type":historyCellIdentifier,
                         @"date_begin":@"13.08.17",
                         @"time_begin":@"9:30",
                         @"result":@"10 000",
                         @"prize_pool":@"4 000 000",
                         @"buy_in":@"FREE ROLL"},
                       
                       
                       @{@"type":historyCellIdentifier,
                         @"date_begin":@"14.08.17",
                         @"time_begin":@"9:30",
                         @"result":@"10 000",
                         @"prize_pool":@"4 000 000",
                         @"buy_in":@"FREE ROLL"},
                       
                       
                       @{@"type":historyCellIdentifier,
                         @"date_begin":@"15.08.17",
                         @"time_begin":@"9:30",
                         @"result":@"10 000",
                         @"prize_pool":@"4 000 000",
                         @"buy_in":@"FREE ROLL"},
                       
                       
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
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:historyCellIdentifier]) {
        HistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:historyCellIdentifier];
    
        
        [cell setResult:[dictionaryCell objectForKey:@"result"]];
        [cell setDate:[dictionaryCell objectForKey:@"date_begin"] andTime:[dictionaryCell objectForKey:@"time_begin"]];
        
        cellDef = cell;
    }
   
    
    
    
    
    return cellDef;
}

@end
