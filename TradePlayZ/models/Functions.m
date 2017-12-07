//
//  Functions.m
//  Eurolux
//
//  Created by Leonid Minderov on 17.08.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

+(CGSize)getHeightLabelWithFont:(UILabel*)gotLabel
{
    UIFont *cellFont = gotLabel.font;
    CGSize constraintSize = CGSizeMake( CGRectGetWidth(gotLabel.frame) , MAXFLOAT);
    
    CGSize labelSize = [ gotLabel.text sizeWithFont:cellFont
                                           constrainedToSize:constraintSize
                                               lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize;
}


+(CGSize)getHeightLabelWithFont:(UILabel*)gotLabel andWidth:(float)gotWidth
{
    UIFont *cellFont = gotLabel.font;
    CGSize constraintSize = CGSizeMake( gotWidth , MAXFLOAT);
    
    CGSize labelSize = [ gotLabel.text sizeWithFont:cellFont
                                  constrainedToSize:constraintSize
                                      lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize;
}


+(CGSize)getHeightTextWithoutLabel:(UIFont*)gotFont andWidthWillLabel:(float)widthFrame andString:(NSString*)gotText
{
    UIFont *cellFont = gotFont;
    CGSize constraintSize = CGSizeMake( widthFrame , MAXFLOAT);
    
    CGSize labelSize = [ gotText sizeWithFont:cellFont
                                  constrainedToSize:constraintSize
                                      lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize;
}

@end
