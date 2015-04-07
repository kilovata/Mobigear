//
//  ArticlesViewController.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProfileViewController.h"
#import "ArticleViewController.h"
#import "DataSource.h"
#import "ArticleModel.h"
#import "Article.h"
#import "EventCell.h"
#import "Event.h"

@interface ArticlesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) UISegmentedControl *segment;

@property (strong, nonatomic) DataSource *dataSource;
@property (strong, nonatomic) ArticleModel *articleModel;

- (void)actionSwitchSegment;

@end

@implementation ArticlesViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(showProfile)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"Статьи", @"Мероприятия"]];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(actionSwitchSegment) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    
    [self.table registerNib:[UINib nibWithNibName:@"ArticleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ArticleCell"];
    [self.table registerNib:[UINib nibWithNibName:@"EventCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EventCell"];
    
    self.dataSource = [DataSource new];
    self.articleModel = [ArticleModel new];
    [self.dataSource setupFetchResultsControllerWithRequest:[self.articleModel getArticlesRequest]];
    [self.articleModel getArticlesFromServer];
}


- (void)showProfile {
    
    ProfileViewController *profileVC = [ProfileViewController new];
    [self.navigationController pushViewController:profileVC animated:YES];
}


- (void)actionSwitchSegment {
    
    if (self.segment.selectedSegmentIndex == 0) {
        
        [self.dataSource setupFetchResultsControllerWithRequest:[self.articleModel getArticlesRequest]];
    } else {
        
        [self.dataSource setupFetchResultsControllerWithRequest:[self.articleModel getEventsRequest]];
    }
    [self.table reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.dataSource.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.dataSource.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segment.selectedSegmentIndex == 0) {
        Article *article = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
        ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
        cell.labelTitle.text = article.title;
        [cell.imgViewPicture sd_setImageWithURL:[NSURL URLWithString:article.image] placeholderImage:[UIImage imageNamed:@"picLoading"] options:SDWebImageRefreshCached];
        return cell;
    } else {
        Event *event = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
        EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
        cell.labelTitle.text = event.title;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        cell.labelDate.text = [formatter stringFromDate:event.date];
        [cell.imgViewPicture sd_setImageWithURL:[NSURL URLWithString:event.image] placeholderImage:[UIImage imageNamed:@"picLoading"] options:SDWebImageRefreshCached];
        return cell;
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61.f;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (self.segment.selectedSegmentIndex == 0) {
        ArticleCell *articleCell = (ArticleCell*)[tableView cellForRowAtIndexPath:indexPath];
        [articleCell.imgViewPicture sd_cancelCurrentImageLoad];
    } else {
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.segment.selectedSegmentIndex == 0) {
        
        Article *article = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
        ArticleViewController *articleVC = [[ArticleViewController alloc] initWithArticle:article];
        [self.navigationController pushViewController:articleVC animated:YES];
    } else {
        
        Event *event = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
        ArticleViewController *articleVC = [[ArticleViewController alloc] initWithEvent:event];
        [self.navigationController pushViewController:articleVC animated:YES];
    }
}


#pragma mark - ArticleModelDelegate
- (void)articlesDidLoadedComplete {
    
    [self.dataSource setupFetchResultsControllerWithRequest:[self.articleModel getArticlesRequest]];
    [self.table reloadData];
}


- (void)articlesLoadFail {
    
    
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
