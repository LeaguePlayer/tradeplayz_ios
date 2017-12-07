//
//  BaseButton.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 01.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:19.0f];
        [self setBackgroundColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        self.frame = CGRectMake( (SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
        
        
        self.layer.shadowColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 0.35;
        self.layer.shadowRadius = 35.0;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:100.0].CGPath;

    }
    return self;
}

@end
