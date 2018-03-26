//
//  RDView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "RDView.h"

@interface RDView ()
{
    UIImageView* defIcon;
}
@property (strong,nonatomic) UIBezierPath *room1;
@property (strong,nonatomic) UIColor *normalColor;
@property (strong,nonatomic) UIColor *selectedColor;
@property (strong,nonatomic) UILabel *countMessages;
@property (nonatomic) BOOL isSelected;
@end

@implementation RDView



-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.normalColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
        self.selectedColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0];
        self.isSelected = NO;
        defIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 39.5f, 39.5f)];
        [defIcon setImage:[UIImage imageNamed:@"chat_icon"]];
        defIcon.contentMode = UIViewContentModeCenter;
  
        [self addSubview:defIcon];
        
        _countMessages = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 39.5f, 39.5f)];
        _countMessages.textAlignment = NSTextAlignmentCenter;
//        [_countMessages setText:@"123"];
        _countMessages.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
        _countMessages.textColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0];
        _countMessages.alpha = 0;
        [self addSubview:_countMessages];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
//    self.room1 = [UIBezierPath bezierPathWithRect:CGRectMake(81, 10, 60, 60)];
     self.room1 = [[UIBezierPath alloc]init];
    [_room1 moveToPoint:CGPointMake(1, 1)];
    [_room1 addLineToPoint:CGPointMake(39.5f+1, 0+1)];
    [_room1 addLineToPoint:CGPointMake(39.5f+1, 39.5f+1)];
    [_room1 addLineToPoint:CGPointMake(17.5f+1, 39.5f+1)];
    [_room1 addLineToPoint:CGPointMake(8.f+1, 49+1)];
    [_room1 addLineToPoint:CGPointMake(8.f+1, 39.5f+1)];
    [_room1 addLineToPoint:CGPointMake(0+1, 39.5f+1)];
    [_room1 addLineToPoint:CGPointMake(0+1, 0+1)];
    
    UIColor *colorToUse = (self.isSelected)? self.selectedColor : self.normalColor;
    [colorToUse setFill];
//    [self.room1 fill];
    [colorToUse setStroke];
    self.room1.lineWidth = 2;
    [self.room1 stroke];
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint touchPoint = [touches.anyObject locationInView:self];
//    if ([self.room1 containsPoint:touchPoint]){
//        
//        
//            
//        
//    }
//}

-(void)setCounter:(NSString *)count
{
    if([count isEqualToString:@"0"]) // zero
    {
        self.isSelected = NO;
    }
    else
        self.isSelected = YES;
    
    [_countMessages setText:count];
//    self.isSelected = ! self.isSelected;
    if(self.isSelected)
    {
        defIcon.alpha = 0;
        _countMessages.alpha = 1;
    }
    else{
        defIcon.alpha = 1;
        _countMessages.alpha = 0;
    }
    [self setNeedsDisplay];
}

@end
