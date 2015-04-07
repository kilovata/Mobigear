//
//  ArticleModel.m
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ArticleModel.h"
#import "Article.h"
#import "Event.h"
#import <AFNetworking/AFNetworking.h>

@implementation ArticleModel


- (NSFetchRequest*)getArticlesRequest {
    
    return [Article MR_requestAllSortedBy:@"idUnique" ascending:YES];
}


- (NSFetchRequest*)getEventsRequest {
    
    return [Event MR_requestAllSortedBy:@"idUnique" ascending:YES];
}


- (void)getArticlesFromServer {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"http://blablabla.com/user" parameters:@{@"token": [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self saveToCoreDataParameters:[responseObject objectForKey:@"result"]];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(articlesDidLoadedComplete)]) {
            [self.delegate articlesDidLoadedComplete];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(articlesLoadFail)]) {
            [self.delegate articlesLoadFail];
        }
    }];
}


- (void)goToEventWithId:(NSNumber*)numberId {
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    [manager POST:[NSString stringWithFormat:@"http://blablabla.com/events/%@", numberId] parameters:@{@"token": [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]} success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [self updateEventWithId:numberId];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(eventGoCompleted)]) {
            [self.delegate eventGoCompleted];
        }
        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(eventGoFail)]) {
//            [self.delegate eventGoFail];
//        }
//    }];
}


- (void)saveToCoreDataParameters:(NSDictionary*)parameters {
    
    NSDictionary *dict = [parameters objectForKey:@"articles"];
    Article *article = [Article MR_findFirstByAttribute:@"idUnique" withValue:[dict objectForKey:@"id"]];
    if (!article) {
        article = [Article MR_createEntity];
        article.idUnique = [parameters objectForKey:@"id"];
    }
    if (![[dict objectForKey:@"title"] isEqual:[NSNull null]]) {
        article.title = [dict objectForKey:@"title"];
    }
    if (![[dict objectForKey:@"body"] isEqual:[NSNull null]]) {
        article.body = [dict objectForKey:@"body"];
    }
    if (![[dict objectForKey:@"image"] isEqual:[NSNull null]]) {
        article.image = [dict objectForKey:@"image"];
    }

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)updateEventWithId:(NSNumber*)numberId {
    
    Event *event = [Event MR_findFirstByAttribute:@"idUnique" withValue:numberId];
    if (event) {
        event.go = @1;
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
