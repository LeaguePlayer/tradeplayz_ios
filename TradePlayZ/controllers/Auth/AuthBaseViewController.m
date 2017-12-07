//
//  AuthBaseViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "AuthBaseViewController.h"
#import "MenuTableViewController.h"
#import "LobbyBaseNavigationController.h"

@interface AuthBaseViewController ()

@end

@implementation AuthBaseViewController

-(void)login
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LobbyBaseNavigationController *frontNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"actionTrade"];
    
    
    MenuTableViewController *rearViewController = [[MenuTableViewController alloc] init];
    
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:frontNavigationController];
    revealController.delegate = self;
    revealController.rearViewRevealWidth = SCREEN_WIDTH-62.f;
    
    
    
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = revealController;
    
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
