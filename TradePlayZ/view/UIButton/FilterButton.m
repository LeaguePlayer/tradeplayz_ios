//
//  FilterButton.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "FilterButton.h"

@implementation FilterButton

- (void)configurateButtonWithCaption:(NSString*)caption
{
    float padding_left = 20.f;
    float padding_top = 15.f;
    float spacing_vertical = 7.f;
    
    float width_icon = 16.f; // in dropDownIcon

    
    float width_label = self.frame.size.width - ( (padding_left*3) + width_icon );
    
    float top = padding_top;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_label, 14.f)];
    [titleLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
    [titleLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    titleLabel.text = [NSString stringWithFormat:@"%@:",caption];
    top +=  CGRectGetHeight(titleLabel.frame) + spacing_vertical;
    
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_label, 17.f)];
    [valueLabel setFont:[UIFont fontWithName:@"Lato-Semibold" size:17.0f]];
    [valueLabel setTextColor:[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0]];
    valueLabel.text = [MCLocalization stringForKey:@"no_chosen_filter"];
    
    UIImageView *dropDownIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdownfilter"]];
    CGRect ivFrame = dropDownIcon.frame;
    ivFrame.origin.x = padding_left + CGRectGetWidth(titleLabel.frame);
    ivFrame.origin.y = (self.frame.size.height - ivFrame.size.height)/2;
    dropDownIcon.frame = ivFrame;
    
    UILabel* separateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1.f, self.frame.size.width, 1.f)];
    [separateLine setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.25 alpha:1.0]];
    
    [self addSubview:titleLabel];
    [self addSubview:valueLabel];
    [self addSubview:dropDownIcon];
    [self addSubview:separateLine];
}

-(void)setFilterValue:(NSString*) newValue
{
    UIColor* defaultColor = [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0];
    if(![newValue isEqualToString:[MCLocalization stringForKey:@"no_chosen_filter"]])
        defaultColor = [UIColor whiteColor];
    
    [valueLabel setTextColor:defaultColor];
    [valueLabel setText:newValue];
}

@end
