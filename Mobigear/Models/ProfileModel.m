//
//  ProfileModel.m
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ProfileModel.h"
#import "User.h"
#import <CoreData+MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>

@interface ProfileModel()

@property (strong, nonatomic) User *currentUser;

@end


@implementation ProfileModel


- (User*)currentUser {
    
    return [User MR_findFirst];
}


- (NSString*)getFio {
    
    return self.currentUser.fio;
}


- (NSString*)getEmail {
    
    return self.currentUser.email;
}


- (NSString*)getPhone {
    
    return self.currentUser.phone;
}


- (NSString*)getAvatar {
    
    return self.currentUser.avatar;
}


- (void)getProfile {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"http://blablabla.com/user" parameters:@{@"token": [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self saveToCoreDataParameters:[responseObject objectForKey:@"result"]];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(profileLoadFromServer)]) {
            [self.delegate profileLoadFromServer];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)updateProfileWithFio:(NSString*)strFio andEmail:(NSString*)strEmail andPhone:(NSString*)strPhone andAvatar:(NSString*)strAvatar {
    
    [self makeRequestWithLink:@"http://blablabla.com/user" andParameters:@{@"fio": strFio, @"email" : strEmail, @"phone" : strPhone, @"avatar" : strAvatar}];
}


- (void)makeRequestWithLink:(NSString*)link andParameters:(NSDictionary*)parameters {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:link parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [self saveToCoreDataParameters:[responseObject objectForKey:@"result"]];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(profileDidUpdateComplete)]) {
            [self.delegate profileDidUpdateComplete];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(profileDidUpdateFail)]) {
            [self.delegate profileDidUpdateFail];
        }
    }];
}


- (void)saveToCoreDataParameters:(NSDictionary*)parameters {
    
    NSDictionary *dictUser = [parameters objectForKey:@"user"];
    User *user = [User MR_findFirst];
    if (![[dictUser objectForKey:@"fio"] isEqual:[NSNull null]]) {
        user.fio = [dictUser objectForKey:@"fio"];
    }
    if (![[dictUser objectForKey:@"email"] isEqual:[NSNull null]]) {
        user.email = [dictUser objectForKey:@"email"];
    }
    if (![[dictUser objectForKey:@"phone"] isEqual:[NSNull null]]) {
        user.phone = [dictUser objectForKey:@"phone"];
    }
    if (![[dictUser objectForKey:@"avatar"] isEqual:[NSNull null]]) {
        user.avatar = [dictUser objectForKey:@"avatar"];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
