//
//  LanguageTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 13.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "LanguageTableViewCell.h"

@implementation LanguageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.textLabel setTextColor:[UIColor whiteColor]];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
