//
//  PVPChatTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "PVPChatTableViewCell.h"

#define widthImageView 45.f
#define triangle 7.f
#define left_right_padding 28.f
#define padding_top 10.f
#define padding_for_text 10.f


@implementation PVPChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        float width_allowe = widthControllerPVPChatSide - (left_right_padding*2);
        
        // selected color
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0];
        [self setSelectedBackgroundView:bgColorView];
        self.backgroundColor = [UIColor clearColor];
        
        //
        float width_place = widthControllerPVPChatSide - ((left_right_padding+triangle+widthImageView) *2);
        placeView = [[UIView alloc] initWithFrame:CGRectMake(left_right_padding+triangle+widthImageView, padding_top, width_place, 50.f)];
        [placeView setBackgroundColor:[UIColor clearColor]];
        
        placeView.layer.borderWidth = 1.5f;
        placeView.layer.cornerRadius = 5;
        placeView.layer.masksToBounds = true;
        
        //
        self.avatarImageView = [[UIImageView alloc]  init];
        
        //
        //        float top = padding_for_text;
        width_place = widthControllerPVPChatSide - ((left_right_padding+triangle+widthImageView) *2) - (padding_for_text*2);
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_for_text, padding_for_text, width_place, 0)];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        [self.nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [self.nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
        
        //
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_for_text, padding_for_text, width_place, 0)];
        [self.messageLabel setNumberOfLines:0];
        [self.messageLabel setTextColor:[UIColor whiteColor]];
        [self.messageLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [self.messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
        
        
        [self addSubview:placeView];
        [self addSubview:_avatarImageView];
        [placeView addSubview:self.nameLabel];
        [placeView addSubview:self.messageLabel];
    }
    return self;
}

-(void)setName:(NSString *)name andMessage:(NSString*)message
{
    self.nameLabel.text = name;
    self.messageLabel.text = message;
    //    if([name length])
    //    {
    float width_place = widthControllerPVPChatSide - ((left_right_padding+triangle+widthImageView) *2) - (padding_for_text*2);
    [self.nameLabel sizeToFit];
    [self.messageLabel sizeToFit];
    CGSize nameLabelSize = [Functions getHeightLabelWithFont:self.nameLabel andWidth:width_place];
    CGSize messageLabelSize = [Functions getHeightLabelWithFont:self.messageLabel andWidth:width_place];
    
    NSLog(@"%f",placeView.frame.size.width);
    
    
    CGRect frame = self.nameLabel.frame;
    frame.size.height = nameLabelSize.height;
    frame.size.width = width_place;
    self.nameLabel.frame = frame;
    
    NSLog(@"%@",message);
    
    float originYForMessage = ([name length]) ? padding_for_text + nameLabelSize.height + padding_for_text : padding_for_text;
    CGRect frameMessage = self.messageLabel.frame;
    frameMessage.origin.y = originYForMessage;
    frameMessage.size.height = messageLabelSize.height;
    frameMessage.size.width = width_place;
    self.messageLabel.frame = frameMessage;
    
    //    NSLog(@"%@",message);
    
    
    float heightForView = ([name length]) ? padding_for_text + nameLabelSize.height + padding_for_text + messageLabelSize.height +padding_for_text : padding_for_text + messageLabelSize.height + padding_for_text;
    CGRect Viewframe = placeView.frame;
    Viewframe.size.height = heightForView;
    placeView.frame = Viewframe;
    
    //    }
    
    
    
}

-(void)setLeftSide
{
    self.avatarImageView.frame = CGRectMake(left_right_padding, padding_top, widthImageView, widthImageView);
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height/2;
    self.avatarImageView.clipsToBounds = YES;
    placeView.layer.borderColor = [UIColor whiteColor].CGColor;
}
-(void)setRightSide
{
    self.avatarImageView.frame = CGRectMake(widthControllerPVPChatSide - left_right_padding - widthImageView, padding_top, widthImageView, widthImageView);
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height/2;
    self.avatarImageView.clipsToBounds = YES;
    placeView.layer.borderColor = [UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
}

@end

