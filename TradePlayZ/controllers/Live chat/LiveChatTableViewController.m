//
//  LiveChatTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LiveChatTableViewController.h"
#import "ChatTableViewCell.h"

@interface LiveChatTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* chatCellIdentifier = @"chatCell";

@implementation LiveChatTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MCLocalization stringForKey:@"Live chat"];
    
    self.tableView.allowsSelection = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel* helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SCREEN_WIDTH-(40*2), 15)];
    [helpLabel setNumberOfLines:0];
    [helpLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    [helpLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
    [helpLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    helpLabel.text = [MCLocalization stringForKey:@"help_chat_label"];
    [helpLabel sizeToFit];
    [helpLabel setTextAlignment:NSTextAlignmentCenter];
    
    [headerView addSubview:helpLabel];
    self.tableView.tableHeaderView = headerView;
    
    [self registerCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerCell
{
    [self.tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:chatCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initTableData];
//    [self.tableView reloadData];
}


- (void)initTableData
{
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    [[[APIModel alloc ] init] getChatListWithToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"chat"];
        
        for(NSDictionary* chat in obj)
            [tmpData addObject:@{@"type":chatCellIdentifier,
                                 @"side":[chat objectForKey:@"type"], //  1 - right side your question // 2- right side admin answer
                                 @"name":[chat objectForKey:@"name"],
                                 @"message":[chat objectForKey:@"message"]}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableData = tmpData;
            // buildContent
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
    
}
//#define widthImageView 45.f
//#define triangle 7.f
//#define left_right_padding 28.f
//#define padding_top 10.f
//#define padding_for_text 10.f
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    ChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:chatCellIdentifier];
    float width_place = SCREEN_WIDTH - ((28.f+7.f+45.f) *2);
    
    CGSize nameLabelSize = [Functions getHeightTextWithoutLabel:cell.nameLabel.font andWidthWillLabel:width_place andString:[dictionaryCell objectForKey:@"name"]];
    CGSize messageLabelSize =[Functions getHeightTextWithoutLabel:cell.messageLabel.font andWidthWillLabel:width_place andString:[dictionaryCell objectForKey:@"message"]];
    
    return ([[dictionaryCell objectForKey:@"name"] length]) ? 10 + nameLabelSize.height + 10 + messageLabelSize.height +10 + 10 + 10 : 10 + messageLabelSize.height + 10 + 10 + 10;
//    return 100.f;
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
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:chatCellIdentifier]) {
        ChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:chatCellIdentifier];
        
        
        [cell setName:[dictionaryCell objectForKey:@"name"] andMessage:[dictionaryCell objectForKey:@"message"]];
        
        if([[dictionaryCell objectForKey:@"side"] isEqualToString:@"0"]) // leftSide admin answer
        {
            [cell.avatarImageView setImage:[UIImage imageNamed:@"avatar"]];
            [cell setLeftSide];
        }
        else // right side your question
        {
            [cell.avatarImageView setImageWithURL:[NSURL URLWithString:self.authUser.img_avatar] placeholderImage:[UIImage imageNamed:@"avatar"]];
            [cell setRightSide];
        }
        
        cellDef = cell;
    }
    
    
    
    
    
    return cellDef;
}

@end
