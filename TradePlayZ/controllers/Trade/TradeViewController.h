//
//  TradeViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LobbyBaseViewController.h"
#import "BaseButton.h"
#import "BetButton.h"
#import <WebKit/WebKit.h>
#import "RDView.h"
#import "ExtendedLGSideMenuController.h"
#import "PVPChatTableViewController.h"

@interface TradeViewController : LobbyBaseViewController <UIWebViewDelegate, LGSideMenuDelegate>
{

    
    NSString* sizing;
    NSString* name;
    NSString* timeBegin;
    
    BetButton* bet100;
     BetButton* bet25;
     BetButton* bet50;
    
    UILabel* balanceLabel;
    
    NSTimer *tickTimer;
    
    
//    WKWebView *webView;
}
@property (nonatomic) int messageCount;
@property (nonatomic) int selected_id_tour;
@property (nonatomic, retain) UIWebView *webView;

@property (strong, nonatomic) RDView *rd;

@end
