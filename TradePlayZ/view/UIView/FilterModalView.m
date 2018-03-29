//
//  FilterModalView.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 27.03.18.
//  Copyright © 2018 Leonid Minderov. All rights reserved.
//

#import "FilterModalView.h"

@implementation FilterModalView




-(id)init
{
    if (self = [super init]) {

        
        _picker = [[CZPickerView alloc] initWithHeaderTitle:[MCLocalization stringForKey:@"please_select"]
                                          cancelButtonTitle:[MCLocalization stringForKey:@"cancel"]
                                         confirmButtonTitle:[MCLocalization stringForKey:@"confirm"]];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.headerBackgroundColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0];
        
        float padding_top = 20.f;
        float padding_left = 24.f;
        float width_button = SCREEN_WIDTH - (padding_left*2);
        float height_field = 60.f;
        
        float top = padding_top;
        
        
        //row
        FilterCost = [FilterButton buttonWithType:UIButtonTypeCustom];
        [FilterCost setFrame:CGRectMake(padding_left, top, width_button, height_field)];
        FilterCost.identifierFilterString = [FilterTournamentFilter filterCost];
        [FilterCost configurateButtonWithCaption:[MCLocalization stringForKey:@"filter_cost"]];
        [FilterCost addTarget:self
                       action:@selector(showPicker:)
             forControlEvents:UIControlEventTouchUpInside];
        top += CGRectGetHeight(FilterCost.frame) + 1.f;
        
        
        //row
        FilterTypeTour = [FilterButton buttonWithType:UIButtonTypeCustom];
        [FilterTypeTour setFrame:CGRectMake(padding_left, top, width_button, height_field)];
        FilterTypeTour.identifierFilterString = [FilterTournamentFilter filterTypeTour];
        [FilterTypeTour configurateButtonWithCaption:[MCLocalization stringForKey:@"filter_type_tour"]];
        [FilterTypeTour addTarget:self
                           action:@selector(showPicker:)
                 forControlEvents:UIControlEventTouchUpInside];
        top += CGRectGetHeight(FilterTypeTour.frame) + 1.f;
        
        
        //row
        FilterTypeGame = [FilterButton buttonWithType:UIButtonTypeCustom];
        [FilterTypeGame setFrame:CGRectMake(padding_left, top, width_button, height_field)];
        FilterTypeGame.identifierFilterString = [FilterTournamentFilter filterTypeGame];
        [FilterTypeGame configurateButtonWithCaption:[MCLocalization stringForKey:@"filter_type_game"]];
        [FilterTypeGame addTarget:self
                           action:@selector(showPicker:)
                 forControlEvents:UIControlEventTouchUpInside];
        top += CGRectGetHeight(FilterTypeGame.frame) + 25.f;
        
        
        //row
        width_button = (width_button - padding_left)/2;
        float height_button = 36.5f;
        
        BaseButton *searchButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [searchButton addTarget:self
                         action:@selector(searchAction:)
               forControlEvents:UIControlEventTouchUpInside];
        [searchButton setTitle:[MCLocalization stringForKey:@"search"] forState:UIControlStateNormal];
        searchButton.frame = CGRectMake(padding_left+width_button+padding_left , top, width_button, height_button);
        
        
        
        ChatButton* resetFilterButton = [ChatButton buttonWithType:UIButtonTypeCustom];
        [resetFilterButton addTarget:self
                              action:@selector(setResetParams:)
                    forControlEvents:UIControlEventTouchUpInside];
        [resetFilterButton setTitle:[MCLocalization stringForKey:@"resetFilter"] forState:UIControlStateNormal];
        resetFilterButton.frame = CGRectMake(padding_left, top, width_button, height_button);
        [resetFilterButton setActive];
        
        
        [self addSubview:FilterCost];
        [self addSubview:FilterTypeTour];
        [self addSubview:FilterTypeGame];
        [self addSubview:searchButton];
        [self addSubview:resetFilterButton];
    }
    return self;
}

-(void)configurateView
{
    for(id fieldName in [_filterTournament getFilterIDValues])
    {
        int gotValue = [[[_filterTournament getFilterIDValues] objectForKey:fieldName] intValue];
        FilterButton *GOTbutton = (FilterButton*)[self valueForKey:fieldName];
        
        NSString* gotFilterParamName = [FilterTournamentFilter valueForKey:[NSString stringWithFormat:@"get%@Values",fieldName]][gotValue];
        
        [GOTbutton setFilterValue:gotFilterParamName];
    }
}

-(void)searchAction:(BaseButton*)sender
{
    [_filterTournament saveFilter];
//    self.popup
    [KLCPopup dismissAllPopups];
}

-(void)setResetParams:(BaseButton*)sender
{
    [_filterTournament resetFilter];
    [self configurateView];
    
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView;
{
    return self.theData.count;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return self.theData[row];
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    NSString* newValue = self.theData[row];
    [senderButton setFilterValue:newValue];
    
    [_filterTournament setValue:@(row) forKey:[NSString stringWithFormat:@"%@ID",senderButton.identifierFilterString]];
    
}

-(void)showPicker:(FilterButton*)sender
{
    senderButton = sender;
    
    int last_selected_row = [[_filterTournament valueForKey:[NSString stringWithFormat:@"%@ID",sender.identifierFilterString]] intValue];
    
    _theData = [FilterTournamentFilter valueForKey:[NSString stringWithFormat:@"get%@Values",sender.identifierFilterString]];
    
    [_picker setSelectedRows:@[@(last_selected_row)]];
    [_picker show];
}

@end

