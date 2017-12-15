//
//  FAQModalView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "FAQModalView.h"


#define leftRightPadding 42.f // define in FAQTableViewCEll

@implementation FAQModalView

- (id)init
{
    self = [super init];
    if (self) {
//        float width_content_space = SCREEN_WIDTH - (leftPadding*2);
//        float top = topPadding;
        
        //row
        self.descriptionPlace = [[RTLabel alloc] init];
        [self.descriptionPlace setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [self.descriptionPlace setTextColor:[UIColor whiteColor]];

        
        [self addSubview:self.descriptionPlace];
    }
    return self;
}

-(void)setDescriptionText:(NSString*)value
{
    [self addSubview:_titlePlace];
    
    self.descriptionPlace.frame = CGRectMake(_titlePlace.frame.origin.x, CGRectGetHeight(_titlePlace.frame)+20.f, SCREEN_WIDTH-(leftRightPadding*2), 55.f);
    
//    NSString * htmlString = @"<html><body> Some html string </body></html>";
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[value dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    

    
    [self.descriptionPlace setText:value];

 
    CGSize optimumSize = [self.descriptionPlace optimumSize];
    CGRect frame = self.descriptionPlace.frame;
    frame.size.height = optimumSize.height;
    self.descriptionPlace.frame = frame;
    
//    [self.descriptionPlace ]
//    self.descriptionPlace.text = value;
//    self.descriptionPlace.numberOfLines = 0;
//    self.descriptionPlace.lineBreakMode = NSLineBreakByWordWrapping;
//    [self.descriptionPlace sizeToFit];
    
}

-(float)getHeightModal{
    float padding_top_bottom = self.titlePlace.frame.origin.y;
    CGSize titleLabelSize = [Functions getHeightLabelWithFont:self.titlePlace];
//    CGSize descLabelSize = [Functions getHeightLabelWithFont:self.descriptionPlace];
    
    return padding_top_bottom + titleLabelSize.height + 20.f + self.descriptionPlace.frame.size.height + padding_top_bottom;
}

@end
