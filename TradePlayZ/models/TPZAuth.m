//
//  TPZAuth.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TPZAuth.h"


@implementation TPZAuth

-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:^{
        }];
    });
}


- (void)registrationOnSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSString *))failure
{
    NSDictionary* userParams = @{
                                 @"login":self.user.login,
                                 @"password":[self.password MD5],
                                 @"currency":self.user.currency,
                                 };
    
    
    [[[APIModel alloc] init] registrationWith:userParams andWithUserDevice:[self.user getDeviceParams] onSuccess:^(NSDictionary *data) {
        NSDictionary* jsonData = [data objectForKey:@"response"];
        success(jsonData);
        
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        failure(error);
    }];
}

- (void)loginOnSuccess:(void(^)(NSDictionary *data))success
             onFailure:(void(^)(NSString *error))failure
{
    NSDictionary* userParams = @{
                                 @"login":self.user.login,
                                 @"password":[self.password MD5],
                                 };
    

    
    [[[APIModel alloc] init] loginWith:userParams andWithUserDevice:[self.user getDeviceParams] onSuccess:^(NSDictionary *data) {
        NSDictionary* jsonData = [data objectForKey:@"response"];
        success(jsonData);
        
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        failure(error);
    }];
}

- (void)loginWithSocialNetworkOnSuccess:(void(^)(NSDictionary *data))success
                              onFailure:(void(^)(NSString *error))failure
{

    NSMutableDictionary* userParams = [[NSMutableDictionary alloc] init];
    
    NSLog(@"%@",self.user.lastname);
    if(self.user.email != nil) [userParams setObject:self.user.email forKey:@"email"];
    if(self.user.firstname != nil) [userParams setObject:self.user.firstname forKey:@"firstname"];
    if(self.user.lastname != nil) [userParams setObject:self.user.lastname forKey:@"lastname"];
    if(self.user.img_avatar!=nil) [userParams setObject:self.user.img_avatar forKey:@"img_avatar"];


    
    [[[APIModel alloc] init] loginWithNetworkProvider:self.user.provider andTPZUser:userParams andWithUserDevice:[self.user getDeviceParams] onSuccess:^(NSDictionary *data) {
        NSDictionary* jsonData = [data objectForKey:@"response"];
        success(jsonData);
    } onFailure:^(NSString *error) {
        [self showMessage:error withTitle:[MCLocalization stringForKey:@"error"]];
        failure(error);
    }];
   

    
}

@end
