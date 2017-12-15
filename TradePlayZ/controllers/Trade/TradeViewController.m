//
//  TradeViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TradeViewController.h"
#import "TournamentViewController.h"

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"TOURNAMENT\nLOBBY" style:UIBarButtonItemStylePlain target:self action:@selector(goToLobby:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    // Do any additional setup after loading the view.
}

-(void)goToLobby:(id)sender
{
    NSLog(@"go to lobby");
    NSLog(@"%d",_selected_id_tour);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TournamentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"tournamentView"];
    //    vc.order = model;
    vc.selectedTourId = [NSString stringWithFormat:@"%d",_selected_id_tour];
    [self.navigationController pushViewController:vc animated:YES];
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
