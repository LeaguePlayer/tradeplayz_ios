//
//  PrizeTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PrizeTableViewCell.h"

@implementation PrizeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float padding_left = 40.f;
        float table_width_real = SCREEN_WIDTH - (padding_left*2) ;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        //labels/
        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (table_width_real*8/100), self.frame.size.height)]; // 8% width
        [self.placeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.placeLabel setTextColor:[UIColor whiteColor]];
        [self.placeLabel setTextAlignment:NSTextAlignmentRight];
//         [self.placeLabel setBackgroundColor:[UIColor greenColor]];
        
        
        float width_block_prize = (table_width_real*18/100);
        float widthHorizontalLine = table_width_real - CGRectGetWidth(self.placeLabel.frame) -  width_block_prize;
        float padding_left_second = CGRectGetWidth(self.placeLabel.frame) + widthHorizontalLine;
        self.prizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left_second, 0, width_block_prize, self.frame.size.height)]; // 18% width
        [self.prizeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.prizeLabel setTextColor:[UIColor whiteColor]];
//        [self.prizeLabel setBackgroundColor:[UIColor blueColor]];
//
//
//
//

        UIView* horizontalLineDashed = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.placeLabel.frame), 27, widthHorizontalLine, 1)];
        CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
        yourViewBorder.strokeColor = [UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:1.0].CGColor;
        yourViewBorder.fillColor = nil;
        yourViewBorder.lineDashPattern = @[@1.5,@5];
        yourViewBorder.frame = CGRectMake(0, 0, CGRectGetWidth(horizontalLineDashed.frame), 1);
        yourViewBorder.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(horizontalLineDashed.frame), 0)].CGPath;

        [horizontalLineDashed.layer addSublayer:yourViewBorder];
//        [horizontalLineDashed setBackgroundColor:[UIColor yellowColor]];
        
        [self addSubview:self.placeLabel];
         [self addSubview:self.prizeLabel];
        [self addSubview:horizontalLineDashed];
        
    }
    return self;
}

@end
