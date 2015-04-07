//
//  ProfileModel.h
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfileModelDelegate <NSObject>

- (void)profileLoadFromServer;
- (void)profileDidUpdateComplete;
- (void)profileDidUpdateFail;

@end

@interface ProfileModel : NSObject

@property (weak, nonatomic) id<ProfileModelDelegate> delegate;

- (NSString*)getFio;
- (NSString*)getEmail;
- (NSString*)getPhone;
- (NSString*)getAvatar;

- (void)getProfile;
- (void)updateProfileWithFio:(NSString*)strFio andEmail:(NSString*)strEmail andPhone:(NSString*)strPhone andAvatar:(NSString*)strAvatar;

@end
