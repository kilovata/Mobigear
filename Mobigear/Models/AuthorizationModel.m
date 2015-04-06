//
//  AuthorizationModel.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "AuthorizationModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation AuthorizationModel


- (void)authorizeWithEmail:(NSString*)strEmail andPassword:(NSString*)strPassword {
    
    [self makeRequestWithLink:@"http://blablabla.com/auth" andParameters:@{@"email" : strEmail, @"password" : strPassword}];
}


- (void)makeRequestWithLink:(NSString*)link andParameters:(NSDictionary*)parameters {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:link parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self saveToCoreData:responseObject];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizationDidComplete)]) {
            [self.delegate authorizationDidComplete];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizationDidFail)]) {
            [self.delegate authorizationDidFail];
        }
    }];
}


- (void)saveToCoreData:(id)responseObject {
    
//    NSArray *array = [responseObject objectForKey:@"collection"];
//    for (int i=0; i<array.count; i++) {
//        
//        NSDictionary *obj = array[i];
//        Article *article = [Article MR_findFirstByAttribute:@"idArticle" withValue:[obj objectForKey:@"id"]];
//        if (!article) {
//            article = [Article MR_createEntity];
//        }
//        if (![[obj objectForKey:@"created_at"] isEqual:[NSNull null]]) {
//            article.created_at = [obj objectForKey:@"created_at"];
//        }
//        if (![[obj objectForKey:@"href"] isEqual:[NSNull null]]) {
//            article.href = [obj objectForKey:@"href"];
//        }
//        if (![[obj objectForKey:@"id"] isEqual:[NSNull null]]) {
//            article.idArticle = [obj objectForKey:@"id"];
//        }
//        if (![[obj objectForKey:@"preview"] isEqual:[NSNull null]]) {
//            article.preview = [obj objectForKey:@"preview"];
//        }
//        if (![[obj objectForKey:@"published_at"] isEqual:[NSNull null]]) {
//            article.published_at = [obj objectForKey:@"published_at"];
//        }
//        if (![[obj objectForKey:@"summary"] isEqual:[NSNull null]]) {
//            article.summary = [obj objectForKey:@"summary"];
//        }
//        if (![[obj objectForKey:@"title"] isEqual:[NSNull null]]) {
//            article.title = [obj objectForKey:@"title"];
//        }
//        if (![[obj objectForKey:@"type"] isEqual:[NSNull null]]) {
//            article.type = [obj objectForKey:@"type"];
//        }
//        if (![[obj objectForKey:@"origin"] isEqual:[NSNull null]]) {
//            article.origin = [obj objectForKey:@"origin"];
//        }
//        if (![[obj objectForKey:@"video_id"] isEqual:[NSNull null]]) {
//            article.video_id = [obj objectForKey:@"video_id"];
//        }
//        if (![[obj objectForKey:@"video_vendor"] isEqual:[NSNull null]]) {
//            article.video_vendor = [obj objectForKey:@"video_vendor"];
//        }
//        if (![[obj objectForKey:@"video_id"] isEqual:[NSNull null]]) {
//            article.video_id = [obj objectForKey:@"video_id"];
//        }
//        if (self.deviceCategory) {
//            article.deviceCategory = self.deviceCategory;
//        }
//        
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    }
}


@end
