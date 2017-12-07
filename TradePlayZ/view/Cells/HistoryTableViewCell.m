//
//  HistoryTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "HistoryTableViewCell.h"


#define leftRightPadding 42.f

@implementation HistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float left_right_padding = leftRightPadding;
        float padding_top = 5.f;
        
        // selected color
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0];
        [self setSelectedBackgroundView:bgColorView];
        self.backgroundColor = [UIColor clearColor];
        
        // separator
        UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(left_right_padding, 50.f, SCREEN_WIDTH-(left_right_padding*2), 1)];
        [sep setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        
        
        float width_for_labels = CGRectGetWidth(sep.frame)/2;
        //labels
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_right_padding, padding_top, width_for_labels, 18)];
        [dateLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [dateLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        dateLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"dateLabel"]];
        
        UILabel* resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_right_padding+width_for_labels, padding_top, width_for_labels, 18)];
        [resultLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [resultLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        resultLabel.textAlignment = NSTextAlignmentRight;
        resultLabel.text =  [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"resultLabel"]];
        
        
        
        self.dateTimePlace = [[UILabel alloc] initWithFrame:CGRectMake(left_right_padding, CGRectGetHeight(dateLabel.frame)+padding_top, width_for_labels, 25)];
        [self.dateTimePlace setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [self.dateTimePlace setTextColor:[UIColor whiteColor]];
        
        self.resultPlace = [[UILabel alloc] initWithFrame:CGRectMake(left_right_padding+width_for_labels, CGRectGetHeight(resultLabel.frame)+padding_top, width_for_labels, 25)];
        [self.resultPlace setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [self.resultPlace setTextColor:[UIColor whiteColor]];
        self.resultPlace.textAlignment = NSTextAlignmentRight;
        
        
        //data test
//        self.dateTimePlace.text =  @"11.12.1989 12:00";
//        self.resultPlace.text =  @"12 000 TPZ";
        
//        //place test
//        [dateLabel setBackgroundColor:[UIColor redColor]];
//        [resultLabel setBackgroundColor:[UIColor greenColor]];
        
         // add subviews
         [self addSubview:sep];
         [self addSubview:dateLabel];
         [self addSubview:resultLabel];
         [self addSubview:self.dateTimePlace];
         [self addSubview:self.resultPlace];
    }
    return self;
}


-(void)setDate:(NSString *)date andTime:(NSString*)time
{
     self.dateTimePlace.text = [NSString stringWithFormat:@"%@ %@", date, time];
}

-(void)setResult:(NSString *)newValue
{
    self.resultPlace.text = [NSString stringWithFormat:@"%@ TPZ", newValue];
}

@end
