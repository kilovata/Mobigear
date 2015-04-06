//
//  ArticlesViewController.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleCell.h"

@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Профиль" style:UIBarButtonItemStylePlain target:self action:@selector(showProfile)];
    
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
    cell.labelTitle.text = [NSString stringWithFormat:@"Title %li", indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
