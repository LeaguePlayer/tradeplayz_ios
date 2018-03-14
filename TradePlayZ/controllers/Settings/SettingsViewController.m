//
//  SettingsViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "SettingsViewController.h"
#import "LanguagesTableViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init
    self.avatarPlace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 126, 126)];
    self.nameLabel = [[UILabel alloc] init];
    self.ratingLabel = [[UILabel alloc] init];
    self.nicknameLabel = [[UILabel alloc] init];
    self.countryLabel = [[UILabel alloc] init];
    self.addressLabel = [[UILabel alloc] init];
    self.zipPostalLabel = [[UILabel alloc] init];
    self.emailLabel = [[UILabel alloc] init];
    self.phoneLabel = [[UILabel alloc] init];
    self.balanceLabel = [[UILabel alloc] init];
    
    
    //test data
    [self initData];
    
   
}

-(void)initData
{
//    [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
        [self buildContent];
//    } onFailure:^(NSString *error) {
////        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
//    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildContent
{
    float padding_top = 14.f;
    float padding_left = 35.f;
    float width_screen = self.revealViewController.rearViewRevealWidth - (padding_left*2);
    
    float top = padding_top;
    
    NSString *country = ([self.authUser.country isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : self.authUser.country;
    country = ([country isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : country;
    
    NSString *nickname = ([self.authUser.nickname isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : self.authUser.nickname;
    nickname = ([nickname isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : nickname;


    //row
    float paddingLeftTemp = (width_screen - 126)/2;
    if([self.authUser.img_avatar isKindOfClass:[NSNull class]])
        [self.avatarPlace setImage:[UIImage imageNamed:@"noavatar2"]];
    else
        [self.avatarPlace setImageWithURL:[NSURL URLWithString:self.authUser.img_avatar] placeholderImage:[UIImage imageNamed:@"noavatar2"]];
    self.avatarPlace.layer.cornerRadius = self.avatarPlace.frame.size.height/2;
    self.avatarPlace.clipsToBounds = YES;
    
    CGRect frameAvatarPlace = self.avatarPlace.frame;
    frameAvatarPlace.origin.x = padding_left+paddingLeftTemp;
    frameAvatarPlace.origin.y = padding_top;
    self.avatarPlace.frame = frameAvatarPlace;
    top += CGRectGetHeight(self.avatarPlace.frame) + 18.f;
    
    
    //row
    [self.nameLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:26.0f]];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    self.nameLabel.text = [self.authUser getFirstLastName];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.nameLabel sizeToFit];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    CGSize nameLabelLabelSize = [Functions getHeightLabelWithFont:self.nameLabel andWidth:width_screen];
    [self.nameLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.nameLabel.frame) + 25.f;
    
    //row
    UILabel* ratingPreLabel = [[UILabel alloc] init];
    [ratingPreLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [ratingPreLabel setTextAlignment:NSTextAlignmentCenter];
    [ratingPreLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    ratingPreLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"rating"]];
    [ratingPreLabel setFrame:CGRectMake(padding_left, top, width_screen, 20)];
    top += CGRectGetHeight(ratingPreLabel.frame) + 5.f ;
    
    //row
    NSString *ratingValue = [NSString stringWithFormat:@"%@",self.authUser.rating];
    [self.ratingLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:21.0f]];
    [self.ratingLabel setTextColor:[UIColor whiteColor]];
    [self.ratingLabel setText:ratingValue];
    [self.ratingLabel setTextAlignment:NSTextAlignmentCenter];
    [self.ratingLabel setFrame:CGRectMake(padding_left, top, width_screen, 24.f)];
    top += CGRectGetHeight(self.ratingLabel.frame) + 32.f;
    
    //row
    [self.nicknameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.nicknameLabel setTextColor:[UIColor whiteColor]];
    self.nicknameLabel.text =  [NSString stringWithFormat:@"%@: %@",[MCLocalization stringForKey:@"nickname"], nickname];
    [self.nicknameLabel setTextAlignment:NSTextAlignmentCenter];
    self.nicknameLabel.numberOfLines = 0;
    self.nicknameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.nicknameLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.nicknameLabel andWidth:width_screen];
    [self.nicknameLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.nicknameLabel.frame) + 6.f;
    //
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:self.nicknameLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [[MCLocalization stringForKey:@"nickname"] length]+1)];
    [self.nicknameLabel setAttributedText:commentString];
    
    //row
    [self.countryLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.countryLabel setTextColor:[UIColor whiteColor]];
    self.countryLabel.text =  [NSString stringWithFormat:@"%@: %@",[MCLocalization stringForKey:@"country"], country];
    [self.countryLabel setTextAlignment:NSTextAlignmentCenter];
    self.countryLabel.numberOfLines = 0;
    self.countryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.countryLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.countryLabel andWidth:width_screen];
    [self.countryLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.countryLabel.frame) + 6.f;
    //
    commentString = [[NSMutableAttributedString alloc] initWithString:self.countryLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [[MCLocalization stringForKey:@"country"] length]+1)];
    [self.countryLabel setAttributedText:commentString];
    
    
    //row
    [self.addressLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.addressLabel setTextColor:[UIColor whiteColor]];
    self.addressLabel.text =  [NSString stringWithFormat:@"%@: %@",[MCLocalization stringForKey:@"address"], self.authUser.address];
    [self.addressLabel setTextAlignment:NSTextAlignmentCenter];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.addressLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.addressLabel andWidth:width_screen];
    [self.addressLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.addressLabel.frame) + 6.f;
    //
    commentString = [[NSMutableAttributedString alloc] initWithString:self.addressLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [[MCLocalization stringForKey:@"address"] length]+1)];
    [self.addressLabel setAttributedText:commentString];
    
    
    //row
    [self.zipPostalLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.zipPostalLabel setTextColor:[UIColor whiteColor]];
    self.zipPostalLabel.text =  [NSString stringWithFormat:@"%@: %@",[MCLocalization stringForKey:@"zip"], self.authUser.zipcode];
    [self.zipPostalLabel setTextAlignment:NSTextAlignmentCenter];
    self.zipPostalLabel.numberOfLines = 0;
    self.zipPostalLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.zipPostalLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.zipPostalLabel andWidth:width_screen];
    [self.zipPostalLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.zipPostalLabel.frame) + 6.f;
    //
    commentString = [[NSMutableAttributedString alloc] initWithString:self.zipPostalLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [[MCLocalization stringForKey:@"zip"] length]+1)];
    [self.zipPostalLabel setAttributedText:commentString];
    
    
    //row
    NSString* wordEmail = @"E-Mail";
    [self.emailLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.emailLabel setTextColor:[UIColor whiteColor]];
    self.emailLabel.text =  [NSString stringWithFormat:@"%@: %@",wordEmail, self.authUser.email];
    [self.emailLabel setTextAlignment:NSTextAlignmentCenter];
    self.emailLabel.numberOfLines = 0;
    self.emailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.emailLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.emailLabel andWidth:width_screen];
    [self.emailLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.emailLabel.frame) + 6.f;
    //
    commentString = [[NSMutableAttributedString alloc] initWithString:self.emailLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [wordEmail length]+1)];
    [self.emailLabel setAttributedText:commentString];
    
    
    //row
    [self.phoneLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [self.phoneLabel setTextColor:[UIColor whiteColor]];
    self.phoneLabel.text =  [NSString stringWithFormat:@"%@: %@",[MCLocalization stringForKey:@"phone"], self.authUser.phone];
    [self.phoneLabel setTextAlignment:NSTextAlignmentCenter];
    self.phoneLabel.numberOfLines = 0;
    self.phoneLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.phoneLabel sizeToFit];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.phoneLabel andWidth:width_screen];
    [self.phoneLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.phoneLabel.frame) + 30.f;
    //
    commentString = [[NSMutableAttributedString alloc] initWithString:self.phoneLabel.text];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] range:NSMakeRange(0, [[MCLocalization stringForKey:@"phone"] length]+1)];
    [self.phoneLabel setAttributedText:commentString];
    
    
    //row
    UILabel* balancePreLabel = [[UILabel alloc] init];
    [balancePreLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:17.0f]];
    [balancePreLabel setTextAlignment:NSTextAlignmentCenter];
    [balancePreLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    balancePreLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"balance"]];
    [balancePreLabel setFrame:CGRectMake(padding_left, top, width_screen, 20)];
    top += CGRectGetHeight(balancePreLabel.frame) + 5.f ;
    
    //row
    [self.balanceLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:26.0f]];
    [self.balanceLabel setTextColor:[UIColor whiteColor]];
    self.balanceLabel.text = self.authUser.balance;
    self.balanceLabel.numberOfLines = 0;
    self.balanceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.balanceLabel sizeToFit];
    [self.balanceLabel setTextAlignment:NSTextAlignmentCenter];
    nameLabelLabelSize = [Functions getHeightLabelWithFont:self.balanceLabel andWidth:width_screen];
    [self.balanceLabel setFrame:CGRectMake(padding_left, top, width_screen, nameLabelLabelSize.height)];
    top += CGRectGetHeight(self.balanceLabel.frame) + 25.f;
    
    //row
    float width_button = 226.5f;
    float height_button = 55.f;
    paddingLeftTemp = (width_screen - width_button)/2;
    BaseButton *replenishButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [replenishButton addTarget:self
                          action:@selector(replenishAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [replenishButton setTitle:[MCLocalization stringForKey:@"replenish"] forState:UIControlStateNormal];
    replenishButton.frame = CGRectMake(paddingLeftTemp+padding_left , top, width_button, height_button);
    top += CGRectGetHeight(replenishButton.frame) + padding_top;
    
    
    //row
    width_button = 200.f;
    height_button = 35.f;
    paddingLeftTemp = (width_screen - width_button)/2;
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(editProfileAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:[MCLocalization stringForKey:@"edit_profile"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    [loginButton setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    [loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    loginButton.frame = CGRectMake( padding_left+paddingLeftTemp , top, width_button, height_button);
    
    commentString = [[NSMutableAttributedString alloc] initWithString:loginButton.titleLabel.text];
    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [loginButton.titleLabel.text length])];
    [loginButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
    top += CGRectGetHeight(loginButton.frame) + 15.f;
    
    //row
    width_button = 150.f;
    height_button = 35.f;
    paddingLeftTemp = (width_screen - width_button)/2;
    UIButton *changeLanguageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeLanguageButton addTarget:self
                             action:@selector(changeLangAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    [changeLanguageButton setTitle:[MCLocalization stringForKey:@"change_lang"] forState:UIControlStateNormal];
    changeLanguageButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    [changeLanguageButton setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    [changeLanguageButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    changeLanguageButton.frame = CGRectMake( padding_left+paddingLeftTemp , top, width_button, height_button);
    
    commentString = [[NSMutableAttributedString alloc] initWithString:changeLanguageButton.titleLabel.text];
    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [changeLanguageButton.titleLabel.text length])];
    [changeLanguageButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
    top += CGRectGetHeight(changeLanguageButton.frame) + 25.f;
    
    
        // resize scroll view
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    
    [self.scrollView addSubview:self.avatarPlace];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.nicknameLabel];
    [self.scrollView addSubview:self.countryLabel];
    [self.scrollView addSubview:ratingPreLabel];
    [self.scrollView addSubview:self.ratingLabel];
    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.zipPostalLabel];
     [self.scrollView addSubview:self.emailLabel];
     [self.scrollView addSubview:self.phoneLabel];
    [self.scrollView addSubview:balancePreLabel];
    [self.scrollView addSubview:self.balanceLabel];
     [self.scrollView addSubview:replenishButton];
    [self.scrollView addSubview:loginButton];
    [self.scrollView addSubview:changeLanguageButton];
}

-(void)changeLangAction:(id)sender
{
    NSLog(@"changeLangAction");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LanguagesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"changeLanguageController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)replenishAction:(id)sender
{
    NSLog(@"replenishAction");
    NSURL *url = [NSURL URLWithString:@"http://get.tradeplayz.com/"];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
    }else{
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:url];
    }
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    // переходим на другое представление
//    SWRevealViewController *revealController = self.revealViewController;
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    NSString* identifier = @"replenishController";
//    LobbyBaseNavigationController *navController = [storyboard instantiateViewControllerWithIdentifier: identifier ];
//    navController.aliasPage = @"replenish";
//    [revealController pushFrontViewController:navController animated:YES];
}

-(void)editProfileAction:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditProfileViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"editProfileController"];
    [self.navigationController pushViewController:vc animated:YES];
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
