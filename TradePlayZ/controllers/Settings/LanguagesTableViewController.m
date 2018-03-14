//
//  LanguagesTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 13.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "LanguagesTableViewController.h"
#import "LanguageTableViewCell.h"

@interface LanguagesTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end


//cells
static NSString* languageCellIdentifier = @"languageCell";


@implementation LanguagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [MCLocalization stringForKey:@"change_lang"];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.tableHeaderView = headerView;
    
    
    [self registerCell];
     [self initTableData];
}

- (void)registerCell
{
    [self.tableView registerClass:[LanguageTableViewCell class] forCellReuseIdentifier:languageCellIdentifier];
}


- (void)initTableData
{
    self.tableData = @[
                       
                       
                       @{@"title":@"English",
                         @"lang":@"en"},
                       
                       @{@"title":@"Русский",
                         @"lang":@"ru"},
                       
                      
                       
                       
                       ];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    UITableViewCell* cellDef;
    
    
    
    
  
        LanguageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:languageCellIdentifier];
        
        
        cell.textLabel.text = [dictionaryCell objectForKey:@"title"];
    
        cellDef = cell;
  
    
    
    
    
    
    return cellDef;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    NSLog(@"did select %@",[dictionaryCell objectForKey:@"lang"]);
  
    
    [MCLocalization sharedInstance].language = [dictionaryCell objectForKey:@"lang"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[MCLocalization sharedInstance].language forKey:@"language"];
    [userDefaults synchronize];
    
    //show login controller
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc =[sb instantiateInitialViewController];
    
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = vc;
    
    
    
    [UIView transitionWithView:window
                      duration:0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve //UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
    
//    NSLog(@"did select");
}

@end
