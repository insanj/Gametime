//
//  GTTeamViewController.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTTeamViewController.h"
#import "GTPlaceholderBackgroundView.h"
#import "CompactConstraint.h"
#import "GTPlayerObject.h"
#import "GTPlayerTableViewCell.h"

@interface GTTeamViewController ()

@property (nonatomic, readwrite) BOOL teamIsFantasy;

@property (strong, nonatomic) GTTeamObject *team;

@property (strong, nonatomic) NSArray *teamPlayers;

@end

@implementation GTTeamViewController

- (instancetype)initWithFantasyTeam:(GTTeamObject *)team {
    self = [super init];
    
    if (self) {
        _teamIsFantasy = YES;
        _team = team;
    }
    
    return self;
}

- (instancetype)initWithNFLTeam:(GTTeamObject *)team {
    self = [super init];
    
    if (self) {
        _teamIsFantasy = NO;
        _team = team;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Team";
    self.tableView.rowHeight = 70.0;
    self.tableView.tableFooterView = [UIView new];
    
    GTPlaceholderBackgroundView *placeholderBackgroundView = [[GTPlaceholderBackgroundView alloc] initWithFrame:self.tableView.frame];
    placeholderBackgroundView.placeholderTitleLabel.text = [@"Loading the " stringByAppendingString:_team.teamName];
    placeholderBackgroundView.placeholderDetailLabel.text = @"This should only take a moment. Retrieving NFL data from the Fantasy Football API...";
    self.tableView.backgroundView = placeholderBackgroundView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[GTPlayerTableViewCell class] forCellReuseIdentifier:kGametimePlayerCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.refreshControl endRefreshing];

    if (!_teamIsFantasy && !_teamPlayers) {
        [self setupNFLTeamFantasyData];
    }
}

#pragma mark - actions

- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    [self setupNFLTeamFantasyData];
}

#pragma mark - setup

- (void)setupNFLTeamFantasyData {
    AFHTTPRequestOperationManager *fantasyManager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"ca7eddaffa534c14aa5f62ed822901ab" forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    fantasyManager.requestSerializer = requestSerializer;
    fantasyManager.responseSerializer = [AFJSONResponseSerializer serializer];

    [fantasyManager GET:[@"https://api.fantasydata.net/nfl/v2/JSON/Players/" stringByAppendingString:_team.teamAbbreviation] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *responseArray = (NSArray *)responseObject;
        NSMutableArray *responsePlayers = [NSMutableArray array];
        for (NSDictionary *playerDict in responseArray) {
            [responsePlayers addObject:[GTPlayerObject playerWithDictionaryRepresentation:playerDict]];
        }
        
        _teamPlayers = responsePlayers;
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        _teamPlayers = nil;
        
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Team Loading Failed" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        errorAlert.popoverPresentationController.sourceView = self.view;
        errorAlert.popoverPresentationController.sourceRect = CGRectMake(self.view.center.x, self.view.center.y, 1.0, 1.0);
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [self presentViewController:errorAlert animated:YES completion:NULL];
        
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - table view

static NSString *kGametimePlayerCellIdentifier = @"GametimePlayerCellIdentifier";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _teamPlayers ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _teamPlayers.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTPlayerTableViewCell *playerCell = [tableView dequeueReusableCellWithIdentifier:kGametimePlayerCellIdentifier forIndexPath:indexPath];
    playerCell.player = _teamPlayers[indexPath.row];
    return playerCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
