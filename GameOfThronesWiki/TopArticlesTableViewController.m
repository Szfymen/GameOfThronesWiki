//
//  TopArticlesTableViewController.m
//  GameOfThronesWiki
//
//  Created by Mateusz Tylman on 25/10/15.
//  Copyright © 2015 Mateusz Tylman. All rights reserved.
//

#import "TopArticlesTableViewController.h"
#import "ArticleTableViewCell.h"

@interface TopArticlesTableViewController ()

@property (strong, nonatomic) NSArray *articleList;

@end

@implementation TopArticlesTableViewController

static CGFloat const CellHeight = 60;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"Article List"];
    
    [self.tableView registerNib:[UINib nibWithNibName:[ArticleTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ArticleTableViewCell reuseIdentifier]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:CellHeight];
    
    [self getArticleList];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList ? [self.articleList count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ArticleTableViewCell reuseIdentifier] forIndexPath:indexPath];
    ArticleModel *model = [self.articleList objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = model.title;
    cell.abstractLabel.text = model.abstract;
    
    return cell;
}

#pragma mark - Download Data
- (void)getArticleList {
    [[NetworkManager sharedInstance] getTopArticlesWithLimit:75 categoryType:@"Characters" withCompletionHandler:^(NSArray *articleList) {
        self.articleList = articleList;
        [self.tableView reloadData];
    }];
}

@end
