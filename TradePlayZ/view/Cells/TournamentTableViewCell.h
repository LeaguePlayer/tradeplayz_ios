//
//  TournamentTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 12.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TournamentTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel* dateTimePlace;
@property (strong, nonatomic) UILabel* pricePoolPlace;


-(void)setTime:(NSString*)time;
-(void)setPrizePoolText:(NSString *)newValue;

@end
