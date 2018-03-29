//
//  FilterButton.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterButton : UIButton
{
    UILabel* titleLabel;
    UILabel* valueLabel;
    
}

@property (nonatomic,retain) NSString* identifierFilterString;

- (void)configurateButtonWithCaption:(NSString*)caption;
-(void)setFilterValue:(NSString*) newValue;

@end
