//
//  ImageTitleMenuTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "ImageTitleMenuTableViewCell.h"

@implementation ImageTitleMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        float padding_top = 27.5f;
        //        float padding_left = 27.5f;
        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self.textLabel setFont:[UIFont fontWithName:@"Lato-Semibold" size:21.0f]];
        [self.textLabel setTextColor:[UIColor whiteColor]];

        UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(0, 46.f, SCREEN_WIDTH, 1)];
        [sep setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0];
        [self setSelectedBackgroundView:bgColorView];
        
        
        [self addSubview:sep];
    }
    return self;
}


//-(void)setImageIcon:(UIImage*)iconImage
//{
//    UIImage* image = iconImage;
//    
//    CGSize imageSize = image.size;
//    CGPoint oldCenter = self.iconImageView.center;
//    
//    // now do some calculations to calculate the new frame size
//    CGRect rect = CGRectMake(0, 0, imageSize.width*2, imageSize.height*2);
//    self.iconImageView.frame = rect;
//    self.iconImageView.center = oldCenter;
//    [self.iconImageView setImage:image];
//}

@end
