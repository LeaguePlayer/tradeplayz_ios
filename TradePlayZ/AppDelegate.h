//
//  AppDelegate.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 11.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "TPZUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>
{
   double timeGoToBackground;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) TPZUser* tpzUser;
@property (nonatomic) BOOL registredToken;

@end

