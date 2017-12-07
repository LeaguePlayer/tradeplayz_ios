//
//  headerView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 29.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "headerView.h"

@implementation headerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
       
        
        UIView* sepTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        [sepTop setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        [self addSubview:sepTop];
        
        UIView* sepBottom = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, self.frame.size.width, 1)];
        [sepBottom setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        [self addSubview:sepBottom];
        
    }
    return self;
}

-(void)setColumns:(NSArray*)columns
{
    float spacing = 10.f;
    float padding_left = 0;
    
    for( NSDictionary* obj in columns )
    {
        padding_left+=spacing;
        float width = (float)((self.frame.size.width - (spacing*([columns count]*2))) * ([[obj objectForKey:@"width"] integerValue]) / 100);
        NSString *columnName = [obj objectForKey:@"name"];
        
        UILabel* clmn = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, 0, width, self.frame.size.height)];
        [clmn setText:columnName];
        [clmn setFont:[UIFont fontWithName:@"Lato-Regular" size:10.0f]];
        [clmn setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        
        padding_left += width + spacing;
        
        [self addSubview:clmn];
    }
}

@end
