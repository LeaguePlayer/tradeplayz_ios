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

@interface TradeViewController : LobbyBaseViewController
{
    NSString* sizing;
    NSString* name;
    NSString* timeBegin;
    
    BetButton* bet100;
     BetButton* bet25;
     BetButton* bet50;
    
    UILabel* balanceLabel;
    
    NSTimer *tickTimer;
}
@property (nonatomic) int selected_id_tour;

@end
