//
//  TournamentModalView.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 12.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseButton.h"

@interface TournamentModalView : UIView

@property(nonatomic,retain) UILabel* prizePoolPlace;
@property(nonatomic,retain) UILabel* participantsPlace;
@property(nonatomic,retain) UILabel* timeToStartPlace;
@property(nonatomic,retain) BaseButton *registrationButton;
@property(nonatomic,retain) UIButton *loginButton;

-(void) setPrizePoolText:(NSString*)value;

@end
