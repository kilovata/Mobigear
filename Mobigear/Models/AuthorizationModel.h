//
//  AuthorizationModel.h
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthorizationModelDelegate <NSObject>

- (void)authorizationDidComplete;
- (void)authorizationDidFail;
- (void)userNoFound;

@end

@interface AuthorizationModel : NSObject

@property (weak, nonatomic) id<AuthorizationModelDelegate> delegate;

- (void)authorizeWithEmail:(NSString*)strEmail andPassword:(NSString*)strPassword;

@end
