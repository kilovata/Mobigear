//
//  ArticleViewController.m
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ArticleViewController.h"
#import "Article.h"
#import "Event.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ArticleModel.h"

@interface ArticleViewController ()<ArticleModelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPicture;
@property (weak, nonatomic) IBOutlet UIWebView *web;

@property (strong, nonatomic) Article *article;
@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) ArticleModel *articleModel;

@end

@implementation ArticleViewController


- (id)initWithArticle:(Article*)article {
    
    if (self == [super init]) {
        
        self.article = article;
    }
    return self;
}


- (id)initWithEvent:(Event*)event {
    
    if (self == [super init]) {
        
        self.event = event;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.article) {
        
        self.labelTitle.text = self.article.title;
        self.labelDate.hidden = YES;
        if (self.article.image) {
            [self.imgViewPicture sd_setImageWithURL:[NSURL URLWithString:self.article.image] placeholderImage:[UIImage imageNamed:@"picLoading"] options:SDWebImageRefreshCached];
        }
        [self.web loadHTMLString:self.article.body baseURL:nil];
    } else if (self.event) {
        
        if (![self.event.go boolValue]) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Хочу пойти!"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(goToEvent)];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Зарегистрировался"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:nil
                                                                                     action:nil];
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        
        
        self.labelTitle.text = self.event.title;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        self.labelDate.text = [formatter stringFromDate:self.event.date];
        if (self.event.image) {
            [self.imgViewPicture sd_setImageWithURL:[NSURL URLWithString:self.event.image] placeholderImage:[UIImage imageNamed:@"picLoading"] options:SDWebImageRefreshCached];
        }
        [self.web loadHTMLString:self.event.body baseURL:nil];
    }
}


- (void)goToEvent {
    
    if (!self.articleModel) {
        self.articleModel = [ArticleModel new];
        self.articleModel.delegate = self;
    }
    
    [self.articleModel goToEventWithId:self.event.idUnique];
}


#pragma mark - ArticleModelDelegate
- (void)eventGoCompleted {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Зарегистрировался"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


- (void)eventGoFail {
    
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
