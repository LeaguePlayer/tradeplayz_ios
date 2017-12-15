//
//  FAQTableViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 28.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "FAQTableViewController.h"
#import "FAQTableViewCell.h"
#import "FAQModalView.h"

@interface FAQTableViewController ()
@property (strong, nonatomic) NSArray* tableData;
@end

//cells
static NSString* faqCellIdentifier = @"faqCell";

@implementation FAQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MCLocalization stringForKey:@"FAQ"];
    query_string = @"";
    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    float widthField = 227.f;
    float heightField = 34;
    _searchField = [[SmallBaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-widthField)/2, (CGRectGetHeight(headerView.frame)-heightField)/2, widthField, heightField)];
    _searchField.delegate = self;
    _searchField.tag = 0;
    [_searchField setPlaceHolderText:[MCLocalization stringForKey:@"search"]];
    [headerView addSubview:_searchField];
    
    _activityView = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    _activityView.frame = CGRectMake((SCREEN_WIDTH-widthField)/2-heightField-8.f, (CGRectGetHeight(headerView.frame)-heightField)/2, heightField, heightField);
    [_activityView startAnimating];
    _activityView.alpha = 0.f;
    [headerView addSubview:_activityView];
    
    self.tableView.tableHeaderView = headerView;
    
    [self registerCell];
}


- (void)registerCell
{
    [self.tableView registerClass:[FAQTableViewCell class] forCellReuseIdentifier:faqCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initTableData];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableData
{
    _activityView.alpha = 1.f;
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    [[[APIModel alloc] init] getFAQ:self.authUser.token andQuery:query_string onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"faq"];
        
        for(NSDictionary* faq in obj)
            [tmpData addObject:@{@"type":faqCellIdentifier,
                                 @"title":[faq objectForKey:@"title"],
                                 @"description":[faq objectForKey:@"description"]}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableData = tmpData;
            // buildContent
            [self.tableView reloadData];
            _activityView.alpha = 0.f;
        });
        
        
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        _activityView.alpha = 0.f;
    }];
    

    
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    FAQTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:faqCellIdentifier];
    NSString *titleFAQ = [dictionaryCell objectForKey:@"title"];
    
    CGSize added_size = [Functions getHeightTextWithoutLabel:cell.titleFAQLabel.font andWidthWillLabel:cell.titleFAQLabel.frame.size.width andString:titleFAQ];
//    return 50.f;
    return 38.f  + (added_size.height - 18.f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    
    UITableViewCell* cellDef;
    
    
    
    
    if ([[dictionaryCell objectForKey:@"type"] isEqualToString:faqCellIdentifier]) {
        FAQTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:faqCellIdentifier];
        
        

        [cell setFaqTitle:[dictionaryCell objectForKey:@"title"]];
        
        cellDef = cell;
    }
    
    
    
    
    
    return cellDef;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        query_string = textField.text;
        [textField resignFirstResponder];
        
        [self initTableData];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dictionaryCell = [self.tableData objectAtIndex:indexPath.row];
    FAQTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:faqCellIdentifier];
    [cell setFaqTitle:[dictionaryCell objectForKey:@"title"]];
    
    FAQModalView* contentView = [[FAQModalView alloc] init];
    
    contentView.titlePlace = cell.titleFAQLabel;
    [contentView setDescriptionText:[dictionaryCell objectForKey:@"description"]];
    contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, [contentView getHeightModal]);
    
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_modal"]];
    
    
    
    self.popup = [KLCPopup popupWithContentView:contentView];
    [_popup show];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
