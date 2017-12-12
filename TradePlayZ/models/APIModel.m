//
//  APIModel.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "APIModel.h"
#import "AFNetworking.h"



#define DOMAIN_API @"http://dev.tradeplayz.com/api/"


@implementation APIModel

- (void)registrationWith:(NSDictionary *)user
       andWithUserDevice:(NSDictionary *)userDevice
               onSuccess:(void(^)(NSDictionary *data))success
               onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"login/newUser";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"user": user, @"user_device":userDevice, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
            failure([responseObject objectForKey:@"error_text"]);
        else
            success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
            failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (void)loginWith:(NSDictionary *)user
andWithUserDevice:(NSDictionary *)userDevice
        onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"login";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"user": user, @"user_device":userDevice, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
            failure([responseObject objectForKey:@"error_text"]);
        else
            success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
        failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (void)loginWithNetworkProvider:(TPZUserProvider *)provider
                      andTPZUser:(NSDictionary *)user
               andWithUserDevice:(NSDictionary *)userDevice
                       onSuccess:(void(^)(NSDictionary *data))success
                       onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"login/authSocial";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    NSLog(@"%@",provider.loginProvider);
    NSLog(@"%@",provider.loginProviderIdentifier);
    NSLog(@"%@",user);
    NSLog(@"%@",userDevice);
    
    NSDictionary *parameters = @{@"social":provider.loginProvider, @"provider":@{@"loginprovideridentifier":provider.loginProviderIdentifier}, @"user": user, @"user_device":userDevice, @"language":[MCLocalization sharedInstance].language};
    NSLog(@"%@",parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
            failure([responseObject objectForKey:@"error_text"]);
        else
            success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}


- (void)getUserProfileWithToken:(NSString*)token
                      OnSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"users/getProfile";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
            failure([responseObject objectForKey:@"error_text"]);
        else
            success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

-(void)checkExistToken:(NSString*)token
             OnSuccess:(void(^)(NSDictionary *data))success
             onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"login/validToken";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
            failure([responseObject objectForKey:@"error_text"]);
        else
            success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

@end
