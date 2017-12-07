//
//  ViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 11.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "ViewController.h"

#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "BaseButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    
    // build content
    [self buildContent];
//    UIImageView *test = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    NSString *url1=@"http://www.fnordware.com/superpng/pnggrad16rgb.png";
//    [test setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    [self.view addSubview:test];
    
    [self tryAuth];
}

-(void)tryAuth
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"token"];
    if ([token length]) {
        self.authUser.token = token;
        [[[APIModel alloc] init] checkExistToken:self.authUser.token OnSuccess:^(NSDictionary *data) {
            BOOL existToken = [[[data objectForKey:@"response"] objectForKey:@"token_exist"] boolValue];
            NSString* secondPhaseAuth = [[data objectForKey:@"response"] objectForKey:@"second_phase_auth"];
            
            if(existToken)
            {
                BOOL allow_login = YES;
                if(![secondPhaseAuth isEqualToString:@"NO"])
                {
                    allow_login = NO;
                  // auth from social network
                    if([secondPhaseAuth isEqualToString:@"facebook"])
                    {
                            //facebook auth check
                        if ([FBSDKAccessToken currentAccessToken]) {
                          //facebook is ok
                            allow_login = YES;
                            // update data
                            
                        }
                    }
                    else if([secondPhaseAuth isEqualToString:@"google+"])
                    {
                        // auth check
                        if ( [[GIDSignIn sharedInstance] hasAuthInKeychain] ) {
                            // The user has  signed in properly
                            allow_login = YES;
                        }
                        
                            // update data
                            
                        
                    }
                    else if([secondPhaseAuth isEqualToString:@"twitter"])
                    {
                        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
                         NSString *userID = store.session.userID;
                        if(userID)
                            allow_login = YES;
                        
                    }
                }
                
                if(allow_login)
                {
                        //its ok auth login
                    //but update profile data
                    [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
                        [self login];
                    } onFailure:^(NSString *error) {
                    }];
                }
            }
        } onFailure:^(NSString *error) {
        }];
    }
    else
        NSLog(@"no auto auth");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}



-(void)buildContent
{
    float top = 80.f;
    
    // row
    UIImageView* logoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big_logo"]];
    CGRect frame = logoIcon.frame;
    frame.origin.x = (SCREEN_WIDTH - frame.size.width)/2;
    frame.origin.y = top;
    logoIcon.frame = frame;
    top += frame.size.height + 60.f;
    
    logoIcon.layer.shadowColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0].CGColor;
    logoIcon.layer.shadowOffset = CGSizeMake(0,0);
    logoIcon.layer.shadowOpacity = 0.25;
    logoIcon.layer.shadowRadius = 25.0;
    logoIcon.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:logoIcon.bounds cornerRadius:100.0].CGPath;
    
    
    //row
    UILabel* welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 25)];
    [welcomeLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:16.0f]];
    [welcomeLabel setTextColor:[UIColor whiteColor]];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    welcomeLabel.text = [MCLocalization stringForKey:@"welcome"];
    
    
    NSMutableAttributedString *attributedWelcomeString;
    attributedWelcomeString = [[NSMutableAttributedString alloc] initWithString:welcomeLabel.text];
    [attributedWelcomeString addAttribute:NSKernAttributeName value:@3 range:NSMakeRange(0, [welcomeLabel.text length])];
    [welcomeLabel setAttributedText:attributedWelcomeString];
    
    top += CGRectGetHeight(welcomeLabel.frame) + 9.f;
    
    
    //row
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 36)];
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:36.0f]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    nameLabel.text = @"TRADEPLAYZ";

    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:nameLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@6 range:NSMakeRange(0, [nameLabel.text length])];
    [attributedString addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Lato-Light" size:36.0f]
                 range:NSMakeRange(5, 4)];
    [nameLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(nameLabel.frame) + 145.f;
    

    //row
    float width_button = 226.5f;
    float height_button = 55.f;
    BaseButton *openAccountButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [openAccountButton addTarget:self
                          action:@selector(openAccount:)
                forControlEvents:UIControlEventTouchUpInside];
    [openAccountButton setTitle:[MCLocalization stringForKey:@"open_account"] forState:UIControlStateNormal];
    openAccountButton.frame = CGRectMake((SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    openAccountButton.titleEdgeInsets = UIEdgeInsetsMake(-10.f, 0, 0, 0);
    
    UILabel* helpTextOnButton = [[UILabel alloc] initWithFrame:CGRectMake(0, height_button-22.f, width_button, 15.f)];
    helpTextOnButton.textAlignment = NSTextAlignmentCenter;
    helpTextOnButton.text = [MCLocalization stringForKey:@"help_text_open_account"];
    [helpTextOnButton setFont:[UIFont fontWithName:@"Lato-Regular" size:9.0f]];
    [helpTextOnButton setTextColor:[UIColor whiteColor]];
    [openAccountButton addSubview:helpTextOnButton];
    
    
    top += CGRectGetHeight(openAccountButton.frame) + 25.f;
    
    
    //row
    width_button = 90.f;
    height_button = 35.f;
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                          action:@selector(loginAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:[MCLocalization stringForKey:@"login"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    loginButton.frame = CGRectMake( (SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:loginButton.titleLabel.text];
    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [loginButton.titleLabel.text length])];
    [loginButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
    top += CGRectGetHeight(loginButton.frame) + 25.f;
    
    
    //
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    
    //
    [self.scrollView addSubview:logoIcon];
    [self.scrollView addSubview:welcomeLabel];
    [self.scrollView addSubview:nameLabel];
    [self.scrollView addSubview:openAccountButton];
    [self.scrollView addSubview:loginButton];
}

-(void)openAccount:(id)sender
{
    NSLog(@"openAccount");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RegistrationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"registrationAction"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginAction:(id)sender
{
    NSLog(@"loginAction");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginAction"];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
