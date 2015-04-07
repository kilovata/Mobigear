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

@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Статьи";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(showProfile)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ArticleCell"];
}


- (void)showProfile {
    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    cell.labelTitle.text = [NSString stringWithFormat:@"Статья номер %li", indexPath.row + 1];
    [cell.imgViewPicture sd_setImageWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/4926446/pic%402x.png"] placeholderImage:[UIImage imageNamed:@"picLoading"] options:SDWebImageRefreshCached];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61.f;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    ArticleCell *articleCell = (ArticleCell*)[tableView cellForRowAtIndexPath:indexPath];
    [articleCell.imgViewPicture sd_cancelCurrentImageLoad];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
