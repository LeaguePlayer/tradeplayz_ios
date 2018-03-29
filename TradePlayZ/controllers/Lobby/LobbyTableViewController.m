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
#import "TradeViewController.h"
#import "TournamentModalView.h"
#import "AppDelegate.h"
#import "LobbyBaseNavigationController.h"

@interface LobbyTableViewController () 
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* tournamentCellIdentifier = @"tournamentCell";

@implementation LobbyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDelegate.registredToken)
    {
        // Регистируем девайс на приём push-уведомлений
        if ([ [UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [ [UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            
            [ [UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            // iOS < 8 Notifications
            [ [UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        }
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0; // unset badge number
        appDelegate.registredToken = YES;
        
    }
    
    self.tableData = [[NSArray alloc] init];
   
    contentView = [[FilterModalView alloc] init];
    _filterTournament = [FilterTournamentFilter new];
    [_filterTournament loadFilter];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    float height_button = 36.5f;
    float top_padding = (CGRectGetHeight(headerView.frame) - height_button)/2;
    float width_button = 147.5f;
    float padding_left = (SCREEN_WIDTH - width_button)/2;
    filterButton = [ChatButton buttonWithType:UIButtonTypeCustom];
    filterButton.tag = 0;
    [filterButton addTarget:self
                    action:@selector(setFilter:)
          forControlEvents:UIControlEventTouchUpInside];
    [filterButton setTitle:[MCLocalization stringForKey:@"filter"] forState:UIControlStateNormal];
    filterButton.frame = CGRectMake(padding_left, top_padding, width_button, height_button);
    
    if( [_filterTournament filterIsActive] )
        [filterButton setRedActive];
    else
        [filterButton setInactive];
    
    [headerView addSubview:filterButton];
    
    self.tableView.tableHeaderView = headerView;
    
    [self registerCell];
    
    
    self.title = [MCLocalization stringForKey:@"tournaments"];
}

-(void)setFilter:(id)sender
{
    [_filterTournament loadFilter];
    
    
    
//    contentView.titlePlace = cell.titleFAQLabel;
//    [contentView setDescriptionText:[dictionaryCell objectForKey:@"description"]];
    
    contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 300);
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH, 400);
    
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_modal"]];
    contentView.filterTournament = _filterTournament;
    
     [contentView configurateView];
    
    
    self.popup = [KLCPopup popupWithContentView:contentView];
    [_popup setDidFinishDismissingCompletion:^{
        [_filterTournament loadFilter];
        if( [_filterTournament filterIsActive] )
            [filterButton setRedActive];
        else
            [filterButton setInactive];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self initTableData];
    }];

    [_popup show];

}




- (void)registerCell
{
    [self.tableView registerClass:[TournamentTableViewCell class] forCellReuseIdentifier:tournamentCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [super viewDidAppear:animated];
    [self initTableData];
    
}

- (void)initTableData
{
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    
    [[[APIModel alloc] init] getTournamentsWithToken:self.authUser.token andFilter:[_filterTournament getFilterIDValues] onSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if( [[[data objectForKey:@"response"] objectForKey:@"redirect"] boolValue] )
        {
            selected_id_tournament = [[[data objectForKey:@"response"] objectForKey:@"id_tour"] intValue];
            [self goToTradeController];
            return;
        }
        for(NSDictionary* obj in [[data objectForKey:@"response"] objectForKey:@"tournaments"])
        {
            [tmpData addObject:@{@"type":tournamentCellIdentifier,
                                 @"id":[obj objectForKey:@"id"],
                                 @"date_begin":[obj objectForKey:@"date_begin"],
                                 @"prize_pool":[obj objectForKey:@"prize_pool"],
                                 @"byuin":[obj objectForKey:@"byuin"],
                                 @"registred_participants":[obj objectForKey:@"registred_players"]}];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableData = [[NSArray alloc] init];
            self.tableData = tmpData;
            NSLog(@"%@",self.tableData);
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:tournamentCellIdentifier]) {
        TournamentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tournamentCellIdentifier];
        
        
        [cell setPrizePoolText:[dictionaryCell objectForKey:@"prize_pool"]];

        [cell setTime:[dictionaryCell objectForKey:@"date_begin"]];
        
        cellDef = cell;
    }
    
    
    
    
    
    return cellDef;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}


-(void)registrationAction:(id)sender{
    NSLog(@"gehlregistrationAction");
    [_popup dismiss:YES];
    UIButton *button = (UIButton *)sender;
   
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex: button.tag];
    NSString *message = [NSString stringWithFormat:@"%@ %@ ZED, %@?", [MCLocalization stringForKey:@"money_will_charged"], [dictionaryCell objectForKey:@"byuin"], [MCLocalization stringForKey:@"continue"]];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:[MCLocalization stringForKey:@"alert"]
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        // register him
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[[APIModel alloc] init] registerToTournamentWithToken:self.authUser.token andIdTour:[dictionaryCell objectForKey:@"id"] onSuccess:^(NSDictionary *data) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self showMessage:[MCLocalization stringForKey:@"you_registred"] withTitle:[MCLocalization stringForKey:@"done"]];
            // go to trade controller
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:[MCLocalization stringForKey:@"done"]
                                          message:[MCLocalization stringForKey:@"you_registred"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                 [self goToTradeController];
                //do something when click button
            }];
            [alert addAction:okAction];
            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            [vc presentViewController:alert animated:YES completion:nil];
            
            
//              dispatch_async(dispatch_get_main_queue(), ^{
            
//              });
        } onFailure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        }];
        
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"cancel"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    [alert addAction:noAction];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];

}

-(void)goToTradeController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TradeViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"tradeController"];

    vc.selected_id_tour = selected_id_tournament;
    
    
    
//    UIViewController *rootViewController = [UIViewController new];
//    UITableViewController *leftViewController = [UITableViewController new];
    PVPChatTableViewController *rightViewController = [PVPChatTableViewController new];
    
    
    LobbyBaseNavigationController *navigationController = [[LobbyBaseNavigationController alloc] initWithRootViewController:vc];
    
    LobbyBaseNavigationController *navigationControllerForChat = [[LobbyBaseNavigationController alloc] initWithRootViewController:rightViewController];
    
    ExtendedLGSideMenuController *sideMenuController = [ExtendedLGSideMenuController sideMenuControllerWithRootViewController:navigationController
                                                                                           leftViewController:nil
                                                                                          rightViewController:navigationControllerForChat];
    

    
    sideMenuController.rightViewWidth = widthControllerPVPChatSide; //
//    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:sideMenuController animated:YES];
//    [self.navigationController presentViewController:sideMenuController animated:YES completion:nil];
}

-(void)goToLobbyTourAction:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TournamentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"tournamentView"];
    //    vc.order = model;
    [_popup dismiss:YES];
    vc.selectedTourId = [NSString stringWithFormat:@"%d",selected_id_tournament];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    TournamentModalView* contentView = [[TournamentModalView alloc] init];
    contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 230.f);
    contentView.timeToStartPlace.text = [dictionaryCell objectForKey:@"date_begin"];
    contentView.participantsPlace.text = [dictionaryCell objectForKey:@"registred_participants"];
    
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_modal"]];
    [contentView setPrizePoolText:[dictionaryCell objectForKey:@"prize_pool"]];
    [contentView.registrationButton addTarget:self
                                action:@selector(registrationAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    contentView.registrationButton.tag = indexPath.row;
    
    [contentView.loginButton addTarget:self
                         action:@selector(goToLobbyTourAction:)
               forControlEvents:UIControlEventTouchUpInside];
//    contentView.deletate = self;
    
    selected_id_tournament = [[dictionaryCell objectForKey:@"id"] intValue];
    
    self.popup = [KLCPopup popupWithContentView:contentView];
    [_popup show];
    
    
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
