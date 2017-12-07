//
//  PlayersTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel* placeLabel;
@property (strong, nonatomic) UILabel* playerLabel;
@property (strong, nonatomic) UILabel* statusLabel;

@property (nonatomic) BOOL showMe;
@property (nonatomic) NSInteger status;

-(void)changeStatus;

@end
