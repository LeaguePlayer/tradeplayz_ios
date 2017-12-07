//
//  MailTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "MailTableViewCell.h"

@implementation MailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        [self.textLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [self.textLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        

     
        
    }
    return self;
}

@end
