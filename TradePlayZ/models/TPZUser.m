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
        
        self.id_user = [jsonData objectForKey:@"id"];
        self.firstname = [jsonData objectForKey:@"firstname"];
        self.lastname = [jsonData objectForKey:@"lastname"];
        self.img_avatar = [jsonData objectForKey:@"img_avatar"];
        self.balance = [jsonData objectForKey:@"balance"];
        self.login = [jsonData objectForKey:@"login"];
        self.rating = [jsonData objectForKey:@"rating"];
        self.address = [jsonData objectForKey:@"address"];
        self.zipcode = [jsonData objectForKey:@"zipcode"];
        self.email = [jsonData objectForKey:@"email"];
        self.currency = [jsonData objectForKey:@"currency"];
        
        success(jsonData);
    } onFailure:^(NSString *error) {
        failure(error);
    }];
}

-(NSString *)getFullName
{
    NSString* fullName;
    
    NSString* firstname = @"";
    NSString* lastname = @"";
    
    if(![self.firstname isKindOfClass:[NSNull class]])
        firstname = self.firstname;
    
    if(![self.lastname isKindOfClass:[NSNull class]])
        lastname = self.lastname;
    
//    fullName = [NSString stringWithFormat:@"%@ %@", lastname, firstname];
    fullName = [[NSString stringWithFormat:@"%@ %@", lastname, firstname] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    if(![fullName length])
        fullName = self.email;
    
    return fullName;
}

@end
