//
//  TPZUser.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPZUserProvider.h"

@interface TPZUser : NSObject

@property (nonatomic,retain) NSString* token;

@property (nonatomic,retain) NSString* id_user;
@property (nonatomic,retain) NSString* login;
@property (nonatomic,retain) NSString* currency;
@property (nonatomic,retain) NSString* firstname;
@property (nonatomic,retain) NSString* lastname;
@property (nonatomic,retain) NSString* img_avatar;
@property (nonatomic,retain) NSString* status;
@property (nonatomic,retain) NSString* balance;
@property (nonatomic,retain) NSString* rating;
@property (nonatomic,retain) NSString* address;
@property (nonatomic,retain) NSString* zipcode;
@property (nonatomic,retain) NSString* email;
@property (nonatomic,retain) NSString* phone;

@property (nonatomic,retain) TPZUserProvider* provider;


-(NSDictionary* )getDeviceParams;
-(NSString *)getFullName;

-(void)actualizeProfileOnSuccess:(void(^)(NSDictionary *data))success
                       onFailure:(void(^)(NSString *error))failure;


-(void)editProfileWithParams:(NSDictionary*)profileParams
              andAvatarImage:(UIImage *)avatarImage
                   OnSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure;


@end
