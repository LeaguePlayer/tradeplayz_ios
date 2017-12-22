//
//  HistoryModalView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 22.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "HistoryModalView.h"

#define leftPadding 62.5f
#define topPadding 25.f
#define bottomSpacing 6.f
#define bottomBigSpacing 12.f
#define horizontalSpacing 10.f

@implementation HistoryModalView

- (id)init
{
    self = [super init];
    if (self) {
        float width_content_space = SCREEN_WIDTH - (leftPadding*2);
        float top = topPadding;
        float half_content_width = (width_content_space - horizontalSpacing)/2;
        
        UIColor* redColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0];
        
        //row
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, half_content_width, 14)];
        [dateLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [dateLabel setTextColor:redColor];
        dateLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"date"]];
        //
        UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+half_content_width+horizontalSpacing, top, half_content_width, 14)];
        [timeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [timeLabel setTextColor:redColor];
        timeLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"time"]];

        top += CGRectGetHeight(dateLabel.frame) + bottomSpacing;
        
        
        //row
        self.datePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, half_content_width, 18)];
        [_datePlaceLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [_datePlaceLabel setTextColor:[UIColor whiteColor]];
        //
        self.timePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+horizontalSpacing+half_content_width, top, half_content_width, 18)];
        [_timePlaceLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [_timePlaceLabel setTextColor:[UIColor whiteColor]];
        top += CGRectGetHeight(dateLabel.frame) + bottomBigSpacing;
        //
        
        //row
        UIView* sep1 = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 1.f)];
        [sep1 setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        top += CGRectGetHeight(sep1.frame) + bottomBigSpacing;
        
        
        //row
        UILabel* byuinLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, half_content_width, 14)];
        [byuinLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [byuinLabel setTextColor:redColor];
        byuinLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"buyin"]];
        //
        UILabel* prizePoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+half_content_width+horizontalSpacing, top, half_content_width, 14)];
        [prizePoolLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [prizePoolLabel setTextColor:redColor];
        prizePoolLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"prize_pool"]];
        
        top += CGRectGetHeight(prizePoolLabel.frame) + bottomSpacing;
        
        
        //row
        self.buyinPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, half_content_width, 18)];
        [_buyinPlaceLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [_buyinPlaceLabel setTextColor:[UIColor whiteColor]];
        //
        self.prizePoolPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+horizontalSpacing+half_content_width, top, half_content_width, 18)];
        [_prizePoolPlaceLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [_prizePoolPlaceLabel setTextColor:[UIColor whiteColor]];
        top += CGRectGetHeight(_prizePoolPlaceLabel.frame) + bottomBigSpacing;
        //
        
        //row
        UIView* sep2 = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 1.f)];
        [sep2 setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        top += CGRectGetHeight(sep2.frame) + bottomBigSpacing;
        
        
        //row
        UILabel* prizeWinLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 14)];
        [prizeWinLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [prizeWinLabel setTextColor:redColor];
        prizeWinLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"resultLabel"]];
        top += CGRectGetHeight(prizeWinLabel.frame) + bottomSpacing;
        //row
        self.prizeWinPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 33)];
        [_prizeWinPlaceLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:31.0f]];
        [_prizeWinPlaceLabel setTextColor:[UIColor whiteColor]];
        
        
        
        [self addSubview:dateLabel];
        [self addSubview:timeLabel];
        [self addSubview:_datePlaceLabel];
        [self addSubview:_timePlaceLabel];
        [self addSubview:sep1];
        
        [self addSubview:byuinLabel];
        [self addSubview:prizePoolLabel];
        [self addSubview:_buyinPlaceLabel];
        [self addSubview:_prizePoolPlaceLabel];
        [self addSubview:sep2];
        
        [self addSubview:prizeWinLabel];
        [self addSubview:_prizeWinPlaceLabel];
    }
    return self;
}

@end
