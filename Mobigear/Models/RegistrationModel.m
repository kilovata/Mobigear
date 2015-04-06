//
//  RegistrationModel.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "RegistrationModel.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import <CoreData+MagicalRecord.h>

@implementation RegistrationModel


- (void)registrationWithFio:(NSString*)strFio andEmail:(NSString*)strEmail andPhone:(NSString*)strPhone andPassword:(NSString*)strPassword {
    
    [self makeRequestWithLink:@"http://blablabla.com/user" andParameters:@{@"fio": strFio, @"email" : strEmail, @"phone" : strPhone, @"password" : strPassword}];
}


- (void)makeRequestWithLink:(NSString*)link andParameters:(NSDictionary*)parameters {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:link parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
    
        NSString *strToken = [[responseObject objectForKey:@"result"] objectForKey:@"token"];
        strToken = @"fcac1a3b62cb51374123de565dc12e16";
        [[NSUserDefaults standardUserDefaults] setValue:strToken forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self saveToCoreDataParameters:parameters];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(registrationDidComplete)]) {
            [self.delegate registrationDidComplete];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(registrationDidFail)]) {
            [self.delegate registrationDidFail];
        }
    }];
}


- (void)saveToCoreDataParameters:(NSDictionary*)parameters {
    
    User *user = [User MR_createEntity];
    user.fio = [parameters objectForKey:@"fio"];
    user.email = [parameters objectForKey:@"email"];
    user.phone = [parameters objectForKey:@"phone"];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
