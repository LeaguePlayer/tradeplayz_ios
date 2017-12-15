//
//  PlayersTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PlayersTableViewCell.h"

@implementation PlayersTableViewCell

const int stillPlayStatus = 0;
const int finishedStatus = 1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        //labels
        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width*18/100), 28)]; // 18% width
        [self.placeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.placeLabel setTextColor:[UIColor whiteColor]];
        [self.placeLabel setTextAlignment:NSTextAlignmentCenter];
//         [self.placeLabel setBackgroundColor:[UIColor blueColor]];
        
        
//        float padding_left = self.frame.size.width - (self.frame.size.width*20/100);
        //
        self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.placeLabel.frame), 0, (self.frame.size.width*62/100), 28)]; // 62% width
        [self.playerLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
        [self.playerLabel setTextColor:[UIColor whiteColor]];
//        [self.playerLabel setTextAlignment:NSTextAlignmentRight];
//         [self.playerLabel setBackgroundColor:[UIColor yellowColor]];
        
        //
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.placeLabel.frame)+CGRectGetWidth(self.playerLabel.frame), 0, (self.frame.size.width*22/100), 28)]; // 22% width
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

-(void)changeStatus
{
    if(self.status == stillPlayStatus)
    {
        self.statusLabel.text = [MCLocalization stringForKey:@"still_play_status"];
        [self.statusLabel setTextColor:[UIColor whiteColor]];
        [self.playerLabel setTextColor:[UIColor whiteColor]];
        [self.placeLabel setTextColor:[UIColor whiteColor]];
    }
    else if(self.status == finishedStatus)
    {
        self.statusLabel.text = [MCLocalization stringForKey:@"finished_status"];
        [self.statusLabel setTextColor:[UIColor colorWithRed:0.32 green:0.48 blue:0.66 alpha:1.0]];
        [self.playerLabel setTextColor:[UIColor colorWithRed:0.32 green:0.48 blue:0.66 alpha:1.0]];
        [self.placeLabel setTextColor:[UIColor colorWithRed:0.32 green:0.48 blue:0.66 alpha:1.0]];
        
    }
    
    if(self.showMe)
        [self setBackgroundColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0]];
    else
        [self setBackgroundColor:[UIColor clearColor]];
    
}

@end
