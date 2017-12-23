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

//#define DOMAIN_API @"http://tpz.server.loc.192.168.88.23.xip.io:8888/api/"


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

- (void)checkStatusTournamentByID:(NSString*)tourID
                         andToken:(NSString*)token
                        onSuccess:(void(^)(NSDictionary *data))success
                        onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/getStatusTour";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"id_tour": tourID, @"token":token, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)betWithSizing:(NSString*)sizing
           andTypeBet:(NSInteger)betType
             andToken:(NSString*)token
            onSuccess:(void(^)(NSDictionary *data))success
            onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/bet";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"sizing": sizing, @"id_type_bet":[NSString stringWithFormat:@"%ld",(long)betType], @"token":token, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)getActiveTournamentWithToken:(NSString*)token
                           onSuccess:(void(^)(NSDictionary *data))success
                           onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/getActiveTour";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token":token, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)recoveryPasswordByEmail:(NSString*)email
                      onSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"users/forgotPassword";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"email":email, @"language":[MCLocalization sharedInstance].language};
    
    
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


- (void)getChatListWithToken:(NSString*)token
                   onSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"chat/getChat";
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

- (void)getStaticPageWithAlias:(NSString*)alias
                     onSuccess:(void(^)(NSDictionary *data))success
                     onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"page";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"alias": alias, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)sendChatMessage:(NSString*)message
              withToken:(NSString *)token
              onSuccess:(void(^)(NSDictionary *data))success
              onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"chat/sendMessage";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"message":message, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)editUserProfileWithToken:(NSString*)token
                       andParams:(NSDictionary*)profileParams
                       andImage:(UIImage *)avatarImage
                       OnSuccess:(void(^)(NSDictionary *data))success
                       onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"users/editProfile";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@?token=%@", DOMAIN_API, apiName,token];
    
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"avatartmpimage.png"];
    
    // Save image.
    [UIImagePNGRepresentation(avatarImage) writeToFile:filePath atomically:YES];
    
    NSDictionary *parameters = @{@"token": token, @"users": profileParams, @"language":[MCLocalization sharedInstance].language};
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlAPI parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        [formData appendPartWithFormData:[[NSNumber numberWithInt:imageData.length].stringValue dataUsingEncoding:NSUTF8StringEncoding] name:@"filelength"];
        
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:[NSString stringWithFormat:@"Users\[img_avatar\]"] fileName:@"file.jpg" mimeType:@"image/jpeg]" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      NSLog(@"loading");
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
//                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          
//                          [progressView setProgress:uploadProgress.fractionCompleted];
//                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"%@",error.userInfo);
                          failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
                      } else {
                          NSLog(@"JSON: %@", responseObject);
                          if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
                              failure([responseObject objectForKey:@"error_text"]);
                          else
                              success(responseObject);
                      }
                  }];
    
    [uploadTask resume];
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:urlAPI parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if([[responseObject objectForKey:@"result"] integerValue] == 0)//error
//            failure([responseObject objectForKey:@"error_text"]);
//        else
//            success(responseObject);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        failure([error.userInfo objectForKey:@"NSLocalizedDescription"]);
//    }];
}

- (void)getTournamentsWithToken:(NSString*)token
                      onSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",token);
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

- (void)getHistoryWithToken:(NSString*)token
                  onSuccess:(void(^)(NSDictionary *data))success
                  onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/history";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"language":[MCLocalization sharedInstance].language};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",token);
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

- (void)getAllPrizesByTourID:(NSString*)tourID
                    andToken:(NSString*)token
                   onSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/getAllPrizes";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"id_tour":tourID, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)getTournamentInfoWithToken:(NSString*)token
                         andTourId:(NSString *)tourId
                         onSuccess:(void(^)(NSDictionary *data))success
                         onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/viewLobby";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token, @"id_tour": tourId, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)registerToTournamentWithToken:(NSString*)token
                            andIdTour:(NSString*)tourID
                            onSuccess:(void(^)(NSDictionary *data))success
                            onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/registerToTour";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token,@"id_tour": tourID, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)unregisterToTournamentWithToken:(NSString*)token
                            andIdTour:(NSString*)tourID
                            onSuccess:(void(^)(NSDictionary *data))success
                            onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"tournaments/unregisterToTour";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token,@"id_tour": tourID, @"language":[MCLocalization sharedInstance].language};
    
    
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

- (void)getAllParticipantsWithToken:(NSString*)token
                           andQuery:(NSString*)query
                          andTourID:(NSString*)tourID
                          onSuccess:(void(^)(NSDictionary *data))success
                          onFailure:(void(^)(NSString *error))failure;
{
    NSString* apiName = @"tournaments/getAllParticipants";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token,@"query": query, @"id_tour":tourID, @"language":[MCLocalization sharedInstance].language};
    
//    NSLog(@"%@",urlAPI);
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

//faq
- (void)getFAQ:(NSString*)token
      andQuery:(NSString*)query
     onSuccess:(void(^)(NSDictionary *data))success
     onFailure:(void(^)(NSString *error))failure
{
    NSString* apiName = @"faq";
    NSString* urlAPI = [NSString stringWithFormat:@"%@%@", DOMAIN_API, apiName];
    
    
    NSDictionary *parameters = @{@"token": token,@"query": query, @"language":[MCLocalization sharedInstance].language};
    
    
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
