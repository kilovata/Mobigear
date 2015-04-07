//
//  TestModel.m
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "TestModel.h"
#import <CoreData+MagicalRecord.h>
#import "Article.h"
#import "Event.h"
#import "User.h"

@implementation TestModel


- (void)initEntities {
    
    User *user = [User MR_findFirstByAttribute:@"email" withValue:@"pupkin@blablabla.com"];
    if (!user) {
        user = [User MR_createEntity];
        user.fio = @"Пупкин Иван Иваныч";
        user.email = @"pupkin@email";
        user.phone = @"+79269101010";
        user.avatar = @"https://dl.dropboxusercontent.com/u/4926446/avatarPupkin%402x.png";
    }
    
    for (int i=0; i<30; i++) {
        
        Article *article = [Article MR_findFirstByAttribute:@"idUnique" withValue:@(i+1)];
        if (!article) {
            article = [Article MR_createEntity];
            article.idUnique = @(i+1);
            article.title = [NSString stringWithFormat:@"Заголовок статьи %i", i];
            article.image = @"https://dl.dropboxusercontent.com/u/4926446/pic%402x.png";
            article.body = @"<html><body><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p></body></html>";
        }
    }
    
    for (int i=0; i<30; i++) {
        
        Event *event = [Event MR_findFirstByAttribute:@"idUnique" withValue:@(i+1)];
        if (!event) {
            event = [Event MR_createEntity];
            event.idUnique = @(i+1);
            event.title = [NSString stringWithFormat:@"Мероприятие %i", i];
            event.date = [NSDate date];
            event.image = @"https://dl.dropboxusercontent.com/u/4926446/pic%402x.png";
            event.body = @"<html><body><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p></body></html>";
        }
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
