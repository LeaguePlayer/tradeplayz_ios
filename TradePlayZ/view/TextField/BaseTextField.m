//
//  BaseTextField.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 01.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardType = UIKeyboardTypeEmailAddress;
        self.returnKeyType = UIReturnKeyDone;
        self.backgroundColor = [UIColor clearColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        self.textColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
        self.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
        self.layer.borderWidth= 2.0f;
        
        
        
//        self.layer.sublayerTransform = CATransform3DMakeTranslation(18, 0, 0);
    }
    return self;
}
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 18, 18);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 18, 18);
}


-(void)setPlaceHolderText:(NSString*)placeHolder
{
    UIColor *color = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
    self.placeholder = placeHolder;
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color, NSKernAttributeName: @3}];
}

@end
