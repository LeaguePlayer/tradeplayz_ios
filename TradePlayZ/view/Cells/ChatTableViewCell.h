//
//  ChatTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 16.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
//#import "TriangleView.h"

@interface ChatTableViewCell : UITableViewCell
{
    UIView *placeView;
}
@property (nonatomic,retain) UILabel* messageLabel;
@property (nonatomic,retain) UILabel* nameLabel;
@property (nonatomic,retain) UIImageView* avatarImageView;


-(void)setLeftSide;
-(void)setRightSide;
-(void)setName:(NSString *)name andMessage:(NSString*)message;

@end
