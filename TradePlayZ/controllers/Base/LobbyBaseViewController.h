//
//  LobbyBaseViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPZUser.h"

@interface LobbyBaseViewController : UIViewController

@property(nonatomic,retain) UIScrollView* scrollView;
@property(nonatomic,retain) TPZUser* authUser;

-(void)showMessage:(NSString*)message withTitle:(NSString *)title;

@end
