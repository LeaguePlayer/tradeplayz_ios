//
//  TournamentViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TournamentViewController.h"
#import "PrizeTableViewCell.h"
#import "PlayersTableViewCell.h"
#import "PrizesTableViewController.h"
#import "PlayersTableViewController.h"


@interface TournamentViewController ()

@property (strong, nonatomic) NSArray* prizesTableData;
@property (strong, nonatomic) NSArray* playersTableData;

@end

//cells
static NSString* prizeCellIdentifier = @"prizeCell";
static NSString* playersCellIdentifier = @"playersCell";

@implementation TournamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [MCLocalization stringForKey:@"lobby_tournament"];
    
//    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
//    NSLog(@"%@",self.tournamentNameLabel);
    //init
    self.tournamentNameLabel = [[UILabel alloc] init];
    self.beginTournamentLabel = [[UILabel alloc] init];
    self.statusTournamentLabel = [[UILabel alloc] init];
    self.participantsTournamentLabel = [[UILabel alloc] init];
    self.prizePlacesLabel = [[UILabel alloc] init];
    self.rulesTournamentLabel = [[RTLabel alloc] init];
    self.prizesGrid = [[UITableView alloc] init];
    self.playersGrid = [[UITableView alloc] init];
    
   //set content
    [self initData];
    
    // registerCell
    [self registerCell];
    
//    // buildContent
//    [self buildContent];
}

- (void)registerCell
{
    
    [self.prizesGrid registerClass:[PrizeTableViewCell class] forCellReuseIdentifier:prizeCellIdentifier];
    [self.playersGrid registerClass:[PlayersTableViewCell class] forCellReuseIdentifier:playersCellIdentifier];
}

-(void)initData
{

   
    [[[APIModel alloc] init] getTournamentInfoWithToken:self.authUser.token andTourId:self.selectedTourId onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"tournament"];
        NSLog(@"%@",obj);
         NSLog(@"%@",[obj objectForKey:@"name"]);
        self.tournamentNameLabel.text = [obj objectForKey:@"name"];
        self.beginTournamentLabel.text = [obj objectForKey:@"date_begin"];
        self.statusTournamentLabel.text = [obj objectForKey:@"status"];
        you_registred = [[obj objectForKey:@"you_registred"] boolValue];
        self.participantsTournamentLabel.text = [NSString stringWithFormat:@"%@ (%@)",[[obj objectForKey:@"count_participants"] objectForKey:@"still_play"], [[obj objectForKey:@"count_participants"] objectForKey:@"all"]];
        self.prizePlacesLabel.text = [obj objectForKey:@"prize_places"];
        [self.rulesTournamentLabel setText:[obj objectForKey:@"rules"]];
        NSLog(@"%@",self.rulesTournamentLabel.text);
       NSLog(@"%@",[obj objectForKey:@"rules"]);
        
        NSMutableArray* tmpPrizes = [[NSMutableArray alloc] init];
        for(NSDictionary* pr in [obj objectForKey:@"prizes"])
            [tmpPrizes addObject:@{@"place":[pr objectForKey:@"row_number"],
                                   @"prize":[pr objectForKey:@"prize"]}];
        
        
        
        NSMutableArray* tmpPlayers = [[NSMutableArray alloc] init];
        for(NSDictionary* pl in [obj objectForKey:@"participants"])
        {
            bool me = [[pl objectForKey:@"me"] boolValue];
//            NSLog(@"%@",[NSNumber numberWithBool:me]);
            [tmpPlayers addObject:@{@"place":[pl objectForKey:@"row"],
                                     @"player":[pl objectForKey:@"fullname"],
                                    @"id_status":[pl objectForKey:@"id_status"],
                                     @"status":[pl objectForKey:@"status"], // 0 - still play, 1 - finished
                                     @"me":[NSNumber numberWithBool:me]}];
            
        }
        
    
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.prizesTableData = tmpPrizes;
            self.playersTableData = tmpPlayers;
            // buildContent
            [self buildContent];
        });
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
    

    
    
}


-(void)buildContent
{
    float padding_top = 18.f;
    float padding_left = 40.f;
    float spacing_horizontal = 15.f;
    
    float top = padding_top;
    
    //labels
    //row
    float widthObject = (SCREEN_WIDTH-(padding_left*2));
    [self.tournamentNameLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:21.0f]];
    self.tournamentNameLabel.numberOfLines = 0;
    self.tournamentNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.tournamentNameLabel sizeToFit];
    [self.tournamentNameLabel setTextColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0]];
    CGSize tournamentNameLabelSize = [Functions getHeightLabelWithFont:self.tournamentNameLabel andWidth:widthObject];
    [self.tournamentNameLabel setFrame:CGRectMake(padding_left, padding_top, widthObject, tournamentNameLabelSize.height)];
    self.tournamentNameLabel.textAlignment = NSTextAlignmentCenter;
    top += CGRectGetHeight(self.tournamentNameLabel.frame) + padding_top;
    
    //row
    widthObject = ((SCREEN_WIDTH-(padding_left*2))/2)-spacing_horizontal;
    UILabel* beginLabel = [[UILabel alloc] init];
    [beginLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [beginLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    beginLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"begin"]];
    [beginLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    
    
    UILabel* statusLabel = [[UILabel alloc] init];
    [statusLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [statusLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    statusLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"status"]];
    [statusLabel setFrame:CGRectMake(padding_left+widthObject+(spacing_horizontal*2), top, widthObject, 20)];
    top += CGRectGetHeight(statusLabel.frame) + 5.f ;
    
    
    //row
//    widthObject = ((SCREEN_WIDTH-(padding_left*2))/2)-spacing_horizontal;
    [self.beginTournamentLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.beginTournamentLabel setTextColor:[UIColor whiteColor]];
    [self.beginTournamentLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    
    
    [self.statusTournamentLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.statusTournamentLabel setTextColor:[UIColor whiteColor]];
    [self.statusTournamentLabel setFrame:CGRectMake(padding_left+widthObject+(spacing_horizontal*2), top, widthObject, 20)];
    top += CGRectGetHeight(self.statusTournamentLabel.frame) + padding_top ;
    
    
    //row
//    widthObject = ((SCREEN_WIDTH-(padding_left*2))/2)-spacing_horizontal;
    UILabel* participantsLabel = [[UILabel alloc] init];
    [participantsLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [participantsLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    participantsLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"participants"]];
    [participantsLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    
    
    UILabel* prizePlacesLabel = [[UILabel alloc] init];
    [prizePlacesLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [prizePlacesLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    prizePlacesLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"prize_places"]];
    [prizePlacesLabel setFrame:CGRectMake(padding_left+widthObject+(spacing_horizontal*2), top, widthObject, 20)];
    top += CGRectGetHeight(prizePlacesLabel.frame) + 5.f ;
    
    
    //row
    //    widthObject = ((SCREEN_WIDTH-(padding_left*2))/2)-spacing_horizontal;
    [self.participantsTournamentLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.participantsTournamentLabel setTextColor:[UIColor whiteColor]];
    [self.participantsTournamentLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    
    
    [self.prizePlacesLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.prizePlacesLabel setTextColor:[UIColor whiteColor]];
    [self.prizePlacesLabel setFrame:CGRectMake(padding_left+widthObject+(spacing_horizontal*2), top, widthObject, 20)];
    top += CGRectGetHeight(prizePlacesLabel.frame) + padding_top ;
    
    
    //row
    widthObject = (SCREEN_WIDTH-(padding_left*2));
    

    
    UILabel* rulesLabel = [[UILabel alloc] init];
    [rulesLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [rulesLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    rulesLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"rules"]];
    [rulesLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    rulesLabel.textAlignment = NSTextAlignmentCenter;
    top += CGRectGetHeight(rulesLabel.frame) + 5.f ;
    
    //row
//    widthObject = (SCREEN_WIDTH-(padding_left*2));
//    self.rulesTournamentLabel = [[RTLabel alloc] init];
    [self.rulesTournamentLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [self.rulesTournamentLabel setTextColor:[UIColor whiteColor]];
    self.rulesTournamentLabel.frame = CGRectMake(padding_left, top, widthObject, 55.f);
//    [self.rulesTournamentLabel setText:descriptionPage];
//    self.rulesTournamentLabel.textAlignment = NSTextAlignmentCenter;
    NSLog(@"%@",self.rulesTournamentLabel.text);
    // set height rules block
    CGSize optimumSize = [self.rulesTournamentLabel optimumSize];
    CGRect frame = self.rulesTournamentLabel.frame;
    frame.size.height = optimumSize.height;
//    frame.size.width = optimumSize.width;
    self.rulesTournamentLabel.frame = frame;
    top += optimumSize.height + padding_top;
    
    
    
//    [self.rulesTournamentLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
//    [self.rulesTournamentLabel setTextColor:[UIColor whiteColor]];
//    self.rulesTournamentLabel.numberOfLines = 0;
//    self.rulesTournamentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [self.rulesTournamentLabel sizeToFit];
//    CGSize rulesTournamentLabelSize = [Functions getHeightLabelWithFont:self.rulesTournamentLabel andWidth:widthObject];
//    [self.rulesTournamentLabel setFrame:CGRectMake(padding_left, top, widthObject, rulesTournamentLabelSize.height)];
    
//    top += CGRectGetHeight(self.rulesTournamentLabel.frame) + padding_top;
    
    
    //row
//    widthObject = (SCREEN_WIDTH-(padding_left*2));
    UILabel* gridPrizesLabel = [[UILabel alloc] init];
    [gridPrizesLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0f]];
    [gridPrizesLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    gridPrizesLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"table_prizes"]];
    [gridPrizesLabel setFrame:CGRectMake(padding_left, top, widthObject, 20)];
    gridPrizesLabel.textAlignment = NSTextAlignmentCenter;
    top += CGRectGetHeight(gridPrizesLabel.frame) + padding_top ;
    
    //row
    float tableHeight = (28 * [self.prizesTableData count])+30;
    self.prizesGrid.delegate = self;
    self.prizesGrid.dataSource = self;
    self.prizesGrid.frame = CGRectMake(padding_left, top, widthObject, tableHeight);
    self.prizesGrid.backgroundColor = [UIColor clearColor];
    self.prizesGrid.separatorColor = [UIColor clearColor];
    
    headerView *tableHeaderView = [[headerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.prizesGrid.frame), 30)];
    [tableHeaderView setColumns:@[
                                  @{@"width":@80,
                                    @"name":[MCLocalization stringForKey:@"place"]},
                                  
                                  @{@"width":@20,
                                    @"name":[MCLocalization stringForKey:@"prize_tpz"]},
                                  
                                  ]];
    self.prizesGrid.tableHeaderView = tableHeaderView;
    top += CGRectGetHeight(self.prizesGrid.frame) + padding_top ;
    
    // row
    float width_button = 80.f;
    float height_button = 35.f;
    UIButton *morePricesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [morePricesButton addTarget:self
               action:@selector(showMorePrizes:)
     forControlEvents:UIControlEventTouchUpInside];
    [morePricesButton setTitle:[MCLocalization stringForKey:@"show_more"] forState:UIControlStateNormal];
    morePricesButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    [morePricesButton setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    morePricesButton.frame = CGRectMake( (SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    morePricesButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    UIImageView* downIcon = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"down"]];
     frame = downIcon.frame;
    frame.origin.x = (width_button - CGRectGetWidth(downIcon.frame))/2;
    frame.origin.y = height_button-CGRectGetHeight(downIcon.frame);
    downIcon.frame = frame;
    [morePricesButton addSubview:downIcon];
    
    top += CGRectGetHeight(morePricesButton.frame) + padding_top + padding_top;
    
    
    //row
    widthObject = ((SCREEN_WIDTH-(padding_left*2))/2) - 20;
    UILabel* playersLabel = [[UILabel alloc] init];
    [playersLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [playersLabel setTextColor:[UIColor whiteColor]];
    playersLabel.text = [MCLocalization stringForKey:@"players_title"];
    [playersLabel setFrame:CGRectMake(padding_left, top+7.f, widthObject, 20)];
    
    //
    height_button = 34.f;
    UIButton *searchPlayers = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchPlayers addTarget:self
                         action:@selector(searchPlayers:)
               forControlEvents:UIControlEventTouchUpInside];
    [searchPlayers setTitle:[MCLocalization stringForKey:@"search"] forState:UIControlStateNormal];
    searchPlayers.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    [searchPlayers setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    searchPlayers.frame = CGRectMake( widthObject + 50 , top, SCREEN_WIDTH - CGRectGetWidth(playersLabel.frame) - playersLabel.frame.origin.x - padding_left
                                     , height_button);
    searchPlayers.layer.borderColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    searchPlayers.layer.borderWidth = 1.5f;
//    [searchPlayers.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [searchPlayers setTitleEdgeInsets:UIEdgeInsetsMake(0, -125.f, 0, 0)];

    
    UIImageView* searchIcon = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"loop"]];
    frame = searchIcon.frame;
    frame.origin.x = CGRectGetWidth(searchPlayers.frame) -  CGRectGetWidth(searchIcon.frame) - 10.f;
    frame.origin.y = (CGRectGetHeight(searchPlayers.frame) - CGRectGetHeight(searchIcon.frame))/2;
    searchIcon.frame = frame;
    [searchPlayers addSubview:searchIcon];
    
    top += CGRectGetHeight(searchPlayers.frame) + padding_top;
    
    
    //row
    widthObject = (SCREEN_WIDTH-(padding_left*2));
    tableHeight = (28 * [self.playersTableData count])+30;
    self.playersGrid.delegate = self;
    self.playersGrid.dataSource = self;
    self.playersGrid.frame = CGRectMake(padding_left, top, widthObject, tableHeight);
    self.playersGrid.backgroundColor = [UIColor clearColor];
    self.playersGrid.separatorColor = [UIColor clearColor];
   
    headerView *tablePlayersHeaderView = [[headerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.playersGrid.frame), 30)];
    [tablePlayersHeaderView setColumns:@[
                                  @{@"width":@15,
                                    @"name":[MCLocalization stringForKey:@"place"]},
                                  
                                  @{@"width":@75,
                                    @"name":[MCLocalization stringForKey:@"player_title"]},
                                  
                                  @{@"width":@10,
                                    @"name":[MCLocalization stringForKey:@"status_title"]},
                                  
                                  ]];
    self.playersGrid.tableHeaderView = tablePlayersHeaderView;
    top += CGRectGetHeight(self.playersGrid.frame) + padding_top ;
    
    
    // row
    width_button = 80.f;
    height_button = 35.f;
    UIButton *morePlayersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [morePlayersButton addTarget:self
                         action:@selector(showMorePlayers:)
               forControlEvents:UIControlEventTouchUpInside];
    [morePlayersButton setTitle:[MCLocalization stringForKey:@"show_more"] forState:UIControlStateNormal];
    morePlayersButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    [morePlayersButton setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    morePlayersButton.frame = CGRectMake( (SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    morePlayersButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    UIImageView* downIconSecond = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"down"]];
    frame = downIconSecond.frame;
    frame.origin.x = (width_button - CGRectGetWidth(downIconSecond.frame))/2;
    frame.origin.y = height_button-CGRectGetHeight(downIconSecond.frame);
    downIconSecond.frame = frame;
    [morePlayersButton addSubview:downIconSecond];
    
    top += CGRectGetHeight(morePlayersButton.frame) + padding_top + padding_top;
    
    
    //row
    width_button = 226.5f;
    height_button = 55.f;
    BaseButton *unregistredButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    
    if(you_registred)
    {
        [unregistredButton addTarget:self
                              action:@selector(unregistredAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [unregistredButton setTitle:[MCLocalization stringForKey:@"unregistration"] forState:UIControlStateNormal];
    }
    else{
        [unregistredButton addTarget:self
                              action:@selector(registredAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [unregistredButton setTitle:[MCLocalization stringForKey:@"registration"] forState:UIControlStateNormal];
    }
    
    unregistredButton.frame = CGRectMake((SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    top += CGRectGetHeight(unregistredButton.frame) + padding_top + padding_top;
    
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
//    //test place
//    [self.tournamentNameLabel setBackgroundColor:[UIColor grayColor]];
//    [self.beginTournamentLabel setBackgroundColor:[UIColor blueColor]];
//    [self.statusTournamentLabel setBackgroundColor:[UIColor greenColor]];
//
//    [beginLabel setBackgroundColor:[UIColor greenColor]];
//    [statusLabel setBackgroundColor:[UIColor yellowColor]];
//    [playersLabel setBackgroundColor:[UIColor redColor]];
    
    
    //add subviews
    [self.scrollView addSubview:self.tournamentNameLabel];
    [self.scrollView addSubview:self.beginTournamentLabel];
    [self.scrollView addSubview:self.statusTournamentLabel];
    [self.scrollView addSubview:self.participantsTournamentLabel];
    [self.scrollView addSubview:self.prizePlacesLabel];
    [self.scrollView addSubview:self.rulesTournamentLabel];
    [self.scrollView addSubview:self.prizesGrid];
    [self.scrollView addSubview:self.playersGrid];
    
    [self.scrollView addSubview:unregistredButton];
    [self.scrollView addSubview:beginLabel];
    [self.scrollView addSubview:statusLabel];
    [self.scrollView addSubview:participantsLabel];
    [self.scrollView addSubview:prizePlacesLabel];
    [self.scrollView addSubview:rulesLabel];
    [self.scrollView addSubview:gridPrizesLabel];
    [self.scrollView addSubview:morePricesButton];
    [self.scrollView addSubview:playersLabel];
    [self.scrollView addSubview:searchPlayers];
    [self.scrollView addSubview:morePlayersButton];
}

-(void)unregistredAction:(id)sender
{
    // unregister him
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[APIModel alloc] init] unregisterToTournamentWithToken:self.authUser.token andIdTour:self.selectedTourId onSuccess:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // go to trade controller
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:[MCLocalization stringForKey:@"alert"]
                                      message:[MCLocalization stringForKey:@"you_unregistred"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
             [self goToTournamentsList];
//            [self.navigationController popToRootViewControllerAnimated:YES];
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];
        
        
       
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
}


-(void)registredAction:(id)sender
{
    // unregister him
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[APIModel alloc] init] registerToTournamentWithToken:self.authUser.token andIdTour:self.selectedTourId onSuccess:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // go to trade controller
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:[MCLocalization stringForKey:@"done"]
                                      message:[MCLocalization stringForKey:@"you_registred"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            [self goToTournamentsList];
            [self.navigationController popToRootViewControllerAnimated:YES];
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];
        
        
        
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
}


-(void)goToTournamentsList
{
    [self.navigationController.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
}

-(void)showMorePrizes:(id)sender
{
    NSLog(@"showMorePrizes");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PrizesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PrizeController"];
//    vc.order = model;
    vc.selectedTourID = _selectedTourId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showMorePlayers:(id)sender
{
    NSLog(@"showMorePlayers");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PlayersTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PlayersController"];
    vc.selectedTourID = _selectedTourId;
    vc.beginSearch = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)searchPlayers:(id)sender
{
    NSLog(@"searchPlayers");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PlayersTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PlayersController"];
    vc.selectedTourID = _selectedTourId;
    vc.beginSearch = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([tableView isEqual:self.prizesGrid])
        return 1;
    
    if([tableView isEqual:self.playersGrid])
        return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isEqual:self.prizesGrid])
        return [self.prizesTableData count];
    if([tableView isEqual:self.playersGrid])
        return [self.playersTableData count];
    
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:self.prizesGrid])
        return 28.f;
    
    if([tableView isEqual:self.playersGrid])
        return 28.f;
    
    return 50.f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* dictionaryCell;
     UITableViewCell* cellDef;
    
    if([tableView isEqual:self.prizesGrid])
    {
        dictionaryCell = [self.prizesTableData objectAtIndex:indexPath.row];
        
        PrizeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:prizeCellIdentifier];
        cell.placeLabel.text = [dictionaryCell objectForKey:@"place"];
        cell.prizeLabel.text = [dictionaryCell objectForKey:@"prize"];
        
        cellDef = cell;
    }else if([tableView isEqual:self.playersGrid])
    {
        dictionaryCell = [self.playersTableData objectAtIndex:indexPath.row];
        NSLog(@"%@",dictionaryCell);
        PlayersTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:playersCellIdentifier];
        cell.placeLabel.text = [dictionaryCell objectForKey:@"place"];
        cell.playerLabel.text = [dictionaryCell objectForKey:@"player"];
        cell.showMe = [[dictionaryCell objectForKey:@"me"] boolValue];
        cell.statusLabel.text = [dictionaryCell objectForKey:@"status"];
        cell.status = [[dictionaryCell objectForKey:@"id_status"] integerValue];
        [cell changeStatus];
//        [cell.textLabel setText:@"test"];
        
        cellDef = cell;
    }

    
    
    return cellDef;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
