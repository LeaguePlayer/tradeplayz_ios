//
//  TPZUser.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "TPZUser.h"
#import "UIDeviceHardware.h"

@implementation TPZUser


-(NSDictionary* )getDeviceParams
{
    NSString* id_os = [[UIDevice currentDevice] systemName];
    NSString* devicetoken = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *model_phone = [UIDeviceHardware platformString];
    NSString *device_type = @"0"; // its iOs
    NSLog(@"%@",devicetoken);
    NSDictionary *result = @{
                                @"id_os":id_os,
                                @"devicetoken": devicetoken,
                                @"model_phone":model_phone,
                                @"device_type":device_type,
                                };
    
    return result;
}


-(void)actualizeProfileOnSuccess:(void(^)(NSDictionary *data))success
                       onFailure:(void(^)(NSString *error))failure
{
    [[[APIModel alloc] init] getUserProfileWithToken:self.token OnSuccess:^(NSDictionary *data) {
        NSDictionary* jsonData = [[data objectForKey:@"response"] objectForKey:@"user"];
        
        // form data
        NSString *address = ([[jsonData objectForKey:@"address"] isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : [jsonData objectForKey:@"address"];
        address = ([address isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : address;
        

        
        
        NSString *zipCodeString = ([[jsonData objectForKey:@"zipcode"] isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : [jsonData objectForKey:@"zipcode"];
        zipCodeString = ([zipCodeString isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : zipCodeString;
        
        NSString *emailString = ([[jsonData objectForKey:@"email"] isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : [jsonData objectForKey:@"email"];
        emailString = ([emailString isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : emailString;
        
        NSString *phoneString = ([[jsonData objectForKey:@"phone"] isKindOfClass:[NSNull class]]) ? [MCLocalization stringForKey:@"not_specified"] : [jsonData objectForKey:@"phone"];
        phoneString = ([phoneString isEqualToString:@""]) ? [MCLocalization stringForKey:@"not_specified"] : phoneString;

        self.id_user = [jsonData objectForKey:@"id"];
        self.firstname = [jsonData objectForKey:@"firstname"];
        self.lastname = [jsonData objectForKey:@"lastname"];
        self.img_avatar = [jsonData objectForKey:@"img_avatar"];
        self.balance = [jsonData objectForKey:@"balance"];
        self.login = [jsonData objectForKey:@"login"];
        self.nickname = [jsonData objectForKey:@"nickname"];
        self.country = [jsonData objectForKey:@"country"];
        self.rating = [jsonData objectForKey:@"rating"];
        self.address = address;
        self.zipcode = zipCodeString;
//        self.country = country;
//        self.nickname = nickname;
        self.email = emailString;
        self.phone = phoneString;
        self.currency = [jsonData objectForKey:@"currency"];
        
        success(jsonData);
    } onFailure:^(NSString *error) {
        failure(error);
    }];
}

-(void)editProfileWithParams:(NSDictionary*)profileParams
                   andAvatarImage:(UIImage *)avatarImage
                   OnSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure
{
    NSLog(@"%@",self.token);
    [[[APIModel alloc]  init] editUserProfileWithToken:self.token andParams:profileParams andImage:avatarImage OnSuccess:^(NSDictionary *data) {
        [self actualizeProfileOnSuccess:^(NSDictionary *data) {
            success(data);
        } onFailure:^(NSString *error) {
            failure(error);
        }];
    } onFailure:^(NSString *error) {
        failure(error);
    }];
    
    
//    [[[APIModel alloc] init] editUserProfileWithToken:self.token andParams:profileParams OnSuccess:^(NSDictionary *data) {
//
//        [self actualizeProfileOnSuccess:^(NSDictionary *data) {
//            success(data);
//        } onFailure:^(NSString *error) {
//            failure(error);
//        }];
//
//    } onFailure:^(NSString *error) {
//        failure(error);
//    }];
}

-(NSString *)getFirstLastName
{
    NSString* fullName;
    
    NSString* firstname = @"";
    NSString* lastname = @"";
    
    if(![self.firstname isKindOfClass:[NSNull class]])
    firstname = self.firstname;
    
    if(![self.lastname isKindOfClass:[NSNull class]])
    lastname = self.lastname;
    
    fullName = [[NSString stringWithFormat:@"%@ %@", firstname, lastname] stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];
    
    if(![fullName length])
    fullName = self.email;
    
    return fullName;
}

-(NSString *)getFullName
{
    NSString* fullName;
    
    NSString* firstname = @"";
    NSString* lastname = @"";
    NSLog(@"%lu",(unsigned long)[self.nickname length]);
    if([self.nickname length] != 0 && ![self.nickname isKindOfClass:[NSNull class]])
        return self.nickname;
    
    if(![self.firstname isKindOfClass:[NSNull class]])
        firstname = self.firstname;
    
    if(![self.lastname isKindOfClass:[NSNull class]])
        lastname = self.lastname;
    
    fullName = [[NSString stringWithFormat:@"%@ %@", firstname, lastname] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    if(![fullName length])
        fullName = self.email;
    
    return fullName;
}

@end
