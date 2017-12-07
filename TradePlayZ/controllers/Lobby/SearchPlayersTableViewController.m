//
//  SearchPlayersTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 30.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "SearchPlayersTableViewController.h"
#import "PlayersTableViewCell.h"

@interface SearchPlayersTableViewController ()

@end

//cells
static NSString* playersCellIdentifier = @"playersCell";

@implementation SearchPlayersTableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
//    APLProduct *product = ;
    
    
    
    NSDictionary* dictionaryCell;
    UITableViewCell* cellDef;
    
    
    dictionaryCell = self.filteredData[indexPath.row];
    
    PlayersTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:playersCellIdentifier];
    cell.placeLabel.text = [dictionaryCell objectForKey:@"place"];
    cell.playerLabel.text = [dictionaryCell objectForKey:@"player"];
    cell.showMe = [[dictionaryCell objectForKey:@"me"] boolValue];
    cell.status = [[dictionaryCell objectForKey:@"status"] integerValue];
    [cell changeStatus];
    
    cellDef = cell;
    
    
    
    
    return cellDef;
    
}

@end
