//
//  APIModel.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPZUserProvider.h"

@interface APIModel : NSObject

- (void)registrationWith:(NSDictionary *)user
       andWithUserDevice:(NSDictionary *)userDevice
               onSuccess:(void(^)(NSDictionary *data))success
               onFailure:(void(^)(NSString *error))failure;

- (void)getUserProfileWithToken:(NSString*)token
                OnSuccess:(void(^)(NSDictionary *data))success
               onFailure:(void(^)(NSString *error))failure;

-(void)checkExistToken:(NSString*)token
             OnSuccess:(void(^)(NSDictionary *data))success
             onFailure:(void(^)(NSString *error))failure;

- (void)loginWith:(NSDictionary *)user
       andWithUserDevice:(NSDictionary *)userDevice
               onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure;


- (void)loginWithNetworkProvider:(TPZUserProvider *)provider
                            andTPZUser:(NSDictionary *)user
                        andWithUserDevice:(NSDictionary *)userDevice
        onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure;


@end
