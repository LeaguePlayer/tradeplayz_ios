//
//  MenuTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "MenuTableViewController.h"
#import "ImageTitleMenuTableViewCell.h"
#import "WelcomeMenuTableViewCell.h"
#import "MailTableViewCell.h"
#import "HistoryTradeTableViewController.h"
#import "LobbyBaseNavigationController.h"
#import "ExtendedLGSideMenuController.h"

@interface MenuTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* welcomeAccountCellIdentifier = @"welcomeAccountCell";
static NSString* imageWithTitleForMenuCellIdentifier = @"imageWithTitleForMenuCell";
static NSString* mailCellIdentifier = @"mailCell";

// actions
static NSString* actionTrade = @"actionTrade";
static NSString* actionTradeHistory = @"actionTradeHistory";
static NSString* actionWithdraw = @"actionWithdraw";
static NSString* actionLiveChat = @"actionLiveChat";
static NSString* actionFAQ = @"actionFAQ";
static NSString* actionTutorial = @"actionTutorial";
static NSString* actionSettings = @"actionSettings";
static NSString* actionLogout = @"actionLogout";


@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNeedsStatusBarAppearanceUpdate];
    self.tableView.separatorColor = [UIColor clearColor];
    
    builded_content = NO;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"bgmenu"]];
   
    
    [self registerCell];
}

- (void)registerCell
{
    [self.tableView registerClass:[WelcomeMenuTableViewCell class] forCellReuseIdentifier:welcomeAccountCellIdentifier];
    [self.tableView registerClass:[ImageTitleMenuTableViewCell class] forCellReuseIdentifier:imageWithTitleForMenuCellIdentifier];
     [self.tableView registerClass:[MailTableViewCell class] forCellReuseIdentifier:mailCellIdentifier];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.tableData count];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if(builded_content)
        [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
            [self initTableData];
            [self.tableView reloadData];
        } onFailure:^(NSString *error) {
        }];
    else
    {
        [self initTableData];
        [self.tableView reloadData];
        builded_content = YES;
    }
}

//- (void)viewDidAppear:(BOOL)animated
//{
//
//    [super viewDidAppear:animated];
//
//
//
//
//
//
//
//}



- (void)initTableData
{
    self.tableData = @[@{@"type":welcomeAccountCellIdentifier,
                         @"title":[self.authUser getFullName],
                         @"country":self.authUser.country,
                         @"balance":self.authUser.balance,
                         @"rating":self.authUser.rating,
                         @"avatar":self.authUser.img_avatar},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"Trade"],
                         @"action":actionTrade,
                         @"iconName":@"i_trade"},
                       
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"TradeHistory"],
                         @"action":actionTradeHistory,
                         @"iconName":@"i_history"},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"Withdraw"],
                         @"action":actionWithdraw,
                         @"iconName":@"i_withdraw"},
                       
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"Live chat"],
                         @"action":actionLiveChat,
                         @"iconName":@"i_chat"},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"FAQ"],
                         @"action":actionFAQ,
                         @"iconName":@"i_faq"},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"Tutorial"],
                         @"action":actionTutorial,
                         @"iconName":@"i_tutorial"},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"Settings"],
                         @"action":actionSettings,
                         @"iconName":@"i_settings"},
                       
                       @{@"type":imageWithTitleForMenuCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"log out"],
                         @"action":actionLogout,
                         @"iconName":@"i_logout"},
                       
                       @{@"type":mailCellIdentifier,
                         @"title":[MCLocalization stringForKey:@"help mail"]},
                       
                    
                       ];
    
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:welcomeAccountCellIdentifier]) {
        WelcomeMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:welcomeAccountCellIdentifier];

        CGSize added_size = [Functions getHeightTextWithoutLabel:cell.nameLabel.font andWidthWillLabel:cell.nameLabel.frame.size.width andString:[dictionaryCell objectForKey:@"title"]];
        return 189.f + (added_size.height - 25.f);
    } else if ([[dictionaryCell objectForKey:@"type"] isEqualToString:mailCellIdentifier]) {
        return 60.f;
    }
    return 46.f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    UITableViewCell* cellDef;
    

    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:welcomeAccountCellIdentifier]) {
        WelcomeMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:welcomeAccountCellIdentifier];
        

        NSLog(@"%@",[dictionaryCell objectForKey:@"avatar"]);
        
        if([[dictionaryCell objectForKey:@"avatar"] isKindOfClass:[NSNull class]])
            [cell.avatarImageView setImage:[UIImage imageNamed:@"noavatar2"]];
        else
            [cell.avatarImageView setImageWithURL:[NSURL URLWithString:[dictionaryCell objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"noavatar2"]];

        
        
                [cell setName: [dictionaryCell objectForKey:@"title"] ];
        
        NSLog(@"%@",[dictionaryCell objectForKey:@"country"]);
            if(![dictionaryCell objectForKey:@"country"] || [[dictionaryCell objectForKey:@"country"] isKindOfClass:[NSNull class]])
                [cell.countryLabel setText: @"" ];
            else
                [cell.countryLabel setText: [dictionaryCell objectForKey:@"country"] ];
        
                [cell setBalance: [dictionaryCell objectForKey:@"balance"] ];
                [cell.ratingPlace setText: [[dictionaryCell objectForKey:@"rating"] stringValue] ];
        
        
        cellDef = cell;
    }
    else if ([[dictionaryCell objectForKey:@"type"] isEqualToString:imageWithTitleForMenuCellIdentifier]) {
        
        ImageTitleMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:imageWithTitleForMenuCellIdentifier];

         cell.textLabel.text = [dictionaryCell objectForKey:@"title"];
        UIImage* iconMenu = [UIImage imageNamed: [dictionaryCell objectForKey:@"iconName"] ];
        [cell.imageView setImage:iconMenu];
        cellDef = cell;
    }else if ([[dictionaryCell objectForKey:@"type"] isEqualToString:mailCellIdentifier]) {
        MailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:mailCellIdentifier];

        cell.textLabel.text = [dictionaryCell objectForKey:@"title"];
        cellDef = cell;
    }
    

    
    
    return cellDef;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(indexPath.row == 0)) { // запретил реагирование на аватарку на левом меню
//        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
         UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        if([[dictionaryCell objectForKey:@"action"] isEqualToString:actionLogout])
        {
            // выход
            // refresh data
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"token"];
            self.authUser = [[TPZUser alloc] init];
            [[FBSDKLoginManager new] logOut];
//            [signIn signOut];
//             [[GIDSignIn sharedInstance] signOut];
            
            
            //show login controller
            UIViewController *vc =[sb instantiateInitialViewController];
            
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            window.rootViewController = vc;
            
            
            
            [UIView transitionWithView:window
                              duration:0.3
                               options: UIViewAnimationOptionTransitionCrossDissolve //UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
        }else if([[dictionaryCell objectForKey:@"type"] isEqualToString:mailCellIdentifier])
        {
            // отправляем емейл
            NSString *recipients = [NSString stringWithFormat:@"mailto:%@",[dictionaryCell objectForKey:@"title"]];
            
//            NSString *body = @"&body=It is raining in sunny California!";
            
            NSString *email = [NSString stringWithFormat:@"%@", recipients];
            
            email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        }else if([[dictionaryCell objectForKey:@"action"] isEqualToString:actionSettings])
        {
            // переходим на другое представление
        
            
            SettingsViewController *settingController = [[SettingsViewController alloc] init];
            
            [self.navigationController pushViewController:settingController animated:YES];
            //            [revealController pushFrontViewController:navController animated:YES];
        }
        else if([[dictionaryCell objectForKey:@"action"] isEqualToString:actionFAQ])
        {
            NSURL *url = [NSURL URLWithString:@"http://tradeplayz.com/en"];
            
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
            }else{
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        else if([[dictionaryCell objectForKey:@"action"] isEqualToString:actionWithdraw])
        {
            // переходим на другое представление
            SWRevealViewController *revealController = self.revealViewController;
            
            
            NSString* identifier = [dictionaryCell objectForKey:@"action"];
            LobbyBaseNavigationController *navController = [sb instantiateViewControllerWithIdentifier: identifier ];
            navController.aliasPage = @"withdraw";
            [revealController pushFrontViewController:navController animated:YES];
        }
        else if([[dictionaryCell objectForKey:@"action"] isEqualToString:actionTutorial])
        {
            // переходим на другое представление
            SWRevealViewController *revealController = self.revealViewController;
            
            
            NSString* identifier = [dictionaryCell objectForKey:@"action"];
            LobbyBaseNavigationController *navController = [sb instantiateViewControllerWithIdentifier: identifier ];
            navController.aliasPage = @"tutorial";
            [revealController pushFrontViewController:navController animated:YES];
        }
        else
        {
            NSString* identifier = [dictionaryCell objectForKey:@"action"];
            
            if([identifier isEqualToString:actionTrade])
            {
                UINavigationController* gotNV = (UINavigationController*)self.revealViewController.frontViewController;
                // if trade controller is open - we close it
                for(id gotCntrl in gotNV.viewControllers)
                    if([gotCntrl isKindOfClass:[ExtendedLGSideMenuController class]])
                    {
                        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                        [self.revealViewController revealToggleAnimated:YES];
//                        [self.revealViewController.rightViewController ]
                         return;
                    }
                
            }
            
            
            // переходим на другое представление
            SWRevealViewController *revealController = self.revealViewController;
           
            
            
            LobbyBaseNavigationController *navController = [sb instantiateViewControllerWithIdentifier: identifier ];

            [revealController pushFrontViewController:navController animated:YES];
        }
        
        
       

        
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   

//    UIViewController* newFrontController = [[UIViewController alloc] init];
//    [newFrontController.view setBackgroundColor:[UIColor blackColor]];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];

   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
