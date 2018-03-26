//
//  PVPChatTableViewCell.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
//#import "TriangleView.h"

@interface PVPChatTableViewCell : UITableViewCell
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
