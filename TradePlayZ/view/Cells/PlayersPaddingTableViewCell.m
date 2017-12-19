//
//  PlayersPaddingTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 17.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PlayersPaddingTableViewCell.h"

@implementation PlayersPaddingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.frame = CGRectMake(40.f, 0, SCREEN_WIDTH - (40*2), self.frame.size.height);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
//        NSLog(@"%f",SCREEN_WIDTH);
        float paddingLeft = (SCREEN_WIDTH * 10.35f) / 100;
        
        //labels
        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, (self.frame.size.width*18/100), 28)]; // 18% width
        [self.placeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.placeLabel setTextColor:[UIColor whiteColor]];
        [self.placeLabel setTextAlignment:NSTextAlignmentCenter];
        //         [self.placeLabel setBackgroundColor:[UIColor blueColor]];
        
        
        //        float padding_left = self.frame.size.width - (self.frame.size.width*20/100);
        //
        self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.placeLabel.frame)+paddingLeft, 0, (self.frame.size.width*62/100), 28)]; // 62% width
        [self.playerLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.playerLabel setTextColor:[UIColor whiteColor]];
        //        [self.playerLabel setTextAlignment:NSTextAlignmentRight];
        //         [self.playerLabel setBackgroundColor:[UIColor yellowColor]];
        
        //
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.placeLabel.frame)+paddingLeft+CGRectGetWidth(self.playerLabel.frame), 0, (self.frame.size.width*22/100), 28)]; // 22% width
        [self.statusLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.statusLabel setTextColor:[UIColor whiteColor]];
        //        [self.statusLabel setBackgroundColor:[UIColor redColor]];
        [self.statusLabel setTextAlignment:NSTextAlignmentRight];
        
        
        
        
        
        [self addSubview:self.placeLabel];
        [self addSubview:self.playerLabel];
        [self addSubview:self.statusLabel];
        
    }
    return self;
}

@end
