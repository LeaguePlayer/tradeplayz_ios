//
//  TournamentViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LobbyBaseViewController.h"
#import "headerView.h"
#import "BaseButton.h"
#import "RTLabel.h"

@interface TournamentViewController : LobbyBaseViewController
{
    BOOL you_registred;
}

@property(nonatomic,retain) UILabel* tournamentNameLabel;
@property(nonatomic,retain) UILabel* beginTournamentLabel;
@property(nonatomic,retain) UILabel* statusTournamentLabel;
@property(nonatomic,retain) UILabel* participantsTournamentLabel;
@property(nonatomic,retain) UILabel* prizePlacesLabel;
@property(nonatomic,retain) RTLabel* rulesTournamentLabel;

@property(nonatomic,retain) UITableView* prizesGrid;
@property(nonatomic,retain) UITableView* playersGrid;

@property(nonatomic, retain) NSString* selectedTourId;




@end
