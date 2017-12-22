//
//  EditProfileViewController.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "BaseTextFieldsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BaseButton.h"

@interface EditProfileViewController : BaseTextFieldsViewController
{
    UIActionSheet *popup;
}

@property(nonatomic,retain) UIImageView* avatarPlace;
@property (nonatomic,retain)  BaseTextField* nameField;
@property (nonatomic,retain)  BaseTextField* zipCodeField;
@property (nonatomic,retain)  BaseTextField* addressField;
@property (nonatomic,retain)  BaseTextField* emailField;
@property (nonatomic,retain)  BaseTextField* phoneField;

@end
