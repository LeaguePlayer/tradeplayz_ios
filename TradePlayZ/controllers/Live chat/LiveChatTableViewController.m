//
//  LiveChatTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LiveChatTableViewController.h"
#import "ChatTableViewCell.h"
//

//#import "MessageTextView.h"

@interface LiveChatTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* chatCellIdentifier = @"chatCell";

@implementation LiveChatTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MCLocalization stringForKey:@"Live chat"];
//    [super initWithTableViewStyle:UITableViewStylePlain];
    self.tableView.allowsSelection = NO;
//    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
    if(self.messageTextView==nil)
        self.messageTextView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableView.frame)-50.f, SCREEN_WIDTH, 50)];
    
    [self.messageTextView setBackgroundColor:[UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:0.4]];
//    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    [self.revealViewController.frontViewController.view addSubview:self.messageTextView];
    
    
    float spacing = 10.f;
    float widthButton = 95.f;
    if(self.messageField ==nil){
        self.messageField = [[UITextField alloc] initWithFrame:CGRectMake(spacing,7.f,SCREEN_WIDTH-( (spacing*3)+widthButton ),35)];
    }
    [self.messageField setBackgroundColor:[UIColor clearColor]];
    self.messageField.delegate = self;
    [self.messageTextView addSubview:self.messageField];
    [self.messageField setTextColor:[UIColor whiteColor]];
    [self.messageField setTextAlignment:NSTextAlignmentLeft];
    //
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(sendMessage:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:[MCLocalization stringForKey:@"send"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button.frame = CGRectMake( CGRectGetWidth(self.messageField.frame)+spacing*2 ,7.f,widthButton,35);
    //    [button setBackgroundColor:[UIColor redColor]];
    
    [self.messageTextView addSubview:button];
    
    
    
    
//     [self registerClassForTextView:[MessageTextView class]];
    
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
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.tableFooterView = footerView;
    
    [self registerCell];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    // remove bottom extra 20px space.
//    return 50.f;
//}

-(void)sendMessage:(id)sender
{
    [self.messageField resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[APIModel alloc] init] sendChatMessage:self.messageField.text withToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        self.messageField.text = @"";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self initTableData];
        
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//
//#pragma mark - Keyboard appearance/disappearance handling
//
- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    CGRect messageFrame = self.messageTextView.frame;
    messageFrame.origin.y -= keyboardSize.height;
    [self.messageTextView setFrame:messageFrame];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    CGRect messageFrame = self.messageTextView.frame;
    messageFrame.origin.y += keyboardSize.height;
    [self.messageTextView setFrame:messageFrame];
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.messageField)
    {
        [self.messageField resignFirstResponder];
    }
    
    
    return true;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.messageField resignFirstResponder];
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView scrollRectToVisible:[self.tableView convertRect:self.tableView.tableFooterView.bounds fromView:self.tableView.tableFooterView] animated:YES];
            });
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
    float width_place = SCREEN_WIDTH - ((28.f+7.f+45.f) *2) - (10*2);
    
    
    CGSize nameLabelSize = [Functions getHeightTextWithoutLabel:cell.nameLabel.font andWidthWillLabel:width_place andString:[dictionaryCell objectForKey:@"name"]];
    CGSize messageLabelSize =[Functions getHeightTextWithoutLabel:cell.messageLabel.font andWidthWillLabel:width_place andString:[dictionaryCell objectForKey:@"message"]];
    
    NSLog(@"%@",[dictionaryCell objectForKey:@"message"]);
    NSLog(@"%f",messageLabelSize.height);
    
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
        
        if([[dictionaryCell objectForKey:@"side"] isEqualToString:@"1"]) // leftSide admin answer
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
