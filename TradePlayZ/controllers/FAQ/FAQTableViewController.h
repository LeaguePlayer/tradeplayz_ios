//
//  FAQTableViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFieldTableViewController.h"
#import "KLCPopup.h"


@interface FAQTableViewController : BaseFieldTableViewController <UITextFieldDelegate>
{
    NSString* query_string;
}
@property(nonatomic,retain) KLCPopup* popup;
@property(nonatomic,retain) SmallBaseTextField* searchField;
@property(nonatomic,retain) UIActivityIndicatorView *activityView;

@end
