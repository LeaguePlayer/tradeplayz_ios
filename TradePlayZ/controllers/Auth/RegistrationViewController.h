//
//  RegistrationViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "AuthBaseViewController.h"


@interface RegistrationViewController : AuthBaseViewController
{
    BOOL agree_terms_and_conditions;
    NSString *selectedCurrency;
    
}



@property(nonatomic,retain) BaseTextField* emailField;
@property(nonatomic,retain) BaseTextField* passwordField;
@property(nonatomic,retain) UIButton* currencyField;
@property(nonatomic,retain) UIButton* policyField;

@end
