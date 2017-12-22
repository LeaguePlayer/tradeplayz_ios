//
//  HistoryTradeTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "HistoryTradeTableViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryModalView.h"

@interface HistoryTradeTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end


//cells
static NSString* historyCellIdentifier = @"historyCell";

@implementation HistoryTradeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [MCLocalization stringForKey:@"TradeHistory"];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
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
}


- (void)initTableData
{
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    [[[APIModel alloc] init] getHistoryWithToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"history"];
        
        for(NSDictionary* history in obj)
            [tmpData addObject:@{@"type":historyCellIdentifier,
                                 @"date_begin":[history objectForKey:@"begin_date"],
                                 @"time_begin":[history objectForKey:@"begin_time"],
                                 @"result":[history objectForKey:@"prize_won"],
                                 @"prize_pool":[history objectForKey:@"prize_pool"],
                                 @"buy_in":[history objectForKey:@"buyin"]}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableData = tmpData;
            // buildContent
            [self.tableView reloadData];
        });
    } onFailure:^(NSString *error) {
         [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
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


//[tmpData addObject:@{@"type":historyCellIdentifier,
//                     @"date_begin":[history objectForKey:@"begin_date"],
//                     @"time_begin":[history objectForKey:@"begin_time"],
//                     @"result":[history objectForKey:@"prize_won"],
//                     @"prize_pool":[history objectForKey:@"prize_pool"],
//                     @"buy_in":[history objectForKey:@"buyin"]}];
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    HistoryModalView* contentView = [[HistoryModalView alloc] init];
    contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 230.f);
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_modal"]];
    contentView.datePlaceLabel.text = [dictionaryCell objectForKey:@"date_begin"];
    contentView.timePlaceLabel.text = [dictionaryCell objectForKey:@"time_begin"];
    contentView.prizeWinPlaceLabel.text = [dictionaryCell objectForKey:@"result"];
    contentView.prizePoolPlaceLabel.text = [dictionaryCell objectForKey:@"prize_pool"];
    contentView.buyinPlaceLabel.text = [dictionaryCell objectForKey:@"buy_in"];
    
    self.popup = [KLCPopup popupWithContentView:contentView];
    [_popup show];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
