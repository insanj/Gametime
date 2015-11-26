//
//  GTMainViewController.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTMainViewController.h"
#import "GTTeamTableViewCell.h"
#import "GTPlaceholderBackgroundView.h"

@interface GTMainViewController ()

@property (strong, nonatomic) NSArray *gameTimeTeams, *gameTimeNFLTeams;

@end

@implementation GTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Gametime";
    self.tableView.rowHeight = 100.0;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[GTTeamTableViewCell class] forCellReuseIdentifier:kGametimeTeamTableCellIdentifier];
    
    GTPlaceholderBackgroundView *placeholderBackgroundView = [[GTPlaceholderBackgroundView alloc] initWithFrame:self.tableView.frame];
    placeholderBackgroundView.placeholderTitleLabel.text = @"Loading Your Teams";
    placeholderBackgroundView.placeholderDetailLabel.text = @"This should only take a moment. Retrieving NFL data from the Fantasy Football API...";
    self.tableView.backgroundView = placeholderBackgroundView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_gameTimeTeams) {
        [self setupGametimeTeams];
    }
    
    if (!_gameTimeNFLTeams) {
        [self setupNFLTeams];
    }
}

#pragma mark - setup

- (void)setupGametimeTeams {
    [self.refreshControl endRefreshing];
}

- (void)setupNFLTeams {
    [self.refreshControl endRefreshing];
}

#pragma mark - actions

- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    [self setupGametimeTeams];
    [self setupNFLTeams];
}

#pragma mark - table view

static NSString *kGametimeTeamTableCellIdentifier = @"GametimeTeamTableCellIdentifier";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _gameTimeTeams && _gameTimeNFLTeams ? 2 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? _gameTimeTeams.count : _gameTimeNFLTeams.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGametimeTableViewCellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Your Teams" : @"NFL Teams";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTeamTableViewCell *teamCell = [tableView dequeueReusableCellWithIdentifier:kGametimeTeamTableCellIdentifier forIndexPath:indexPath];
    return teamCell;
}

@end
