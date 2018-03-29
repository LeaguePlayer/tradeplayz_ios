//
//  FilterModalView.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterButton.h"
#import "FilterTournamentFilter.h"
#import "BaseButton.h"
#import "ChatButton.h"
#import "KLCPopup.h"

@interface FilterModalView : UIScrollView
{
    FilterButton* FilterCost;
    FilterButton* FilterTypeTour;
    FilterButton* FilterTypeGame;
    
    // default Button sender
    FilterButton* senderButton;
}

@property (nonatomic, retain) FilterTournamentFilter* filterTournament;
@property(nonatomic,retain) CZPickerView *picker;
@property (nonatomic, retain) NSArray* theData;

// use for close
//@property(nonatomic,retain) KLCPopup* popup;

-(void)configurateView;

@end
