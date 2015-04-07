//
//  ArticleModel.h
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData+MagicalRecord.h>

@protocol ArticleModelDelegate <NSObject>

@optional
- (void)articlesDidLoadedComplete;
- (void)articlesLoadFail;
- (void)eventGoCompleted;
- (void)eventGoFail;

@end

@interface ArticleModel : NSObject

@property (weak, nonatomic) id<ArticleModelDelegate> delegate;

- (NSFetchRequest*)getArticlesRequest;
- (NSFetchRequest*)getEventsRequest;
- (void)getArticlesFromServer;
- (void)goToEventWithId:(NSNumber*)numberId;

@end
