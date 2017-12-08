//
//  WelcomeMenuTableViewCell.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "WelcomeMenuTableViewCell.h"

#define paddingTop 27.5f
#define elementSpacing 4.f

@implementation WelcomeMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float padding_top = paddingTop;
        float padding_left = 27.5f;
        float element_spacing = elementSpacing;
        
        float top_space = padding_top;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding_left, padding_top, 75, 75)];
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height/2;
        self.avatarImageView.clipsToBounds = YES;
        
        top_space += self.avatarImageView.frame.size.height +  element_spacing;
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+CGRectGetWidth(self.avatarImageView.frame)+15, padding_top, 180, 25)];
        [self.nameLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:21.0f]];
        [self.nameLabel setTextColor:[UIColor whiteColor]];
        
        
        
        self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+CGRectGetWidth(self.avatarImageView.frame)+15, padding_top+25+15, 180, 25)];
        [self.countryLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:16.0f]];
        [self.countryLabel setTextColor:[UIColor colorWithRed:0.43 green:0.44 blue:0.45 alpha:1.0]];
        
        
        
        self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+8, top_space, 100, 25)];
        [self.balanceLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [self.balanceLabel setTextColor:[UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:1.0]];
        self.balanceLabel.text = [MCLocalization stringForKey:@"balance"];
        
        self.ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+8+155, top_space, 100, 25)];
        [self.ratingLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
        [self.ratingLabel setTextColor:[UIColor colorWithRed:0.18 green:0.26 blue:0.36 alpha:1.0]];
        self.ratingLabel.text = [MCLocalization stringForKey:@"rating"];
        
        top_space += self.balanceLabel.frame.size.height +  element_spacing;
        
        
        self.balancePlace = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+8, top_space, 150, 25)];
        [self.balancePlace setFont:[UIFont fontWithName:@"Lato-Regular" size:21.0f]];
        [self.balancePlace setTextColor:[UIColor whiteColor]];
        
        self.ratingPlace = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+8+155, top_space, 150, 25)];
        [self.ratingPlace setFont:[UIFont fontWithName:@"Lato-Regular" size:21.0f]];
        [self.ratingPlace setTextColor:[UIColor whiteColor]];
        
        
        self.sep = [[UIView alloc] initWithFrame:CGRectMake(0, 189.f, SCREEN_WIDTH, 1)];
        [self.sep setBackgroundColor:[UIColor colorWithRed:0.13 green:0.19 blue:0.26 alpha:1.0]];
        
      
        
//        // data test
//        [self.avatarImageView setImage:[UIImage imageNamed:@"avatar"]];
//        [self setName:@"Leonid Minderov Urevich Leonid Minderov Leonid Minderov"];
//        [self.countryLabel setText:@"Russia"];
//        [self setBalance:@"8 016,00"];
//        [self.ratingPlace setText:@"1504"];
//        //bg test
//        [self.balanceLabel setBackgroundColor:[UIColor greenColor]];
//        [self.countryLabel setBackgroundColor:[UIColor greenColor]];
//        [self.nameLabel setBackgroundColor:[UIColor redColor]];
//        [self.ratingLabel setBackgroundColor:[UIColor grayColor]];
//        [self.balanceLabel setBackgroundColor:[UIColor yellowColor]];
//        [self.ratingPlace setBackgroundColor:[UIColor greenColor]];
//        [self.balancePlace setBackgroundColor:[UIColor blueColor]];
        
        
       
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.countryLabel];
        [self addSubview:self.ratingLabel];
        [self addSubview:self.balanceLabel];
        [self addSubview:self.ratingPlace];
        [self addSubview:self.balancePlace];
        [self addSubview:self.sep];
        
    }
    return self;
}

-(void)setBalance:(NSString *)newValue
{
    self.balancePlace.text = [NSString stringWithFormat:@"$ %@", newValue];
}


//-(void)setRating:(NSString *)newValue
//{
//    self.ratingPlace.text = [NSString stringWithFormat:@"Не оплачено: %@ руб", newValue];
//}


-(void)setName:(NSString *)newValue
{
    self.nameLabel.text = newValue;
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.nameLabel sizeToFit];
    
    CGSize nameLabelSize = [Functions getHeightLabelWithFont:self.nameLabel];
    
    float adding = (nameLabelSize.height + paddingTop + 15+25) - self.avatarImageView.frame.size.height + 15.f;
//    if( adding < 0 )
        adding = 0;
    
    CGRect frame = self.countryLabel.frame;
//    frame.origin.y += (nameLabelSize.height - paddingTop);
    frame.origin.y = self.nameLabel.frame.origin.y + elementSpacing + (nameLabelSize.height);
    self.countryLabel.frame = frame;

    CGRect frame2 = self.balanceLabel.frame;
//    frame2.origin.y += (nameLabelSize.height - paddingTop);
//    frame2.origin.y = frame2.origin.y + (nameLabelSize.height-25); // 25 - это начальная высота блока
    
    frame2.origin.y = self.nameLabel.frame.origin.y + paddingTop  + (nameLabelSize.height) + adding;
    self.balanceLabel.frame = frame2;

    CGRect frame3 = self.ratingLabel.frame;
//    frame3.origin.y += (nameLabelSize.height - paddingTop);
//    frame3.origin.y = frame3.origin.y + (nameLabelSize.height-25); // 25 - это начальная высота блока
     frame3.origin.y = self.nameLabel.frame.origin.y + paddingTop  + (nameLabelSize.height) + adding;
    self.ratingLabel.frame = frame3;
    
    CGRect frame4 = self.balancePlace.frame;
//    frame4.origin.y += (nameLabelSize.height - paddingTop);
//    frame4.origin.y = frame4.origin.y + (nameLabelSize.height-25); // 25 - это начальная высота блока
    frame4.origin.y = self.nameLabel.frame.origin.y + paddingTop + frame2.size.height  + (nameLabelSize.height) + adding;
    self.balancePlace.frame = frame4;
    
    CGRect frame5 = self.ratingPlace.frame;
//    frame5.origin.y = frame5.origin.y + (nameLabelSize.height-25); // 25 - это начальная высота блока
    frame5.origin.y = self.nameLabel.frame.origin.y + paddingTop + frame3.size.height  + (nameLabelSize.height) + adding;
    self.ratingPlace.frame = frame5;
    
    CGRect frame6 = self.sep.frame;
//    frame6.origin.y = frame6.origin.y + (nameLabelSize.height-25); // 25 - это начальная высота блока
    frame6.origin.y = 189.f+(nameLabelSize.height-25);
    self.sep.frame = frame6;

//    CGRect frame3 = self.sep.frame;
//    frame3.origin.y += (nameLabelSize.height - 20.f);
//    self.sep.frame = frame3;
    
}



@end
