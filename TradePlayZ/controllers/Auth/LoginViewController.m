//
//  LoginViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 01.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseButton.h"
#import "ViewController.h"
#import "RecoveryPasswordViewController.h"

//#import <TwitterKit/TwitterKit.h>

// Add this to the header of your file, e.g. in ViewController.m
// after #import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <GoogleOpenSource/GoogleOpenSource.h>

#import <TwitterKit/TwitterKit.h>


@interface LoginViewController () <FBSDKLoginButtonDelegate>
//@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property(retain,nonatomic) FBSDKLoginButton *loginButton;
@end


static NSString * const kClientId = @"252641785323-tisb2u7rfle1q3kf5j59qsu4chumm345.apps.googleusercontent.com";



@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
    
    // Extend the code sample provided in "7. Add Facebook Login Button Code"
    // In your viewDidLoad method:
    
    
   
    
    
    
    
    
        
//    [store logOutUserID:userID];
    
    

    
//    /* Get user info */
//    [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID]
//                                              completion:^(TWTRUser *user,
//                                                           NSError *error)
//     {
//         // handle the response or error
//         if (![error isEqual:nil]) {
//             NSLog(@"Twitter info   -> user = %@ ",user);
//             NSString *urlString = [[NSString alloc]initWithString:user.profileImageLargeURL];
//             NSURL *url = [[NSURL alloc]initWithString:urlString];
//             NSData *pullTwitterPP = [[NSData alloc]initWithContentsOfURL:url];
//
//             UIImage *profImage = [UIImage imageWithData:pullTwitterPP];
//
//
//         } else {
//             NSLog(@"Twitter error getting profile : %@", [error localizedDescription]);
//         }
//     }];
    
    
    [self buildContent];
}

-(void)forgotPasswordAction:(id)sender
{
    RecoveryPasswordViewController *recoveryPasswordControlelr = [[RecoveryPasswordViewController alloc] init];
    [self.navigationController pushViewController:recoveryPasswordControlelr animated:YES];
}

-(void)buildContent
{
    float top = 60.f;
    
    //row facebookk
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.hidden = YES;
    self.loginButton.delegate = self;
    self.loginButton.readPermissions =
    @[@"public_profile", @"email"];
    [self.scrollView addSubview:self.loginButton];
    
    
    
    
    
    //row
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 36)];
    [titleLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:31.0f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.text = [MCLocalization stringForKey:@"login"];
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@6 range:NSMakeRange(0, [titleLabel.text length])];
    [titleLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(titleLabel.frame) + 36.f;
    
    
    //row
    float width_field = 226.5f;
    float height_field = 55.f;
    self.emailField = [[BaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_field)/2, top, width_field, height_field)];
    [self.emailField setPlaceHolderText:@"E-MAIL"];
    self.emailField.delegate = self;
    self.emailField.tag = 0;
    
    top += CGRectGetHeight(self.emailField.frame) + 12.5f;
    
    
    //row
    self.passwordField = [[BaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_field)/2, top, width_field, height_field)];
    [self.passwordField setPlaceHolderText:@"PASSWORD"];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    self.passwordField.tag = 1;
    
    top += CGRectGetHeight(self.passwordField.frame) + 21.5f;
    
    
    //row
    height_field = 35.f;
    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPasswordButton addTarget:self
                             action:@selector(forgotPasswordAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    [forgotPasswordButton setTitle:[MCLocalization stringForKey:@"forgot_password"] forState:UIControlStateNormal];
    forgotPasswordButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    [forgotPasswordButton setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    [forgotPasswordButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    forgotPasswordButton.frame = CGRectMake( (SCREEN_WIDTH - width_field)/2 , top, width_field, height_field);
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:forgotPasswordButton.titleLabel.text];
    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [forgotPasswordButton.titleLabel.text length])];
    [forgotPasswordButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
    top += CGRectGetHeight(forgotPasswordButton.frame) + 21.5f;
    
    
    //row
    float width_button = 226.5f;
    float height_button = 55.f;
    BaseButton *openAccountButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [openAccountButton addTarget:self
                          action:@selector(loginAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [openAccountButton setTitle:[MCLocalization stringForKey:@"login"] forState:UIControlStateNormal];
    openAccountButton.frame = CGRectMake((SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    
    top += CGRectGetHeight(openAccountButton.frame) + 40.f;
    
    
    //row
    UILabel* helperLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH,25)];
    [helperLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [helperLabel setTextColor:[UIColor whiteColor]];
    [helperLabel setTextAlignment:NSTextAlignmentCenter];
    helperLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"social_login"]];
    
    top += CGRectGetHeight(helperLabel.frame) + 25.f;
    
    
    //row
    height_button = 42.f;
    width_button = 42.f;
    float spacing_social_buttons = ((CGRectGetWidth(openAccountButton.frame)-50.f) - (width_button * 3))/2;
    float left_padding_buttons = (SCREEN_WIDTH - (CGRectGetWidth(openAccountButton.frame)-50.f))/2;
    
    BaseButton *fbAuthButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [fbAuthButton addTarget:self
                     action:@selector(facebookLoginAction:)
           forControlEvents:UIControlEventTouchUpInside];
    fbAuthButton.frame = CGRectMake(left_padding_buttons , top, width_button, height_button);
    [fbAuthButton setBackgroundColor:[UIColor clearColor]];
    [fbAuthButton setBackgroundImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
    
    //
    left_padding_buttons += width_button + spacing_social_buttons;
    BaseButton *googlePlusAuthButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [googlePlusAuthButton addTarget:self
                             action:@selector(googlePlusLoginAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    googlePlusAuthButton.frame = CGRectMake(left_padding_buttons , top, width_button, height_button);
    [googlePlusAuthButton setBackgroundColor:[UIColor clearColor]];
    [googlePlusAuthButton setBackgroundImage:[UIImage imageNamed:@"googleplus"] forState:UIControlStateNormal];
    
    //
    left_padding_buttons += width_button + spacing_social_buttons;
    BaseButton *twitterAuthButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [twitterAuthButton addTarget:self
                          action:@selector(twitterLoginAction:)
                forControlEvents:UIControlEventTouchUpInside];
    twitterAuthButton.frame = CGRectMake(left_padding_buttons , top, width_button, height_button);
    [twitterAuthButton setBackgroundColor:[UIColor clearColor]];
    [twitterAuthButton setBackgroundImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
    
    top += CGRectGetHeight(fbAuthButton.frame) + 25.f;
    
    
    //
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    //
    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:self.emailField];
    [self.scrollView addSubview:self.passwordField];
    [self.scrollView addSubview:forgotPasswordButton];
    [self.scrollView addSubview:openAccountButton];
    [self.scrollView addSubview:helperLabel];
    [self.scrollView addSubview:fbAuthButton];
    [self.scrollView addSubview:googlePlusAuthButton];
    [self.scrollView addSubview:twitterAuthButton];
}


- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
//    [myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



-(void)loginAction:(id)sender
{
    NSLog(@"loginAction");
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString* login = self.emailField.text;
    NSString* password = self.passwordField.text;
    //
    self.authUser.login = login;
    
    
    TPZAuth* tpzAuth = [[TPZAuth alloc] init];
    tpzAuth.user = self.authUser;
    tpzAuth.password = password;
    
    [tpzAuth loginOnSuccess:^(NSDictionary *data) {
        NSLog(@"login is correct!");
        self.authUser.token = [data objectForKey:@"token"];
        [userDefaults setObject:self.authUser.token forKey:@"token"];
        [userDefaults synchronize];
        
        [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
            [self login];
        } onFailure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        }];
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)facebookLoginAction:(id)sender
{
   
    NSLog(@"facebookLoginAction");
     [self.loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    //use your custom code here
    //redirect after successful login
    NSLog(@"facebook logined!!");
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    
    
    // facebook auth
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"fb access!");
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name, email,picture.width(285).height(285)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                
                NSString *nameOfLoginUser = [result valueForKey:@"name"];
                NSString *idOfLoginUser = [result valueForKey:@"id"];
                NSString *emailOfLoginUser = [result valueForKey:@"email"];
                NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                //
                
                self.authUser.firstname = nameOfLoginUser;
                self.authUser.email = emailOfLoginUser;
                self.authUser.img_avatar = imageStringOfLoginUser;
                NSLog(@"%@",imageStringOfLoginUser);
                NSLog(@"%@",self.authUser.img_avatar);
                
                //provider
                TPZUserProvider *provider = [[TPZUserProvider alloc] init];
                provider.loginProvider = @"facebook";
                provider.loginProviderIdentifier = idOfLoginUser;
                self.authUser.provider = provider;
                
                TPZAuth* tpzAuth = [[TPZAuth alloc] init];
                tpzAuth.user = self.authUser;
                [self localNetworkAuthWithTPZAuth:tpzAuth];
            }
        }];
    }
    else
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

-(void)localNetworkAuthWithTPZAuth:(TPZAuth *)tpzAuth
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [tpzAuth loginWithSocialNetworkOnSuccess:^(NSDictionary *data) {
        NSLog(@"login is correct!");
        self.authUser.token = [data objectForKey:@"token"];
        [userDefaults setObject:self.authUser.token forKey:@"token"];
        [userDefaults synchronize];
        
        [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
            [self login];
        } onFailure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        }];
    } onFailure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    //use your custom code here
    //redirect after successful logout
}

-(void)googlePlusLoginAction:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[GIDSignIn sharedInstance] signIn];
    
    
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
    {
        NSUInteger dimension = round(128 * [[UIScreen mainScreen] scale]);
        self.authUser.img_avatar = [[user.profile imageURLWithDimension:dimension] absoluteString];
    }
    
    // google auth
    self.authUser.firstname = givenName;
    self.authUser.lastname = familyName;
    self.authUser.email = email;
    
    NSLog(@"%@",self.authUser.img_avatar);
    
    //provider
    TPZUserProvider *provider = [[TPZUserProvider alloc] init];
    provider.loginProvider = @"google+";
    provider.loginProviderIdentifier = userId;
    self.authUser.provider = provider;
    
    TPZAuth* tpzAuth = [[TPZAuth alloc] init];
    tpzAuth.user = self.authUser;
    [self localNetworkAuthWithTPZAuth:tpzAuth];
}



- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
//    return [[Twitter sharedInstance] application:app openURL:url options:options];
//}

-(void)authTwitter:(NSString *)userID
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    NSString *userID = [Twitter sharedInstance].sessionStore.session.userID;
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userID];
    [client loadUserWithID:userID completion:^(TWTRUser *user, NSError *error) {
        
        [client requestEmailForCurrentUser:^(NSString *email, NSError *error) {
            if (email) {
                self.authUser.email = email;
            } else {
                NSLog(@"error: %@", [error localizedDescription]);
            }
            
            NSLog(@"Profile image url = %@", user.profileImageLargeURL);
            NSLog(@"name %@",user.name);
            
            // twitter auth
            self.authUser.firstname = user.name;
            self.authUser.img_avatar = user.profileImageLargeURL;
            
            
            //provider
            TPZUserProvider *provider = [[TPZUserProvider alloc] init];
            provider.loginProvider = @"twitter";
            provider.loginProviderIdentifier = userID;
            self.authUser.provider = provider;
            
            TPZAuth* tpzAuth = [[TPZAuth alloc] init];
            tpzAuth.user = self.authUser;
            [self localNetworkAuthWithTPZAuth:tpzAuth];
            
            
        }];
    }];
    
    

}

-(void)twitterLoginAction:(id)sender
{
    NSLog(@"twitterLoginAction");
    
    // twitter auth
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID;
    if(userID) // user authed
        [self authTwitter:userID];
    else
    {
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (session)
                [self authTwitter:session.userID];
            else
                NSLog(@"error: %@", error.localizedDescription);
            
        }];
    }
    
    
    // Objective-C
    // Objective-C
//    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
//    [client requestEmailForCurrentUser:^(NSString *email, NSError *error) {
//        if (email) {
//            NSLog(@"signed in as %@", email);
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//        }
//
//    }];

    
    
//    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
//        if (session) {
//            NSLog(@"signed in as %@", [session userName]);
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//        }
//    }];
    
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
