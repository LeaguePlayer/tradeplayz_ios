//
//  TermsViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 01.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [MCLocalization stringForKey:@"terms"];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(closeTerms:)];
    //        self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationController.navigationBar.topItem.leftBarButtonItem = revealButtonItem;
}

-(void)closeTerms:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
