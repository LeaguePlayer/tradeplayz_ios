//
//  RecoveryPasswordViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 22.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "RecoveryPasswordViewController.h"

@interface RecoveryPasswordViewController ()

@end

@implementation RecoveryPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self buildContent];
}


-(void)buildContent
{
    float top = 60.f;
    
    //row
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, 36)];
    [titleLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:31.0f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.text = [MCLocalization stringForKey:@"forgot_password"];
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@6 range:NSMakeRange(0, [titleLabel.text length])];
    [titleLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(titleLabel.frame) + 36.f;
    
    
    //row
    float width_field = 226.5f;
    float height_field = 55.f;
    self.emailField = [[BaseTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width_field)/2, top, width_field, height_field)];
    [self.emailField setPlaceHolderText:@"E-MAIL"];
    self.emailField.delegate = self;
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailField.tag = 0;
    
    top += CGRectGetHeight(self.emailField.frame) + 12.5f +  CGRectGetHeight(self.emailField.frame) + 21.5f +35.f+21.5f;
    
    
  
    float width_button = 226.5f;
    float height_button = 55.f;
    BaseButton *recoveryPasswordButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [recoveryPasswordButton addTarget:self
                          action:@selector(recoveryPasswordAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [recoveryPasswordButton setTitle:[MCLocalization stringForKey:@"recovery_password"] forState:UIControlStateNormal];
    recoveryPasswordButton.frame = CGRectMake((SCREEN_WIDTH - width_button)/2 , top, width_button, height_button);
    
    top += CGRectGetHeight(recoveryPasswordButton.frame) + 40.f;
    
    
    
    //
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
    
    //
    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:self.emailField];
    [self.scrollView addSubview:recoveryPasswordButton];
}

-(void)recoveryPasswordAction:(id)sender
{
    NSLog(@"recoveryPasswordAction");
    
    [[[APIModel alloc] init] recoveryPasswordByEmail:self.emailField.text onSuccess:^(NSDictionary *data) {
        NSDictionary *obj = [[data objectForKey:@"response"] objectForKey:@"recovery"];
        
        
        
                [self.navigationController popToRootViewControllerAnimated:YES];
         
        [self showMessage:[obj objectForKey:@"message"] withTitle:[MCLocalization stringForKey:@"alert"]];
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
    }];
    
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
