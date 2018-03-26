//
//  ChatButton.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 22.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "ChatButton.h"

@implementation ChatButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        self.backgroundColor = [UIColor colorWithRed:0.07 green:0.10 blue:0.13 alpha:1.0];
        
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        
        
    }
    return self;
}

-(void)setActive
{
    self.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    self.layer.borderWidth= 2.0f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)setInactive
{
    self.layer.borderColor=[UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:1.0].CGColor;
    self.layer.borderWidth= 2.0f;
    [self setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
}

@end
