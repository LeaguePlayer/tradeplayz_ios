//
//  FAQModalView.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@interface FAQModalView : UIView

@property(nonatomic,retain) UILabel* titlePlace;
@property(nonatomic,retain) RTLabel* descriptionPlace;

-(void)setDescriptionText:(NSString*)value;
-(float)getHeightModal;

@end
