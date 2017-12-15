//
//  BaseFieldTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "BaseFieldTableViewController.h"

@interface BaseFieldTableViewController ()

@end

@implementation BaseFieldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Listen for keyboard appearances and disappearances
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardDidShow:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardDidHide:)
//                                                 name:UIKeyboardDidHideNotification
//                                               object:nil];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.tableView addGestureRecognizer:tap];
    ////
}

-(void)dismissKeyboard
{
    //    [self.emailField resignFirstResponder];
}

//- (void)keyboardDidShow: (NSNotification *) notif{
//    [self.tableView setContentSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height+216.f)];
//}
//
//- (void)keyboardDidHide: (NSNotification *) notif{
//    [self.tableView setContentSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height-216.f)];
//}



-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
