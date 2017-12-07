//
//  WelcomeMenuTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface WelcomeMenuTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView* avatarImageView;
@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UILabel* countryLabel;


@property (strong, nonatomic) UILabel* balanceLabel;
@property (strong, nonatomic) UILabel* ratingLabel;

@property (strong, nonatomic) UILabel* balancePlace;
@property (strong, nonatomic) UILabel* ratingPlace;


@property (strong, nonatomic) UIView* sep;


-(void)setName:(NSString *)newValue;
-(void)setBalance:(NSString *)newValue;
//-(void)setRating:(NSString *)newValue;

@end
