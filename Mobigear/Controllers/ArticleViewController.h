//
//  ArticleViewController.h
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article, Event;

@interface ArticleViewController : UIViewController

- (id)initWithArticle:(Article*)article;
- (id)initWithEvent:(Event*)event;

@end
