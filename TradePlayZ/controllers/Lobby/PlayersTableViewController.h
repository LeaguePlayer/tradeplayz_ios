//
//  PlayersTableViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 30.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//


#import "LobbyBaseTableViewController.h"
#import "SmallBaseTextField.h"

@interface PlayersTableViewController : LobbyBaseTableViewController  <UITextFieldDelegate>
{
    NSString* query_string;
}
@property(nonatomic,retain) SmallBaseTextField* searchField;
@property(nonatomic,retain) UIActivityIndicatorView *activityView;
@property(nonatomic, retain) NSString* selectedTourID;
@property(nonatomic) BOOL beginSearch;


@end
