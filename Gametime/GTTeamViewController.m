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
#import "GTTeamHeaderFooterView.h"

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
    
    // self.refreshControl = [[UIRefreshControl alloc] init];
    // [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[GTPlayerTableViewCell class] forCellReuseIdentifier:kGametimePlayerCellIdentifier];
    [self.tableView registerClass:[GTTeamHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kGametimeTeamHeaderViewIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.refreshControl endRefreshing];

    if (!_teamPlayers) {
        [self setupFantasyData];
    }
}

#pragma mark - actions

- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    [self setupFantasyData];
}

#pragma mark - setup

- (void)setupFantasyData {
    if (_teamIsFantasy) {
        
    }
    
    else if (_teamSeasonWeekNumber == 0) {
        [self setupNFLTeamFantasyData];
    }
    
    else {
        [self setupNFLTeamFantasyWeekData];
    }
}

- (void)setupNFLTeamFantasyWeekData {
    AFHTTPRequestOperationManager *fantasyManager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"ca7eddaffa534c14aa5f62ed822901ab" forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    fantasyManager.requestSerializer = requestSerializer;
    fantasyManager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSString *fantasyQueryString = [NSString stringWithFormat:@"https://api.fantasydata.net/nfl/v2/JSON/PlayerGameStatsByTeam/2015/%i/%@", (int)_teamSeasonWeekNumber, _team.teamAbbreviation];
    [fantasyManager GET:fantasyQueryString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *responseArray = (NSArray *)responseObject;
        NSMutableArray *responsePlayers = [NSMutableArray array], *responseIdentifiers = [NSMutableArray array];
        for (NSDictionary *playerDict in responseArray) {
            GTPlayerObject *player = [GTPlayerObject playerWithDictionaryRepresentation:playerDict];
            [responsePlayers addObject:player];
            [responseIdentifiers addObject:@(player.playerIdentifier)];
        }
        
        for (GTPlayerObject *player in _teamPlayers) {
            if ([responseIdentifiers containsObject:@(player.playerIdentifier)]) {
                NSInteger indexOfNewPlayerThatNeedsMerging = [responseIdentifiers indexOfObject:@(player.playerIdentifier)];
                GTPlayerObject *newPlayer = responsePlayers[indexOfNewPlayerThatNeedsMerging];
                [newPlayer mergeWithPlayer:player];
                responsePlayers[indexOfNewPlayerThatNeedsMerging] = newPlayer;
            }
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

static NSString *kGametimePlayerCellIdentifier = @"GametimePlayerCellIdentifier", *kGametimeTeamHeaderViewIdentifier = @"GametimeTeamHeaderIdentifier";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _teamPlayers ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _teamPlayers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kGametimeTeamHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GTTeamHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kGametimeTeamHeaderViewIdentifier];
    
    [headerView.teamWeekButton removeTarget:self action:@selector(teamWeekButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.teamWeekButton addTarget:self action:@selector(teamWeekButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_teamSeasonWeekNumber == 0) {
        [headerView.teamWeekButton setTitle:@"Full Season" forState:UIControlStateNormal];
    }
    
    else {
        [headerView.teamWeekButton setTitle:[NSString stringWithFormat:@"Week %@", @(_teamSeasonWeekNumber)] forState:UIControlStateNormal];
    }
    
    headerView.teamRosterCount = _teamPlayers.count;
    headerView.team = _team;

    return headerView;
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

- (void)teamWeekButtonTapped:(UIButton *)sender {
    UIAlertController *weekController = [UIAlertController alertControllerWithTitle:@"Week" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    weekController.popoverPresentationController.sourceView = sender;
    weekController.popoverPresentationController.sourceRect = CGRectMake(sender.frame.size.width / 2.0, sender.frame.size.height / 2.0, 1.0, 1.0);
    
    for (NSInteger i = 1; i < 17; i++) {
        [weekController addAction:[UIAlertAction actionWithTitle:[@"Week " stringByAppendingString:@(i).description] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _teamSeasonWeekNumber = i;
            [self setupFantasyData];
        }]];
    }
    
    [weekController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:weekController animated:YES completion:NULL];
}

@end
