//
//  FAQTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FAQTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel* titleFAQLabel;
-(void)setFaqTitle:(NSString*)value;
@end
