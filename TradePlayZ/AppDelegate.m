//
//  AppDelegate.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 11.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TwitterKit.h>
#import <GooglePlus/GooglePlus.h>
#import "ExtendedLGSideMenuController.h"
#import "TradeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}





- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    
    NSLog(@"%@",url);
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
     return [[Twitter sharedInstance] application:application openURL:url options:options];
    
    
    
//    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                                  openURL:url
//                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
//                    ];
//    // Add any custom logic here.
//    return handled;


}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _tpzUser = [[TPZUser alloc] init];
    _registredToken = NO;
    
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    
    
    
     [[Twitter sharedInstance] startWithConsumerKey:@"3Myzp3iMvYM8HwiQOGKzQfDkx" consumerSecret:@"hg246cX16C6Ecsg3UI7JYqe0zAYxo0Ex9ZcbtCXj9U7nxIQBZK"];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    NSDictionary * languageURLPairs = @{
                                        @"en":[[NSBundle mainBundle] URLForResource:@"en.json" withExtension:nil],
                                        @"ru":[[NSBundle mainBundle] URLForResource:@"ru.json" withExtension:nil],
                                        };
    [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:@"en"];
    
    [MCLocalization sharedInstance].noKeyPlaceholder = @"[No '{key}' in '{language}']";
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [userDefaults objectForKey:@"language"];
    if ([result length])
        [MCLocalization sharedInstance].language = result;
    else
        [MCLocalization sharedInstance].language = @"en";
    
    
    
    
   
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"go to bg");
    timeGoToBackground = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%f",timeGoToBackground);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0; // unset badge number
    NSLog(@"return to app");
    double timeNow = [[NSDate date] timeIntervalSince1970];
    float milliseconds_by_one_min = 60.f;
    if( (timeGoToBackground + (milliseconds_by_one_min * 3)) <= timeNow )
    {
        NSLog(@"RELOAD WEBVIEW");
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        SWRevealViewController * swreal = (SWRevealViewController*)keyWindow.rootViewController;
        UINavigationController * nv = (UINavigationController*)swreal.frontViewController;
        if([nv.viewControllers count] >= 1)
        {
            for(id gotCntrl in nv.viewControllers)
                if([gotCntrl isKindOfClass:[ExtendedLGSideMenuController class]])
                {
                    ExtendedLGSideMenuController *LGSideMenuC = (ExtendedLGSideMenuController*)gotCntrl;
                    UINavigationController *nv_2 = (UINavigationController*)LGSideMenuC.rootViewController;
                    
                    if([nv_2.viewControllers count] >= 1)
                    {
                        for(id tradeViewID in nv_2.viewControllers)
                            if([tradeViewID isKindOfClass:[TradeViewController class]])
                            {
                                TradeViewController *tradeViewC = (TradeViewController*)tradeViewID;
                                NSLog(@"%@",tradeViewC);
                                [tradeViewC.webView reload];
                            }
                    }
                }
        }
    }
//    else
//        NSLog(@"do is nothing");
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - PushNotificationMethods

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* token = [[[[NSString stringWithFormat:@"%@", deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"My token is: %@", token);
//    [[VVSettings sharedManager] saveDeviceToken:token];
    [[[APIModel alloc] init] setTokenPushWithToken:_tpzUser.token andNewToken:token onSuccess:^(NSDictionary *data) {
        NSLog(@"token push updated");
    } onFailure:^(NSString *error) {
        NSLog(@"token push fail");
    }];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}



@end
