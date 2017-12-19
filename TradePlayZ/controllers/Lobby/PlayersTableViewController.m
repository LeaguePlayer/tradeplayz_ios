//
//  PlayersTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 30.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PlayersTableViewController.h"
#import "PlayersPaddingTableViewCell.h"
#import "headerView.h"


@interface PlayersTableViewController ()

@property (strong, nonatomic) NSArray* playersTableData;




@end

//cells
static NSString* playersCellIdentifier = @"playersCell";

@implementation PlayersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [MCLocalization stringForKey:@"table_prizes"];
    query_string = @"";
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:[UIColor whiteColor]];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 40.f, 0, 40);
    
    
//    [self.tableView setFrame:CGRectMake(40.f, 0, SCREEN_WIDTH - (40*2), self.tableView.frame.size.height)];
//    [self.tableView edge]
    
    
    UIView *mainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    [mainHeaderView setBackgroundColor:[UIColor clearColor]];
    
     float paddingLeft = (SCREEN_WIDTH * 10.35f) / 100;
    headerView *tableHeaderView = [[headerView alloc] initWithFrame:CGRectMake(paddingLeft, 100-1.5f, SCREEN_WIDTH-(paddingLeft*2), 30)];
    [tableHeaderView setColumns:@[
                                         @{@"width":@12,
                                           @"name":[MCLocalization stringForKey:@"place"]},

                                         @{@"width":@75,
                                           @"name":[MCLocalization stringForKey:@"player_title"]},

                                         @{@"width":@13,
                                           @"name":[MCLocalization stringForKey:@"status_title"]},

                                         ]];
    
    [mainHeaderView addSubview:tableHeaderView];
    
    float widthField = 227.f;
    float heightField = 34;
    _searchField = [[SmallBaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-widthField)/2, (CGRectGetHeight(mainHeaderView.frame)-heightField-30.f)/2, widthField, heightField)];
    _searchField.delegate = self;
    _searchField.tag = 0;
    [_searchField setPlaceHolderText:[MCLocalization stringForKey:@"search"]];
    [mainHeaderView addSubview:_searchField];
    
    _activityView = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    _activityView.frame = CGRectMake((SCREEN_WIDTH-widthField)/2-heightField-8.f, (CGRectGetHeight(mainHeaderView.frame)-heightField-30.f)/2, heightField, heightField);
    [_activityView startAnimating];
    _activityView.alpha = 0.f;
    [mainHeaderView addSubview:_activityView];

    self.tableView.tableHeaderView = mainHeaderView;
    
    

    
    
    
    
    
    
    // registerCell
    [self registerCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    float width_table = SCREEN_WIDTH -  (40*2);
//    [self.tableView setContentSize:CGSizeMake(width_table, self.tableView.contentSize.height)];
    
    
    //set content
    [self initData];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        query_string = textField.text;
        [textField resignFirstResponder];
        
        [self initData];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}



-(void)initData
{
    _activityView.alpha = 1.f;
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    
    
    [[[APIModel alloc] init] getAllParticipantsWithToken:self.authUser.token andQuery:query_string andTourID:_selectedTourID  onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[[data objectForKey:@"response"] objectForKey:@"tournament"] objectForKey:@"participants"];
        
        for(NSDictionary* participant in obj)
            [tmpData addObject:@{@"place":[participant objectForKey:@"row"],
                                 @"player":[participant objectForKey:@"fullname"],
                                 @"id_status":[participant objectForKey:@"id_status"],
                                 @"status":[participant objectForKey:@"status"],
                                 @"me":[participant objectForKey:@"me"]}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playersTableData = tmpData;
            // buildContent
            [self.tableView reloadData];
            _activityView.alpha = 0.f;
            
            if(_beginSearch)
            {
                _beginSearch = NO;
                [_searchField becomeFirstResponder];
            }
        });
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        _activityView.alpha = 0.f;
    }];
}


- (void)registerCell
{
    
    [self.tableView registerClass:[PlayersPaddingTableViewCell class] forCellReuseIdentifier:playersCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.playersTableData count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28.f;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* dictionaryCell;
    UITableViewCell* cellDef;
    
    
    dictionaryCell = [self.playersTableData objectAtIndex:indexPath.row];
    
    PlayersPaddingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:playersCellIdentifier];
    cell.placeLabel.text = [dictionaryCell objectForKey:@"place"];
    cell.playerLabel.text = [dictionaryCell objectForKey:@"player"];
    cell.statusLabel.text = [dictionaryCell objectForKey:@"status"];
    cell.showMe = [[dictionaryCell objectForKey:@"me"] boolValue];
    cell.status = [[dictionaryCell objectForKey:@"id_status"] integerValue];
    [cell changeStatus];
    
    
//    CGRect cellFrame = CGRectMake(100,0,200,200); //CHANGE FRAME FOR YOUR APP
//    [cell setFrame:cellFrame];
    
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
