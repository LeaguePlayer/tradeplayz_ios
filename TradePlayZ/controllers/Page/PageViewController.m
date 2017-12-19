//
//  PageViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 17.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "PageViewController.h"
#import "RTLabel.h"
#import "LobbyBaseNavigationController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LobbyBaseNavigationController* mainNavigation = (LobbyBaseNavigationController*)self.navigationController;
    aliasPage = mainNavigation.aliasPage;
    
    
    [self initData];
}

-(void)initData
{
    [[[APIModel alloc] init] getStaticPageWithAlias:aliasPage onSuccess:^(NSDictionary *data) {
        NSDictionary *gotJson = [[data objectForKey:@"response"] objectForKey:@"page"];
        
        titlePage = [gotJson objectForKey:@"title"];
        descriptionPage = [gotJson objectForKey:@"description"];
        
        [self buildContent];
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
}

-(void)buildContent
{
    float padding_top = 18.f;
    float padding_left = 40.f;
    
    float top = padding_top;
    
    
    self.title = titlePage;
    //labels
    //row
    float widthObject = (SCREEN_WIDTH-(padding_left*2));
//    UILabel* titleLabel = [[UILabel alloc] init];
//    [titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:21.0f]];
//    titleLabel.text = titlePage;
//    titleLabel.numberOfLines = 0;
//    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [titleLabel sizeToFit];
//    [titleLabel setTextColor:[UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0]];
//    CGSize tournamentNameLabelSize = [Functions getHeightLabelWithFont:titleLabel andWidth:widthObject];
//    [titleLabel setFrame:CGRectMake(padding_left, padding_top, widthObject, tournamentNameLabelSize.height)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    top += CGRectGetHeight(titleLabel.frame) + padding_top;
    
    //row
    RTLabel* descriptionLabel = [[RTLabel alloc] init];
    [descriptionLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0f]];
    [descriptionLabel setTextColor:[UIColor whiteColor]];
    descriptionLabel.frame = CGRectMake(padding_left, top, widthObject, 55.f);
    [descriptionLabel setText:descriptionPage];
    
    
    CGSize optimumSize = [descriptionLabel optimumSize];
    CGRect frame = descriptionLabel.frame;
    frame.size.height = optimumSize.height;
    descriptionLabel.frame = frame;
    top += optimumSize.height + padding_top;
    
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
//    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:descriptionLabel];
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
