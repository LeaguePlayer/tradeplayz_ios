//
//  PVPChatTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "PVPChatTableViewController.h"
#import "PVPChatTableViewCell.h"

@interface PVPChatTableViewController ()
@property (strong, nonatomic) NSMutableArray* privateChattableData;
@property (strong, nonatomic) NSMutableArray* allChattableData;
@end

//cells
static NSString* chatCellIdentifier = @"chatCell";

//var
static NSString* allChatIdentifier = @"all";

@implementation PVPChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.title = [MCLocalization stringForKey:@"Live chat"];
    //    [super initWithTableViewStyle:UITableViewStylePlain];
    self.tableView.allowsSelection = NO;
    self.privateChattableData = [NSMutableArray new];
    self.allChattableData = [NSMutableArray new];
    //    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
   
    
    if(self.messageTextView==nil)
        self.messageTextView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableView.frame)-50.f+20.f, widthControllerPVPChatSide, 50)];
    
    [self.messageTextView setBackgroundColor:[UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:0.4]];
    //    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    [self.navigationController.view addSubview:self.messageTextView];
    
    
    float spacing = 10.f;
    float widthButton = 95.f;
    if(self.messageField ==nil){
        self.messageField = [[UITextField alloc] initWithFrame:CGRectMake(spacing,7.f,widthControllerPVPChatSide-( (spacing*3)+widthButton ),35)];
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthControllerPVPChatSide, 80)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    
    float height_button = 30.f;
    float top_padding = 40.f;
    float width_button = 100.f;
    float space_between_btns = (widthControllerPVPChatSide - (width_button*2+19.f))/4;
    privateChat = [ChatButton buttonWithType:UIButtonTypeCustom];
    privateChat.tag = 0;
    [privateChat addTarget:self
                    action:@selector(setChat:)
          forControlEvents:UIControlEventTouchUpInside];
    [privateChat setTitle:@"PvP Chat" forState:UIControlStateNormal];
    privateChat.frame = CGRectMake(space_between_btns, top_padding, width_button, height_button);
    [privateChat setActive];
    [headerView addSubview:privateChat];
    
    allChat = [ChatButton buttonWithType:UIButtonTypeCustom];
    allChat.tag = 1;
    [allChat addTarget:self
                action:@selector(setChat:)
      forControlEvents:UIControlEventTouchUpInside];
    [allChat setTitle:@"Lobby Chat" forState:UIControlStateNormal];
    allChat.frame = CGRectMake(space_between_btns+widthButton+space_between_btns, top_padding, width_button, height_button);
    [allChat setInactive];
    [headerView addSubview:allChat];
    
    UIButton* closeChat = [[UIButton alloc] initWithFrame:CGRectMake(space_between_btns+widthButton+space_between_btns+widthButton+space_between_btns, top_padding+((height_button-19)/2), 19, 19)];
    UIImage *btnImage = [UIImage imageNamed:@"close_chat"];
    [closeChat addTarget:self
                action:@selector(closeChat:)
      forControlEvents:UIControlEventTouchUpInside];
    [closeChat setImage:btnImage forState:UIControlStateNormal];
    [headerView addSubview:closeChat];
    
//    self.tableView.tableHeaderView = headerView;
     [self.navigationController.view addSubview:headerView];
    
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthControllerPVPChatSide, 60)];
//    [footerView setBackgroundColor:[UIColor clearColor]];
//
//    self.tableView.tableFooterView = footerView;
    
    
    
    NSURL *url = [NSURL URLWithString:@"ws://165.227.236.22:8090"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.rusSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    self.rusSocket.delegate = self;
    // socket open in TradeViewController
    
    // paddings
    self.tableView.contentInset = UIEdgeInsetsMake(headerView.frame.size.height, 0, _messageTextView.frame.size.height, 0);
    
    [self registerCell];
}

-(void)closeChat:(id)sender
{
    [self.sideMenuController hideRightViewAnimated];
}

-(void)setChat:(ChatButton *)sender
{
    if(sender.tag == 0) // pprivate chat
        private_channel_name = _socket_private;
    else
        private_channel_name = allChatIdentifier;
    
    [privateChat setInactive];
    [allChat setInactive];
    
    [sender setActive];
    
    [self.tableView reloadData];
    
    
    NSIndexPath* ipath;
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
    {
        if([self.privateChattableData count] > 0)
        {
            ipath = [NSIndexPath indexPathForRow: [self.privateChattableData count]-1 inSection: 0];
            [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: NO];
        }
    }
    else
    {
        if([self.allChattableData count] > 0)
        {
            ipath = [NSIndexPath indexPathForRow: [self.allChattableData count]-1 inSection: 0];
            [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: NO];
        }
    }
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    // remove bottom extra 20px space.
//    return 50.f;
//}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
//    NSString *helloMsg = @"{\"event\":\"pusher:subscribe\",\"data\":{\"channel\":\"chat_ru\"}}";
    [self getHistoryChat];
}

-(void)sendMessage:(id)sender
{
    if([self.messageField.text length] == 0)
        return;
    
    
    NSLog(@"_socket_private is %@",_socket_private);
    
    
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        private_channel_name = _socket_private;
    
    if([private_channel_name isEqualToString:@""])
    {
        [self showMessage:[MCLocalization stringForKey:@"disabled_pvp_chat"] withTitle:[MCLocalization stringForKey:@"alert"]];
        return;
    }
    
    NSLog(@"private_channel_name is %@",private_channel_name);
    
    //        NSString *helloMsg = @"{\"event\":\"pusher:subscribe\",\"data\":{\"channel\":\"chat_ru\"}}";
    NSString *helloMsg = [NSString stringWithFormat:@"{\"event\":\"chating\",\"data\":{\"folder\":\"%@\",\"channel\":\"%@\",\"message\":\"%@\",\"avatar\":\"%@\",\"name\":\"%@\",\"id_user\":\"%@\"}}", _socket_folder, private_channel_name, self.messageField.text, self.authUser.img_avatar, [self.authUser getFullName],self.authUser.id_user];
    
    NSLog(@"%@",helloMsg);
    [self.rusSocket send:helloMsg];
    
    
    //    [self.privateChattableData addObject:@{@"type":chatCellIdentifier,
    //                            @"side":@"2", //  1 - right side your question // 2- left side admin answer
    //                         @"name":[self.authUser getFullName],
    //                         @"message":self.messageField.text}];
    
    if( [private_channel_name isEqualToString:allChatIdentifier] )
        [self.allChattableData addObject:@{@"type":chatCellIdentifier,
                                           @"side":@"2", //  1 - right side your question // 2- left side admin answer
                                           @"name":[self.authUser getFullName],
                                           @"message":self.messageField.text}];
    else
        [self.privateChattableData addObject:@{@"type":chatCellIdentifier,
                                           @"side":@"2", //  1 - right side your question // 2- left side admin answer
                                           @"name":[self.authUser getFullName],
                                           @"message":self.messageField.text}];
    
    [self.tableView reloadData];
    
    NSIndexPath* ipath;
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
    {
        if([self.privateChattableData count] > 0)
        {
            ipath = [NSIndexPath indexPathForRow: [self.privateChattableData count]-1 inSection: 0];
            [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionNone animated: YES];
        }
    }
    else
    {
        if([self.allChattableData count] > 0)
        {
            ipath = [NSIndexPath indexPathForRow: [self.allChattableData count]-1 inSection: 0];
            [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionNone animated: YES];
        }
    }
    
    //    [self.tableView reloadData];
    

    
    
//    [self.messageField resignFirstResponder];
    self.messageField.text = @"";
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    [[[APIModel alloc] init] sendChatMessage:self.messageField.text withToken:self.authUser.token onSuccess:^(NSDictionary *data) {
    //        self.messageField.text = @"";
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        [self initprivateChatTableData];
    //
    //    } onFailure:^(NSString *error) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    //    }];
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
    [self.tableView registerClass:[PVPChatTableViewCell class] forCellReuseIdentifier:chatCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self initprivateChatTableData];
    //    [self.tableView reloadData];
}


- (void)getHistoryChat
{
    // get chat for all tour (lobby)
    NSString *helloMsg = [NSString stringWithFormat:@"{\"event\":\"get_history\",\"data\":{\"folder\":\"%@\",\"channel\":\"%@\"}}",_socket_folder, allChatIdentifier];
    [_rusSocket send:helloMsg];
    
    
    // get private chat
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        private_channel_name = _socket_private;
    
    if([private_channel_name isEqualToString:@""])
        return;
    
    NSString *getPrivateHistory = [NSString stringWithFormat:@"{\"event\":\"get_history\",\"data\":{\"folder\":\"%@\",\"channel\":\"%@\"}}",_socket_folder, private_channel_name];
    [_rusSocket send:getPrivateHistory];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        private_channel_name = _socket_private;
    
    
    message = [[message stringByReplacingOccurrencesOfString:@"///" withString:@""] stringByReplacingOccurrencesOfString:@"\\\\\\" withString:@""];
    message = [message gtm_stringByUnescapingFromHTML];
    
    
    NSError *jsonError;
    NSData *objectData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    
    
    
    NSLog(@"%@",json);
    NSString *receiveChannel = [[json objectForKey:@"data"] objectForKey:@"channel"];
    int gotIDUserMessage = [[[json objectForKey:@"data"] objectForKey:@"id_user"] intValue];
    
    NSString *floatSide = @"1"; // default not me
    if( [self.authUser.id_user intValue] == gotIDUserMessage )
        floatSide = @"2";
    
    BOOL count_plus = NO;
    if( [[[json objectForKey:@"data"] objectForKey:@"channel"] isEqualToString:allChatIdentifier] )
    {
        [self.allChattableData addObject:@{@"type":chatCellIdentifier,
                                           @"side":floatSide, //  1 - left side opponent // 2- right side you
                                           @"avatar":[[json objectForKey:@"data"] objectForKey:@"avatar"],
                                           @"name":[[json objectForKey:@"data"] objectForKey:@"name"],
                                           @"message":[[json objectForKey:@"data"] objectForKey:@"message"]}];
        count_plus = YES;
    }
    
    else if([receiveChannel isEqualToString:private_channel_name])
    {
        
       
            [self.privateChattableData addObject:@{@"type":chatCellIdentifier,
                                               @"side":floatSide, //  1 - left side opponent // 2- right side you
                                               @"avatar":[[json objectForKey:@"data"] objectForKey:@"avatar"],
                                               @"name":[[json objectForKey:@"data"] objectForKey:@"name"],
                                               @"message":[[json objectForKey:@"data"] objectForKey:@"message"]}];
        count_plus = YES;
    }
    
    
    
    
//    NSLog(@"%@",self.privateChattableData);
    [self.tableView reloadData];
    
//    NSIndexPath* ipath;
//    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
//        ipath = [NSIndexPath indexPathForRow: [self.privateChattableData count]-1 inSection: 0];
//    else
//        ipath = [NSIndexPath indexPathForRow: [self.allChattableData count]-1 inSection: 0];
//    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath* ipath;
        if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        {
            if([self.privateChattableData count] > 0)
            {
                ipath = [NSIndexPath indexPathForRow: [self.privateChattableData count]-1 inSection: 0];
                [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionNone animated: YES];
            }
        }
        else
        {
            if([self.allChattableData count] > 0)
            {
                ipath = [NSIndexPath indexPathForRow: [self.allChattableData count]-1 inSection: 0];
                [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionNone animated: YES];
            }
        }
    });
    
    
    if(count_plus && ![self.sideMenuController isRightViewVisible])
    {
        UINavigationController* nv = (UINavigationController*)self.sideMenuController.rootViewController;
        TradeViewController* mainTradeController = (TradeViewController*)[nv.viewControllers firstObject];
        mainTradeController.messageCount++;
        NSLog(@"message count is %i", mainTradeController.messageCount);
        [mainTradeController.rd setCounter:[NSString stringWithFormat:@"%i",mainTradeController.messageCount]];
    }
    
}




- (void)initprivateChatTableData
{
    //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //        NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    //        [[[APIModel alloc ] init] getChatListWithToken:self.authUser.token onSuccess:^(NSDictionary *data) {
    //            NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"chat"];
    //
    //            for(NSDictionary* chat in obj)
    //                [tmpData addObject:@{@"type":chatCellIdentifier,
    //                                     @"side":[chat objectForKey:@"type"], //  1 - right side your question // 2- right side admin answer
    //                                     @"name":[chat objectForKey:@"name"],
    //                                     @"message":[chat objectForKey:@"message"]}];
    //
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                self.privateChattableData = tmpData;
    //                // buildContent
    //                [self.tableView reloadData];
    //                [MBProgressHUD hideHUDForView:self.view animated:YES];
    //
    //                dispatch_async(dispatch_get_main_queue(), ^{
    //                    [self.tableView scrollRectToVisible:[self.tableView convertRect:self.tableView.tableFooterView.bounds fromView:self.tableView.tableFooterView] animated:YES];
    //                });
    //            });
    //
    //        } onFailure:^(NSString *error) {
    //            [MBProgressHUD hideHUDForView:self.view animated:YES];
    //            [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    //        }];
    
}
//#define widthImageView 45.f
//#define triangle 7.f
//#define left_right_padding 28.f
//#define padding_top 10.f
//#define padding_for_text 10.f
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dictionaryCell;
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        dictionaryCell = [self.privateChattableData objectAtIndex:indexPath.row];
    else
        dictionaryCell = [self.allChattableData objectAtIndex:indexPath.row];
    
    PVPChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:chatCellIdentifier];
    float width_place = widthControllerPVPChatSide - ((28.f+7.f+45.f) *2) - (10*2);
    
    
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
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        return [self.privateChattableData count];
    else
        return [self.allChattableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dictionaryCell;
    if(![private_channel_name isEqualToString:allChatIdentifier]) // pprivate chat
        dictionaryCell = [self.privateChattableData objectAtIndex:indexPath.row];
    else
        dictionaryCell = [self.allChattableData objectAtIndex:indexPath.row];
   
    
    UITableViewCell* cellDef;
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:chatCellIdentifier]) {
        PVPChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:chatCellIdentifier];
        
        
        [cell setName:[dictionaryCell objectForKey:@"name"] andMessage:[dictionaryCell objectForKey:@"message"]];
        
        if([[dictionaryCell objectForKey:@"side"] isEqualToString:@"1"]) // leftSide admin answer
        {
            //            [cell.avatarImageView setImage:[UIImage imageNamed:@"noavatar2"]];
            [cell.avatarImageView setImageWithURL:[NSURL URLWithString:[dictionaryCell objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"noavatar2"]];
            
            [cell setLeftSide];
        }
        else // right side your question
        {
            [cell.avatarImageView setImageWithURL:[NSURL URLWithString:self.authUser.img_avatar] placeholderImage:[UIImage imageNamed:@"noavatar2"]];
            [cell setRightSide];
        }
        
        cellDef = cell;
    }
    
    
    
    
    
    return cellDef;
}

@end

