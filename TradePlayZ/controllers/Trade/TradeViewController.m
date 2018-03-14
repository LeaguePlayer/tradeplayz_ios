//
//  TradeViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TradeViewController.h"
#import "TournamentViewController.h"
#import "BetButton.h"
//#import "WKWebView.h"

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.numberOfLines = 0;
    [button setTitle:[MCLocalization stringForKey:@"lobby_tournament_2"] forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button.titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:13.0f];
    [button setTitleColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self
              action:@selector(goToLobby:)
    forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
   
    
//    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"TOURNAMENT\nLOBBY" style:UIBarButtonItemStylePlain target:self action:@selector(goToLobby:)];
 
//    self.navigationItem.rightBarButtonItem = anotherButton;
    // Do any additional setup after loading the view.

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftmenu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
    //        self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem = item;
    
   
    
    [self initData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    balanceLabel.alpha = 0;
    // Stop timer:
    [tickTimer invalidate];
    tickTimer = nil;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

-(void)tickTimer:(id)sender
{
    NSLog(@"tick");
    [[[APIModel alloc] init] checkStatusTournamentByID:[NSString stringWithFormat:@"%d",_selected_id_tour] andToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"user"];
        
        balanceLabel.text  = [NSString stringWithFormat:@"$ %@", [obj objectForKey:@"balance"]];
    } onFailure:^(NSString *error) {
        
        
         [self.navigationController popToRootViewControllerAnimated:YES];
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"results"]];
        
    }];
}

-(void)initData
{
    [[[APIModel alloc] init] getActiveTournamentWithToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"tournament"];
        
        balanceLabel.text  = [NSString stringWithFormat:@"$ %@", [obj objectForKey:@"balance"]];
        name = [obj objectForKey:@"name"];
        timeBegin = [obj objectForKey:@"begin"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self buildContent];
        });
    } onFailure:^(NSString *error) {
        
    }];
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    balanceLabel.alpha = 1;
    if(tickTimer == nil)
        tickTimer = [NSTimer scheduledTimerWithTimeInterval:3.5
                                                     target:self
                                                   selector:@selector(tickTimer:)
                                                   userInfo:nil
                                                    repeats:YES];
    if(balanceLabel == nil)
    {
        balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 8, 160.f, 25.f)];
        balanceLabel.font = [UIFont fontWithName:@"Lato-Regular" size:21.0f];
        balanceLabel.textColor = [UIColor whiteColor];
        [self.navigationController.navigationBar addSubview:balanceLabel];
    }
}

- (NSURL*) getBaseURL {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSRange r = [path rangeOfString:@"/" options:NSBackwardsSearch];
    path = [path substringToIndex:r.location];
    
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    path = [path stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    path = [NSString stringWithFormat:@"file:/%@//",path];
    return  [NSURL URLWithString:path];
}

-(void)buildContent
{
    float padding_top = 32.f;
    float padding_left = 40.f;
    float spacing_horizontal = 12.5f;
    
    float top = padding_top;
    
    //row
    float width_label =  (SCREEN_WIDTH - (padding_left*2) - (spacing_horizontal*2))/2;
    float height_label =  42.f;
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_label, height_label)];
    nameLabel.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    nameLabel.layer.borderWidth= 2.0f;
    nameLabel.text = [name uppercaseString];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
     nameLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    nameLabel.textColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
    //
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:nameLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@2.f range:NSMakeRange(0, [nameLabel.text length])];
    [nameLabel setAttributedText:attributedString];
    
    //
    UILabel* timeBeginLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+width_label+spacing_horizontal, top, width_label, height_label)];
    timeBeginLabel.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    timeBeginLabel.layer.borderWidth= 2.0f;
    timeBeginLabel.text = [timeBegin uppercaseString];
    [timeBeginLabel setTextAlignment:NSTextAlignmentCenter];
    timeBeginLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    timeBeginLabel.textColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
    //
    attributedString = [[NSMutableAttributedString alloc] initWithString:timeBeginLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@2.f range:NSMakeRange(0, [timeBeginLabel.text length])];
    [timeBeginLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(timeBeginLabel.frame) + 25.f;
    
    
    //row
//    UIView* graph = [[UIView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 250.f)];
//    [graph setBackgroundColor:[UIColor blackColor]];
    
//    NSString* currentURL = [NSString stringWithFormat:@"http://chart.amobile-studio.ru/demo2/"];
//    NSString* currentURL = [NSString stringWithFormat:@"http://dev.tradeplayz.com/api/charts/getChart?token=%@",self.authUser.token];
    
//
//     NSString* currentURL = [NSString stringWithFormat:@"http://tpz.server.loc.192.168.88.23.xip.io/api/charts/getChart?token=%@",self.authUser.token];
    NSLog(@"token is %@",self.authUser.token);
//    NSString* currentURL = [NSString stringWithFormat:@"http://tpz.server.loc.192.168.88.23.xip.io/api/charts/getChart?token=8243bc3603c78fb7d93842b598aec539"];
    


//    NSString* currentURL = [NSString stringWithFormat:@"http://yandex.ru"];
//    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 350.f)];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
//    webView.dataDetectorTypes = UIDataDetectorTypeAll;
//    webView.scalesPageToFit = YES;
//    [webView setAllowsInlineMediaPlayback:YES];
//    webView.mediaPlaybackRequiresUserAction = NO;
//    NSError* error;
//    NSString* html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"] encoding:NSASCIIStringEncoding error:&error];
//
//    [webView loadHTMLString:html baseURL:[self getBaseURL]];
    
  
    
    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:currentURL]]];
    

//    NSString *urlAddress = @"http://mywebsite.com/";
//    NSURL *url = [NSURL URLWithString:urlAddress];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
   
//    [webView loadRequest:requestObj];
    
    
//    webView.opaque = NO;
//    webView.backgroundColor = [UIColor clearColor];
    
//    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
//    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 350.f) configuration:theConfiguration];
//    webView.navigationDelegate = self;
//
//    webView.scrollView.scrollEnabled = NO;
//    webView.scrollView.bounces = NO;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 350.f)];
//    webView.navigationDelegate = self;
    
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    
//    NSString* currentURL = [NSString stringWithFormat:@"http://dev.tradeplayz.com/api/charts/getChart?token=%@",self.authUser.token];
    
    
    NSURL *nsurl=[NSURL URLWithString: [NSString stringWithFormat:@"http://dev.tradeplayz.com/api/charts/getChart?token=%@&font_size=10",self.authUser.token]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
//    [self.view addSubview:webView];
    
    [self.view addSubview:webView];
    
     top += CGRectGetHeight(webView.frame) + 25.f;
    
    //row
    float betButtonSize = 45.f;
    float spacing_bet = (SCREEN_WIDTH - (betButtonSize*3))/4;
    bet25 = [BetButton buttonWithType:UIButtonTypeCustom];
    bet25.tag = 25;
    [bet25 addTarget:self
               action:@selector(setSizing:)
     forControlEvents:UIControlEventTouchUpInside];
    [bet25 setTitle:@"25" forState:UIControlStateNormal];
    bet25.frame = CGRectMake(spacing_bet, top, betButtonSize, betButtonSize);
    [bet25 setActive];
    sizing = @"25";
    
    //
    bet50 = [BetButton buttonWithType:UIButtonTypeCustom];
    bet50.tag = 50;
    [bet50 addTarget:self
               action:@selector(setSizing:)
     forControlEvents:UIControlEventTouchUpInside];
    [bet50 setTitle:@"50" forState:UIControlStateNormal];
    bet50.frame = CGRectMake(spacing_bet+betButtonSize+spacing_bet, top, betButtonSize, betButtonSize);
    [bet50 setInactive];
    
    //
    bet100 =[BetButton buttonWithType:UIButtonTypeCustom];
    bet100.tag = 100;
    [bet100 addTarget:self
                   action:@selector(setSizing:)
         forControlEvents:UIControlEventTouchUpInside];
    [bet100 setTitle:@"100" forState:UIControlStateNormal];
    bet100.frame = CGRectMake(spacing_bet+betButtonSize+spacing_bet+betButtonSize+spacing_bet, top, betButtonSize, betButtonSize);
    [bet100 setInactive];
    
    
    top += betButtonSize + 30.f;
    
    //row
    float width_button = width_label;
    float height_button = 55.f;
    BaseButton *upButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    upButton.tag = 1;
    [upButton addTarget:self
                        action:@selector(betAction:)
              forControlEvents:UIControlEventTouchUpInside];
    [upButton setTitle:@"up" forState:UIControlStateNormal];
    [upButton setBackgroundColor:[UIColor colorWithRed:0.32 green:0.75 blue:0.00 alpha:1.0]];
    
    upButton.frame = CGRectMake(padding_left , top, width_button, height_button);
    
    BaseButton *downButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    downButton.tag = 0;
    [downButton addTarget:self
                 action:@selector(betAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [downButton setTitle:@"down" forState:UIControlStateNormal];
    downButton.frame = CGRectMake(padding_left+width_label+spacing_horizontal , top, width_button, height_button);
   
    top += height_button + 30.f;
    
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    [self.scrollView addSubview:upButton];
     [self.scrollView addSubview:downButton];
    [self.scrollView addSubview:nameLabel];
     [self.scrollView addSubview:timeBeginLabel];
    [self.scrollView addSubview:webView];
     [self.scrollView addSubview:bet25];
    [self.scrollView addSubview:bet50];
    [self.scrollView addSubview:bet100];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self zoomToFit];
}

- (void)zoomToFit
{
    if ([webView respondsToSelector:@selector(scrollView)])
    {
        UIScrollView *scrollView = [webView scrollView];
        
        float zoom = webView.bounds.size.width / scrollView.contentSize.width;
        scrollView.minimumZoomScale = zoom;
        [scrollView setZoomScale:zoom animated:YES];
    }
}

-(void)setSizing:(BetButton*)sender
{
    sizing = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"%@",sizing);
    
    [bet25 setInactive];
    [bet50 setInactive];
    [bet100 setInactive];
    
    [sender setActive];
}

-(void)betAction:(id)sender
{
    BaseButton* gotButton = (BaseButton*)sender;
    NSLog(@"%ld",(long)gotButton.tag);
    [[[APIModel alloc] init] betWithSizing:sizing andTypeBet:gotButton.tag andToken:self.authUser.token onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"bet"];
        
        balanceLabel.text  = [NSString stringWithFormat:@"$ %@", [obj objectForKey:@"balance"]];
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
}

-(void)goToLobby:(id)sender
{
    balanceLabel.alpha = 0;
    NSLog(@"go to lobby");
    NSLog(@"%d",_selected_id_tour);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TournamentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"tournamentView"];
    //    vc.order = model;
    vc.selectedTourId = [NSString stringWithFormat:@"%d",_selected_id_tour];
    [self.navigationController pushViewController:vc animated:YES];
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
