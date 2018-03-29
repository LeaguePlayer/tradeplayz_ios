//
//  FilterTournamentFilter.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterTournamentFilter : NSObject
{
    NSUserDefaults *settings;
    NSMutableDictionary* theData;
}
// 3/5
+(NSString *)filterCost;
+(NSArray *)getFilterCostValues;


+(NSString *)filterTypeTour;
+(NSArray *)getFilterTypeTourValues;

+(NSString *)filterTypeGame;
+(NSArray *)getFilterTypeGameValues;

// 4/5
@property (nonatomic) int FilterCostID;
@property (nonatomic) int FilterTypeTourID;
@property (nonatomic) int FilterTypeGameID;

//
-(void)saveFilter;
-(void)loadFilter;
-(NSDictionary*)getFilterIDValues;
-(BOOL)filterIsActive;
-(void)resetFilter;

@end
