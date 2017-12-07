//
//  ImageTitleMenuTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTitleMenuTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView* iconImageView;


-(void)setImageIcon:(UIImage*)iconImage;

@end
