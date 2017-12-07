//
//  TPZAuth.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPZUser.h"
#import "NSString+MD5.h"


@interface TPZAuth : NSObject


@property (nonatomic,retain) NSString* password;
@property (nonatomic,retain) TPZUser* user;


- (void)registrationOnSuccess:(void(^)(NSDictionary *data))success
                    onFailure:(void(^)(NSString *error))failure;

- (void)loginOnSuccess:(void(^)(NSDictionary *data))success
                    onFailure:(void(^)(NSString *error))failure;

- (void)loginWithSocialNetworkOnSuccess:(void(^)(NSDictionary *data))success
                onFailure:(void(^)(NSString *error))failure;

@end
