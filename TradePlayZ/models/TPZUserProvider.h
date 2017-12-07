//
//  TPZUserProvider.h
//  TradePlayZ
//
//  Created by Leonid Minderov on 06.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPZUserProvider : NSObject

@property (nonatomic,retain) NSString* loginProvider;
@property (nonatomic,retain) NSString* loginProviderIdentifier;

@end
