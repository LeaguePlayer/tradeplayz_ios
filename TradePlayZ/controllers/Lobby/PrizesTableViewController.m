//
//  PrizesTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PrizesTableViewController.h"
#import "PrizeTableViewCell.h"
#import "headerView.h"

@interface PrizesTableViewController ()
@property (strong, nonatomic) NSArray* prizesTableData;
@end



//cells
static NSString* prizeCellIdentifier = @"prizeCell";

@implementation PrizesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [MCLocalization stringForKey:@"table_prizes"];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
     [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 40.f, 0, 0);
   
    
    
    headerView *tableHeaderView = [[headerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-(40*2), 30)];
    [tableHeaderView setColumns:@[
                                  @{@"width":@80,
                                    @"name":[MCLocalization stringForKey:@"place"]},

                                  @{@"width":@20,
                                    @"name":[MCLocalization stringForKey:@"prize_tpz"]},

                                  ]];
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    //set content
    [self initData];
    
    // registerCell
    [self registerCell];
}


- (void)viewDidAppear:(BOOL)animated
{
    float width_table = SCREEN_WIDTH -  (40*2);
     [self.tableView setContentSize:CGSizeMake(width_table, self.tableView.contentSize.height)];
}


-(void)initData
{
//     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    
    [[[APIModel alloc] init] getAllPrizesByTourID:_selectedTourID andToken:self.authUser.token onSuccess:^(NSDictionary *data) {
            NSDictionary *obj = [[[data objectForKey:@"response"] objectForKey:@"tournament"] objectForKey:@"prizes"];
        
            for(NSDictionary* prize in obj)
                [tmpData addObject:@{@"place":[prize objectForKey:@"row_number"],
                                     @"prize":[prize objectForKey:@"prize"]}];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.prizesTableData = tmpData;
                // buildContent
                [self.tableView reloadData];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
    } onFailure:^(NSString *error) {
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
         [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
    

    
}


- (void)registerCell
{
    
    [self.tableView registerClass:[PrizeTableViewCell class] forCellReuseIdentifier:prizeCellIdentifier];
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
    return [self.prizesTableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28.f;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* dictionaryCell;
    UITableViewCell* cellDef;
    

        dictionaryCell = [self.prizesTableData objectAtIndex:indexPath.row];
        
        PrizeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:prizeCellIdentifier];
        cell.placeLabel.text = [dictionaryCell objectForKey:@"place"];
        cell.prizeLabel.text = [dictionaryCell objectForKey:@"prize"];
        
        cellDef = cell;
    
    
    
    
    return cellDef;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
