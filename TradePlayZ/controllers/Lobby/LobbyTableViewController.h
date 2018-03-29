//
//  LobbyTableViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LobbyBaseTableViewController.h"
#import "KLCPopup.h"
#import "PVPChatTableViewController.h"
#import "ExtendedLGSideMenuController.h"
#import "ChatButton.h"
#import "FilterModalView.h"
#import "FilterTournamentFilter.h"

//

@interface LobbyTableViewController : LobbyBaseTableViewController
{
    int selected_id_tournament;
    ChatButton* filterButton;
    FilterModalView* contentView;
}
@property(nonatomic,retain) KLCPopup* popup;
@property (nonatomic, retain) FilterTournamentFilter* filterTournament;
@end
