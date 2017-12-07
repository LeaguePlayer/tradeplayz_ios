//
//  HistoryTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel* dateTimePlace;
@property (strong, nonatomic) UILabel* resultPlace;


-(void)setDate:(NSString *)date andTime:(NSString*)time;
-(void)setResult:(NSString *)newValue;

@end
