//
//  SettingsViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LobbyBaseViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BaseButton.h"
#import "EditProfileViewController.h"
#import "LobbyBaseNavigationController.h"

@interface SettingsViewController : LobbyBaseViewController

@property(nonatomic,retain) UIImageView* avatarPlace;
@property(nonatomic,retain) UILabel* nameLabel;
@property(nonatomic,retain) UILabel* ratingLabel;

@property(nonatomic,retain) UILabel* nicknameLabel;
@property(nonatomic,retain) UILabel* countryLabel;
@property(nonatomic,retain) UILabel* addressLabel;
@property(nonatomic,retain) UILabel* zipPostalLabel;
@property(nonatomic,retain) UILabel* emailLabel;
@property(nonatomic,retain) UILabel* phoneLabel;
@property(nonatomic,retain) UILabel* balanceLabel;


@end
