//
//  FAQTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "FAQTableViewCell.h"


#define leftRightPadding 42.f

@implementation FAQTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float left_right_padding = leftRightPadding;
        float padding_top = 10.f;
        
        // selected color
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0];
        [self setSelectedBackgroundView:bgColorView];
        self.backgroundColor = [UIColor clearColor];
        
        // separator
        UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(left_right_padding, 0.f, SCREEN_WIDTH-(left_right_padding*2), 1)];
        [sep setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        
        
        float width_for_labels = CGRectGetWidth(sep.frame);
        //labels
        self.titleFAQLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_right_padding, padding_top, width_for_labels, 18)];
        [self.titleFAQLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [self.titleFAQLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        
        
        
        // add subviews
        [self addSubview:sep];
        [self addSubview:self.titleFAQLabel];
    }
    return self;
}

-(void)setFaqTitle:(NSString*)value
{
    self.titleFAQLabel.text = value;
    self.titleFAQLabel.numberOfLines = 0;
    self.titleFAQLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.titleFAQLabel sizeToFit];
    CGRect frame = self.titleFAQLabel.frame;
    frame.size.width = SCREEN_WIDTH-(leftRightPadding*2);
    self.titleFAQLabel.frame = frame;
//    CGSize nameLabelSize = [Functions getHeightLabelWithFont:self.titleFAQLabel];
    
    
}

@end
