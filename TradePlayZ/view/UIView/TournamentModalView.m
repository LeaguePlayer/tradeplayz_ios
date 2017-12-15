//
//  TournamentModalView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 12.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TournamentModalView.h"

#define leftPadding 62.5f
#define topPadding 25.f
#define smallSpacing 10.f
#define bigSpacing 10.f

@implementation TournamentModalView

- (id)init
{
    self = [super init];
    if (self) {
        float width_content_space = SCREEN_WIDTH - (leftPadding*2);
        float top = topPadding;
        
        //row
        UILabel* prizePoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 18)];
        [prizePoolLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [prizePoolLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        prizePoolLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"prize_pool"]];
        top += CGRectGetHeight(prizePoolLabel.frame) + bigSpacing;
        
        //row
        self.prizePoolPlace = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 25)];
        [self.prizePoolPlace setFont:[UIFont fontWithName:@"Lato-Bold" size:31.0f]];
        [self.prizePoolPlace setTextColor:[UIColor whiteColor]];
        top += CGRectGetHeight(self.prizePoolPlace.frame) + bigSpacing;
        
        
        //row
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 36.f)];
        [dateLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [dateLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        dateLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"time_to_start"]];
        [dateLabel setNumberOfLines:0];
//        [dateLabel setBackgroundColor:[UIColor greenColor]];
        [dateLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [dateLabel sizeToFit];
        
        UILabel* participantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+(width_content_space/2), top, width_content_space, 36.f)];
        [participantsLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
        [participantsLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
        
        participantsLabel.text =  [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"person_participating"]];
         [participantsLabel setNumberOfLines:0];
        [participantsLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [participantsLabel setBackgroundColor:[UIColor redColor]];
        [participantsLabel sizeToFit];
        top += CGRectGetHeight(participantsLabel.frame)-4.f;
        
        //row
        self.timeToStartPlace = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, top, width_content_space, 25.f)];
        [self.timeToStartPlace setFont:[UIFont fontWithName:@"Lato-Bold" size:17.0f]];
        [self.timeToStartPlace setTextColor:[UIColor whiteColor]];
        self.timeToStartPlace.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"time_to_start"]];
        [self.timeToStartPlace setNumberOfLines:0];
        [self.timeToStartPlace setLineBreakMode:NSLineBreakByWordWrapping];
        [self.timeToStartPlace sizeToFit];
        
        self.participantsPlace = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+(width_content_space/2), top, width_content_space, 25.f)];
        [self.participantsPlace setFont:[UIFont fontWithName:@"Lato-Bold" size:17.0f]];
        [self.participantsPlace setTextColor:[UIColor whiteColor]];
        
        self.participantsPlace.text =  [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"person_participating"]];
        [self.participantsPlace setNumberOfLines:0];
        [self.participantsPlace setLineBreakMode:NSLineBreakByWordWrapping];
        [self.participantsPlace sizeToFit];
        top += CGRectGetHeight(self.participantsPlace.frame) + smallSpacing;

        //row
        float height_button = 36.5f;
        self.registrationButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        
        [self.registrationButton setTitle:[[MCLocalization stringForKey:@"registration"] uppercaseString] forState:UIControlStateNormal];
        self.registrationButton.font = [UIFont fontWithName:@"Lato-Bold" size:13.0f];
        self.registrationButton.frame = CGRectMake(leftPadding , top, (width_content_space/2)+15.f, height_button);
        NSMutableAttributedString *attributedString;
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.registrationButton.titleLabel.text];
        [attributedString addAttribute:NSKernAttributeName value:@1.5f range:NSMakeRange(0, [self.registrationButton.titleLabel.text length])];
        [self.registrationButton.titleLabel setAttributedText:attributedString];
        
        //
        float width_button = 90.f;
        
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [self.loginButton setTitle:[MCLocalization stringForKey:@"lobby_space_tour"] forState:UIControlStateNormal];
        self.loginButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.loginButton.frame = CGRectMake( leftPadding+CGRectGetWidth(self.registrationButton.frame)+14.f , top, width_button, height_button);
        [self.loginButton.titleLabel setNumberOfLines:0];
        [self.loginButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.loginButton.titleLabel sizeToFit];
        
        NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:self.loginButton.titleLabel.text];
        [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [self.loginButton.titleLabel.text length])];
        [self.loginButton setAttributedTitle:commentString forState:UIControlStateNormal];
        
        
        
        
//        NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:registrationButton.titleLabel.text];
//        [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [registrationButton.titleLabel.text length])];
//        [registrationButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
        
        
        //add subview
        [self addSubview:prizePoolLabel];
        [self addSubview:self.prizePoolPlace];
        [self addSubview:dateLabel];
        [self addSubview:participantsLabel];
        [self addSubview:self.timeToStartPlace];
        [self addSubview:self.participantsPlace];
        [self addSubview:self.registrationButton];
         [self addSubview:self.loginButton];
    }
    return self;
}

-(void) setPrizePoolText:(NSString*)value
{
    self.prizePoolPlace.text = value;
    NSMutableAttributedString *attributedStringPrizePool;
    attributedStringPrizePool = [[NSMutableAttributedString alloc] initWithString:self.prizePoolPlace.text];
    [attributedStringPrizePool addAttribute:NSKernAttributeName value:@3 range:NSMakeRange(0, [self.prizePoolPlace.text length])];
    [self.prizePoolPlace setAttributedText:attributedStringPrizePool];
}

@end
