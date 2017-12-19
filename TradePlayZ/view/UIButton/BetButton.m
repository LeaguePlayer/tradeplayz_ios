//
//  BetButton.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 18.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "BetButton.h"

@implementation BetButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:19.0f];
        
        
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        

        
//        self.layer.shadowColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0,0);
//        self.layer.shadowOpacity = 0.35;
//        self.layer.shadowRadius = 35.0;
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:100.0].CGPath;
        
    }
    return self;
}

-(void)setActive
{
    self.layer.borderColor=[UIColor whiteColor].CGColor;
    self.layer.borderWidth= 2.0f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)setInactive
{
    self.layer.borderColor=[UIColor clearColor].CGColor;
    self.layer.borderWidth= 2.0f;
    [self setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
}

@end
