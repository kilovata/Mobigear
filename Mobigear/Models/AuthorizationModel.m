//
//  AuthorizationModel.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "AuthorizationModel.h"
#import <AFNetworking/AFNetworking.h>
#import <CoreData+MagicalRecord.h>
#import "User.h"

@implementation AuthorizationModel


- (void)authorizeWithEmail:(NSString*)strEmail andPassword:(NSString*)strPassword {
    
    if ([User MR_findFirstByAttribute:@"email" withValue:strEmail]) {
        [self makeRequestWithLink:@"http://blablabla.com/auth" andParameters:@{@"email" : strEmail, @"password" : strPassword}];
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNoFound)]) {
            [self.delegate userNoFound];
        }
    }
}


- (void)makeRequestWithLink:(NSString*)link andParameters:(NSDictionary*)parameters {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:link parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *strToken = [[responseObject objectForKey:@"result"] objectForKey:@"token"];
        strToken = @"fcac1a3b62cb51374123de565dc12e16";
        [[NSUserDefaults standardUserDefaults] setValue:strToken forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizationDidComplete)]) {
            [self.delegate authorizationDidComplete];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizationDidFail)]) {
            [self.delegate authorizationDidFail];
        }
    }];
}


@end
