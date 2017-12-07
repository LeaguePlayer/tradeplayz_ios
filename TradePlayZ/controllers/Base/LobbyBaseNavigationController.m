//
//  LobbyBaseNavigationController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LobbyBaseNavigationController.h"

@interface LobbyBaseNavigationController ()

@end

@implementation LobbyBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Lato-Regular" size:29.f], NSKernAttributeName: @3}];
    

    [self setNeedsStatusBarAppearanceUpdate];
    
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logotpzsmall"]];
    UIImageView* rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightIcon];
    
//    item.backgroundColor = [UIColor clearColor];
    rightIcon.layer.shadowColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0].CGColor;
    rightIcon.layer.shadowOffset = CGSizeMake(0,0);
    rightIcon.layer.shadowOpacity = 0.35;
    rightIcon.layer.shadowRadius = 9.0;
    rightIcon.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:rightIcon.bounds cornerRadius:100.0].CGPath;
    
    
//    self.navigationItem.rightBarButtonItem = item;
    
    
//    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"add_plus"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAddAddress)forControlEvents:UIControlEventTouchDown];
//    [button setFrame:CGRectMake(0, 0, 19, 19)];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [ item setLargeContentSizeImageInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    self.navigationBar.topItem.rightBarButtonItem = item;
//    self.navigationBar.topItem.rightBarButtonItem.laye
    // Do any additional setup after loading the view.
    
    
    
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0]];
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:7.f forBarMetrics:UIBarMetricsDefault];
    
//    CGRect frame = [UINavigationBar appearance].frame;
//    NSLog(@"%@",frame);
//    [[UINavigationBar appearance] setLayoutMargins:UIEdgeInsetsMake(-15.f, 10, 10,10)];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
