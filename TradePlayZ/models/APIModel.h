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

//profile
- (void)getUserProfileWithToken:(NSString*)token
                OnSuccess:(void(^)(NSDictionary *data))success
               onFailure:(void(^)(NSString *error))failure;

- (void)editUserProfileWithToken:(NSString*)token
                       andParams:(NSDictionary*)profileParams
                      OnSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure;

-(void)checkExistToken:(NSString*)token
             OnSuccess:(void(^)(NSDictionary *data))success
             onFailure:(void(^)(NSString *error))failure;

- (void)loginWith:(NSDictionary *)user
       andWithUserDevice:(NSDictionary *)userDevice
               onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure;

// tours
- (void)getTournamentsWithToken:(NSString*)token
        onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure;

- (void)getTournamentInfoWithToken:(NSString*)token
                         andTourId:(NSString *)tourId
                         onSuccess:(void(^)(NSDictionary *data))success
                         onFailure:(void(^)(NSString *error))failure;

- (void)getAllPrizesByTourID:(NSString*)tourID
                    andToken:(NSString*)token
                      onSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure;

- (void)getAllParticipantsWithToken:(NSString*)token
          andQuery:(NSString*)query
                            andTourID:(NSString*)tourID
         onSuccess:(void(^)(NSDictionary *data))success
     onFailure:(void(^)(NSString *error))failure;

//bet
- (void)betWithSizing:(NSString*)sizing
           andTypeBet:(NSInteger)betType
                    andToken:(NSString*)token
                   onSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure;

//trade
- (void)getActiveTournamentWithToken:(NSString*)token
            onSuccess:(void(^)(NSDictionary *data))success
            onFailure:(void(^)(NSString *error))failure;

- (void)checkStatusTournamentByID:(NSString*)tourID
                         andToken:(NSString*)token
                           onSuccess:(void(^)(NSDictionary *data))success
                           onFailure:(void(^)(NSString *error))failure;


//regist / unregist to tour
- (void)registerToTournamentWithToken:(NSString*)token
                            andIdTour:(NSString*)tourID
                      onSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure;

- (void)unregisterToTournamentWithToken:(NSString*)token
                            andIdTour:(NSString*)tourID
                            onSuccess:(void(^)(NSDictionary *data))success
                            onFailure:(void(^)(NSString *error))failure;


//faq
- (void)getFAQ:(NSString*)token
                              andQuery:(NSString*)query
                              onSuccess:(void(^)(NSDictionary *data))success
                              onFailure:(void(^)(NSString *error))failure;


//chat
- (void)getChatListWithToken:(NSString*)token
                      onSuccess:(void(^)(NSDictionary *data))success
                      onFailure:(void(^)(NSString *error))failure;

- (void)sendChatMessage:(NSString*)message
              withToken:(NSString *)token
                   onSuccess:(void(^)(NSDictionary *data))success
              onFailure:(void(^)(NSString *error))failure;

//page
- (void)getStaticPageWithAlias:(NSString*)alias
                   onSuccess:(void(^)(NSDictionary *data))success
                   onFailure:(void(^)(NSString *error))failure;


- (void)loginWithNetworkProvider:(TPZUserProvider *)provider
                            andTPZUser:(NSDictionary *)user
                        andWithUserDevice:(NSDictionary *)userDevice
        onSuccess:(void(^)(NSDictionary *data))success
        onFailure:(void(^)(NSString *error))failure;


@end
