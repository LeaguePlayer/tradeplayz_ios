//
//  Functions.h
//  Eurolux
//
//  Created by Leonid Minderov on 17.08.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Functions : NSObject

+(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;

+(CGSize)getHeightLabelWithFont:(UILabel*)gotLabel;
+(CGSize)getHeightTextWithoutLabel:(UIFont*)gotFont andWidthWillLabel:(float)widthFrame andString:(NSString*)gotText;

@end
