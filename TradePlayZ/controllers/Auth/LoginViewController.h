//
//  LoginViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 01.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "AuthBaseViewController.h"
#import "BaseTextField.h"
#import <Google/SignIn.h>


@interface LoginViewController : AuthBaseViewController <GIDSignInUIDelegate>

@property(nonatomic,retain) BaseTextField* emailField;
@property(nonatomic,retain) BaseTextField* passwordField;

@end
