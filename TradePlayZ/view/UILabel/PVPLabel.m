//
//  PVPLabel.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "PVPLabel.h"

@implementation PVPLabel

-(void)setRound:(NSString *)number
   withEnemyOne:(NSString *)nameOne
andWithEnemyTwo:(NSString *)nameTwo
{
    NSString* gotString = [NSString stringWithFormat:@"%@ %@: %@ vs %@", [[MCLocalization stringForKey:@"round"] uppercaseString], number, nameOne, nameTwo];
    
    if([self.text isEqualToString:gotString])
        return;
    else
        self.text = gotString;
    

    
    NSUInteger location = [self.text rangeOfString:nameOne].location;
    NSUInteger locationTwo = [self.text rangeOfString:nameTwo].location;
 
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(location, [nameOne length])];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(locationTwo, [nameTwo length])];
    
    [self setAttributedText:commentString];
    
}



@end
