//
//  RegistrationViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 26.11.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "RegistrationViewController.h"
#import "BaseButton.h"
#import "LobbyBaseNavigationController.h"



@interface RegistrationViewController ()
@property(nonatomic,retain) CZPickerView *picker;
@property (strong,nonatomic) NSArray *theData;
@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.theData = @[@"$ USD",@"\u20AC EUR",@"₽ RUB"]; // тут последовательность привязана с серверной частью - не менять!!
    selectedCurrency = @"$ USD"; // default value
    
    _picker = [[CZPickerView alloc] initWithHeaderTitle:[MCLocalization stringForKey:@"currency"]
                                      cancelButtonTitle:[MCLocalization stringForKey:@"cancel"]
                                     confirmButtonTitle:[MCLocalization stringForKey:@"confirm"]];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.headerBackgroundColor = [UIColor colorWithRed:1.00 green:0.28 blue:0.00 alpha:1.0];
    
    
    
   
    
    [self buildContent];
}

-(void)dismissKeyboard
{
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)buildContent
{
    float top = 60.f;
    float widthObject = 240.f;
    
    //row
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 36)];
    [titleLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:31.0f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.text = [MCLocalization stringForKey:@"open_account"];
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@6 range:NSMakeRange(0, [titleLabel.text length])];
    [titleLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(titleLabel.frame) + 36.f;
    
    //row
    float width_field = 226.5f;
    float padding_left = (SCREEN_WIDTH - width_field)/2;
    
    UILabel* highLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_field, 25.f)];
    [highLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [highLabel setTextColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]];
    highLabel.text = [NSString stringWithFormat:@"%@:",[MCLocalization stringForKey:@"part_1"]];
    top += CGRectGetHeight(highLabel.frame) + 5.f ;
    
    
    //row
    float width_number_label = 20.f;
    UILabel* numberOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_number_label, 25.f)];
    [numberOneLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [numberOneLabel setTextColor:[UIColor whiteColor]];
    numberOneLabel.text = @"1.";
    [numberOneLabel sizeToFit];
    
    //
    UILabel* middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+width_number_label, top, width_field-width_number_label, 25.f)];
    [middleLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [middleLabel setTextColor:[UIColor whiteColor]];
    middleLabel.text = [MCLocalization stringForKey:@"part_2"];
    middleLabel.numberOfLines = 0;
    middleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [middleLabel sizeToFit];
    
    CGSize middleLabelSize = [Functions getHeightLabelWithFont:middleLabel];
    top += middleLabelSize.height + 5.f ;
    
    
    //row
    UILabel* numberTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left, top, width_number_label, 25.f)];
    [numberTwoLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [numberTwoLabel setTextColor:[UIColor whiteColor]];
    numberTwoLabel.text = @"2.";
    [numberTwoLabel sizeToFit];
    
    //
    UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding_left+width_number_label, top, width_field-width_number_label, 25.f)];
    [bottomLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
    [bottomLabel setTextColor:[UIColor whiteColor]];
    bottomLabel.text = [MCLocalization stringForKey:@"part_3"];
    bottomLabel.numberOfLines = 0;
    bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [bottomLabel sizeToFit];
    
    CGSize bottomLabelSize = [Functions getHeightLabelWithFont:middleLabel];
    top += bottomLabelSize.height +  21.5f;
    
    //row
    float height_field = 55.f;
    self.emailField = [[BaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_field)/2, top, width_field, height_field)];
    [self.emailField setPlaceHolderText:@"E-MAIL"];
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone; //UITextAutocapitalizationTypeWords
    self.emailField.tag = 0;
    self.emailField.delegate = self;
    
    top += CGRectGetHeight(self.emailField.frame) + 12.5f;
    
    
    
    
//    self.emailField.inputView = picker;
//
    
    
    //row
    self.passwordField = [[BaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_field)/2, top, width_field, height_field)];
    [self.passwordField setPlaceHolderText:@"PASSWORD"];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
     self.passwordField.tag = 1;
    
    top += CGRectGetHeight(self.passwordField.frame) + 12.5f;
    
    
    
    //row
    width_field = 107.f;
    float spacing = CGRectGetWidth(self.passwordField.frame) - (width_field *2);
    self.currencyField = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.currencyField setFrame:CGRectMake(padding_left, top, width_field, height_field)];
    [self.currencyField setTitle:@"$ USD" forState:UIControlStateNormal];
    self.currencyField.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    self.currencyField.backgroundColor = [UIColor clearColor];
    [self.currencyField setTitleEdgeInsets:UIEdgeInsetsMake(0, -32.f, 0, 0)];

     [self.currencyField setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    self.currencyField.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    self.currencyField.layer.borderWidth= 2.0f;
    [self.currencyField addTarget:self
                          action:@selector(dropDownList:)
                forControlEvents:UIControlEventTouchUpInside];
    
    //
    UIImageView* dropDownIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop_down"]];
    CGRect frame = dropDownIcon.frame;
    frame.origin.y = (CGRectGetHeight(self.currencyField.frame)-frame.size.height)/2;
    frame.origin.x = CGRectGetWidth(self.currencyField.frame)-frame.size.width-18.f;
    dropDownIcon.frame = frame;
    [self.currencyField addSubview:dropDownIcon];
    
    
    //
//    self.policyField = [[BaseTextField alloc] initWithFrame:CGRectMake(padding_left+spacing+CGRectGetWidth(self.currencyField.frame), top, width_field, height_field)];
//    self.policyField.text = ;
//    self.policyField.delegate = self;
    
    self.policyField = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.policyField setFrame:CGRectMake(padding_left+spacing+CGRectGetWidth(self.currencyField.frame), top, width_field, height_field)];
    [self.policyField setTitle:[MCLocalization stringForKey:@"18_years"] forState:UIControlStateNormal];
    self.policyField.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    self.policyField.backgroundColor = [UIColor clearColor];
    [self.policyField.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.policyField setTitleEdgeInsets:UIEdgeInsetsMake(0, -32.f, 0, 0)];
    [self.policyField setImageEdgeInsets:UIEdgeInsetsMake(0, 72.f, 0, 0)];
//    [self.policyField setSemanticContentAttribute:UISe];
    [self.policyField setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    self.policyField.layer.borderColor=[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0].CGColor;
    self.policyField.layer.borderWidth= 2.0f;
    
//    self.policyField.titleEdgeInsets = UIEdgeInsetsMake(0, 150.f, 0, 0);
    [self.policyField setImage:[UIImage imageNamed:@"check_no"]
                        forState:UIControlStateNormal];
    [self.policyField setImage:[UIImage imageNamed:@"check_done"]
                        forState:UIControlStateSelected];
//    self.policyField.adjustsImageWhenHighlighted=YES;
//    [self.policyField addTarget:self action:@selector(checkboxSelected:) forControlEvents:(UIControlEvents)];
    [self.policyField addTarget:self
                          action:@selector(checkboxSelected:)
                forControlEvents:UIControlEventTouchUpInside];
    top += CGRectGetHeight(self.policyField.frame) + 24.0f;
    
    //
//    UIImageView* checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
//    agree_terms_and_conditions = NO;
//    frame = checkBox.frame;
//    frame.origin.y = (CGRectGetHeight(self.policyField.frame)-frame.size.height)/2;
//    frame.origin.x = CGRectGetWidth(self.policyField.frame)-frame.size.width-18.f;
//    checkBox.frame = frame;
//    [self.policyField addSubview:checkBox];
    
    
    //row
    float width_button = 226.5f;
    float height_button = 55.f;
    BaseButton *openAccountButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [openAccountButton addTarget:self
                          action:@selector(openAccount:)
                forControlEvents:UIControlEventTouchUpInside];
    [openAccountButton setTitle:[MCLocalization stringForKey:@"open_account"] forState:UIControlStateNormal];
    openAccountButton.frame = CGRectMake((SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    
    top += CGRectGetHeight(openAccountButton.frame) + 40.f;
    
    
    
    //row
    UILabel* termsLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_button)/2-22.5, top, width_button+(35*2), 36)];
    [termsLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:14.0f]];
//    [termsLabel setBackgroundColor:[UIColor yellowColor]];
    [termsLabel setTextColor:[UIColor whiteColor]];
    [termsLabel setTextAlignment:NSTextAlignmentCenter];
    termsLabel.text = [NSString stringWithFormat:@"%@ %@", [MCLocalization stringForKey:@"part_4"], [MCLocalization stringForKey:@"terms"]];
    termsLabel.numberOfLines = 0;
    termsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [termsLabel sizeToFit];

    //
    int part_4_lenght = [[MCLocalization stringForKey:@"part_4"] length];
    int term_string = [[MCLocalization stringForKey:@"terms"] length];
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:termsLabel.text];
        [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(part_4_lenght+1, term_string)];
        [commentString addAttribute: NSForegroundColorAttributeName //NSFontAttributeName
                              value:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0]
                              range:NSMakeRange(part_4_lenght+1, term_string)];
    [termsLabel setAttributedText:commentString];
    
    //
    // label setup code omitted
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTerms:)];
    [termsLabel setUserInteractionEnabled:YES];
    [termsLabel addGestureRecognizer:tap];
    
    top += CGRectGetHeight(titleLabel.frame) + 36.f;
    
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    
    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:self.emailField];
    [self.scrollView addSubview:self.passwordField];
    [self.scrollView addSubview:highLabel];
     [self.scrollView addSubview:numberOneLabel];
     [self.scrollView addSubview:middleLabel];
     [self.scrollView addSubview:numberTwoLabel];
    [self.scrollView addSubview:bottomLabel];
    [self.scrollView addSubview:self.currencyField];
    [self.scrollView addSubview:self.policyField];
    [self.scrollView addSubview:openAccountButton];
    [self.scrollView addSubview:termsLabel];
}

-(void)checkboxSelected:(id)sender
{
    agree_terms_and_conditions = !agree_terms_and_conditions; /* Toggle */
    [self.policyField setSelected:agree_terms_and_conditions];
}



-(void)openAccount:(id)sender
{
    
    
    if(agree_terms_and_conditions)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        NSInteger currency = [self.theData indexOfObject:selectedCurrency];
        NSString* login = self.emailField.text;
        NSString* password = self.passwordField.text;
        //
        
        NSLog(@"%@",self.authUser);
        self.authUser.currency = [NSString stringWithFormat:@"%li", (long)currency];
        self.authUser.login = login;
        NSLog(@"%@",self.authUser.login);
        
        TPZAuth* tpzAuth = [[TPZAuth alloc] init];
        tpzAuth.user = self.authUser;
        tpzAuth.password = password;
        [tpzAuth registrationOnSuccess:^(NSDictionary *data) {
            NSLog(@"user authed!");
            self.authUser.token = [data objectForKey:@"token"];
            [userDefaults setObject:self.authUser.token forKey:@"token"];
            [userDefaults synchronize];
            
            [self.authUser actualizeProfileOnSuccess:^(NSDictionary *data) {
                [self login];
            } onFailure:^(NSString *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
            }];
        } onFailure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
        
        NSLog(@"%@",self.authUser);
//        UIApplication.sharedApplication.delegate.win
//        NSLog(@"%@",tpzAuth);
//        
//        NSLog(@"%@",tpzAuth);
    }
    else
    {
        [self showMessage:[MCLocalization stringForKey:@"error_18_age"]
                withTitle:[MCLocalization stringForKey:@"error"]];
    }
}

-(void)dropDownList:(id)sender
{
    [_picker show];
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
    selectedCurrency = self.theData[row];
    [self.currencyField setTitle:self.theData[row] forState:UIControlStateNormal];

}

//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return self.theData.count;
//}
//
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return  1;
//}
//
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.theData[row];
//}
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    self.tf.text = self.theData[row];
//    [self.tf resignFirstResponder];
//}

-(void)showTerms:(UIGestureRecognizer*)recognizer
{
    NSLog(@"show terms");
    NSURL *url = [NSURL URLWithString:@"http://tradeplayz.com/tpz_whitepaper.pdf"];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
    }else{
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:url];
    }
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    LobbyBaseNavigationController *vc = [storyboard instantiateViewControllerWithIdentifier:@"termsAction"];
//    vc.aliasPage = @"term-and-conditions";
//        [self presentViewController:vc animated:YES completion:nil];
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

- (IBAction)goAuth:(id)sender {
    
   
}
@end
