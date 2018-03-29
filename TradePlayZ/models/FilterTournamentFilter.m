//
//  FilterTournamentFilter.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "FilterTournamentFilter.h"
#define kSETTINGS @"kSettings"


// 1/5
static NSString* const filterCost = @"FilterCost";
static NSString* const filterTypeTour = @"FilterTypeTour";
static NSString* const filterTypeGame = @"FilterTypeGame";

@implementation FilterTournamentFilter

// 1/5
-(id)init
{
    self = [super init];
    
    _FilterCostID = 0;
    _FilterTypeTourID = 0;
    _FilterTypeGameID = 0;
    settings = [NSUserDefaults standardUserDefaults];

    
    return self;
}

// 6/6
-(NSDictionary*)getFilterIDValues{
    return @{
             filterCost: @(_FilterCostID),
             filterTypeTour: @(_FilterTypeTourID),
             filterTypeGame: @(_FilterTypeGameID)};
}

// 2/5
+ (NSString *)filterCost { return filterCost; }
+(NSArray *)getFilterCostValues { return @[[MCLocalization stringForKey:@"no_chosen_filter"],
                                           [MCLocalization stringForKey:@"filter_cost_value_0"],
                                           [MCLocalization stringForKey:@"filter_cost_value_1"],
                                           [MCLocalization stringForKey:@"filter_cost_value_2"],
                                           [MCLocalization stringForKey:@"filter_cost_value_3"]]; }


+ (NSString *)filterTypeTour { return filterTypeTour; }
+(NSArray *)getFilterTypeTourValues { return @[[MCLocalization stringForKey:@"no_chosen_filter"],
                                               [MCLocalization stringForKey:@"filter_type_tour_value_1"]]; }

+ (NSString *)filterTypeGame { return filterTypeGame; }
+(NSArray *)getFilterTypeGameValues { return @[[MCLocalization stringForKey:@"no_chosen_filter"],
                                               [MCLocalization stringForKey:@"filter_type_game_value_1"]]; }


//
-(void)loadFilter{
    theData = [settings objectForKey:kSETTINGS];
    if(theData != nil)
    {
        [theData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:obj forKey:[NSString stringWithFormat:@"%@ID",key]];
        }];
    }
}

-(void)saveFilter
{

    theData = [[NSMutableDictionary alloc] init];
    [[self getFilterIDValues] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [theData setObject:obj forKey:key];
    }];
    
    [settings setObject:theData forKey:kSETTINGS];
    
    
}

-(BOOL)filterIsActive
{
    BOOL active = NO;
    
    for(id key in [self getFilterIDValues])
    {
        int value = [[self valueForKey:[NSString stringWithFormat:@"%@ID",key]] intValue];
        if(value > 0)
            return YES;

    }
    
    return active;
}

-(void)resetFilter
{
    [[self getFilterIDValues] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setValue:@(0) forKey:[NSString stringWithFormat:@"%@ID",key]];
    }];
}


@end
