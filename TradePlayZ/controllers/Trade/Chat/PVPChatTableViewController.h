//
//  PVPChatTableViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "LobbyBaseTableViewController.h"
#import "SRWebSocket.h"
#import "GTMNSString+HTML.h"
#import "UIViewController+LGSideMenuController.h"
#import "TradeViewController.h"
#import "ChatButton.h"

@interface PVPChatTableViewController : LobbyBaseTableViewController
{
    ChatButton* privateChat;
    ChatButton* allChat;
    
    NSString* private_channel_name;
}

@property (strong, nonatomic) UITextField *messageField;
@property (strong, nonatomic) UIView *messageTextView;

@property (strong, nonatomic) SRWebSocket *rusSocket;

@property (strong, nonatomic) NSString* socket_folder;
@property (strong, nonatomic) NSString* socket_private;

- (void)getHistoryChat;

@end
