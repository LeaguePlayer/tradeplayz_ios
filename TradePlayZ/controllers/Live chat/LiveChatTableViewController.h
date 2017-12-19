//
//  LiveChatTableViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LobbyBaseTableViewController.h"

@interface LiveChatTableViewController : LobbyBaseTableViewController

@property (strong, nonatomic) UITextField *messageField;
@property (strong, nonatomic) UIView *messageTextView;

@end
