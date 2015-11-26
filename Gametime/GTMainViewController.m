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
#import "GTTeamObject.h"
#import "GTDefaultsManager.h"
#import "GTAddTeamViewController.h"
#import "GTNavigationController.h"

@interface GTMainViewController ()

@property (strong, nonatomic) NSArray *gameTimeTeams, *gameTimeNFLTeams;

@end

@implementation GTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Gametime";
    self.tableView.rowHeight = kGametimeTableViewCellHeight;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[GTTeamTableViewCell class] forCellReuseIdentifier:kGametimeTeamTableCellIdentifier];
    
    GTPlaceholderBackgroundView *placeholderBackgroundView = [[GTPlaceholderBackgroundView alloc] initWithFrame:self.tableView.frame];
    placeholderBackgroundView.placeholderTitleLabel.text = @"Loading Your Teams";
    placeholderBackgroundView.placeholderDetailLabel.text = @"This should only take a moment. Retrieving NFL data from the Fantasy Football API...";
    self.tableView.backgroundView = placeholderBackgroundView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemTapped)];
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
    _gameTimeTeams = [GTDefaultsManager savedTeams];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)setupNFLTeams {
    GTTeamObject *cardinals = [GTTeamObject teamWithName:@"Arizona Cardinals" abbreviation:@"ARI" image:[UIImage imageNamed:@"cardinals"]];
    GTTeamObject *falcons = [GTTeamObject teamWithName:@"Atlanta Falcons" abbreviation:@"ATL" image:[UIImage imageNamed:@"falcons"]];
    GTTeamObject *ravens = [GTTeamObject teamWithName:@"Baltimore Ravens" abbreviation:@"BAL" image:[UIImage imageNamed:@"ravens"]];
    GTTeamObject *bills = [GTTeamObject teamWithName:@"Buffalo Bills" abbreviation:@"BUF" image:[UIImage imageNamed:@"bills"]];
    GTTeamObject *panthers = [GTTeamObject teamWithName:@"Carolina Panthers" abbreviation:@"CAR" image:[UIImage imageNamed:@"panthers"]];
    GTTeamObject *bears = [GTTeamObject teamWithName:@"Chicago Bears" abbreviation:@"CHI" image:[UIImage imageNamed:@"bears"]];
    GTTeamObject *bengals = [GTTeamObject teamWithName:@"Cincinnati Bengals" abbreviation:@"CIN" image:[UIImage imageNamed:@"bengals"]];
    GTTeamObject *browns = [GTTeamObject teamWithName:@"Cleveland Browns" abbreviation:@"CLE" image:[UIImage imageNamed:@"browns"]];
    GTTeamObject *cowboys = [GTTeamObject teamWithName:@"Dallas Cowboys" abbreviation:@"DAL" image:[UIImage imageNamed:@"cowboys"]];
    GTTeamObject *broncos = [GTTeamObject teamWithName:@"Denver Broncos" abbreviation:@"DEN" image:[UIImage imageNamed:@"broncos"]];
    GTTeamObject *lions = [GTTeamObject teamWithName:@"Detroit Lions" abbreviation:@"DET" image:[UIImage imageNamed:@"lions"]];
    GTTeamObject *packers = [GTTeamObject teamWithName:@"Green Bay Packers" abbreviation:@"GB" image:[UIImage imageNamed:@"packers"]];
    GTTeamObject *texans = [GTTeamObject teamWithName:@"Houston Texans" abbreviation:@"HOU" image:[UIImage imageNamed:@"texans"]];
    GTTeamObject *colts = [GTTeamObject teamWithName:@"Indianapolis Colts" abbreviation:@"IND" image:[UIImage imageNamed:@"colts"]];
    GTTeamObject *jaguars = [GTTeamObject teamWithName:@"Jacksonville Jaguars" abbreviation:@"JAX" image:[UIImage imageNamed:@"jaguars"]];
    GTTeamObject *chiefs = [GTTeamObject teamWithName:@"Kansas City Chiefs" abbreviation:@"KC" image:[UIImage imageNamed:@"chiefs"]];
    GTTeamObject *dolphins = [GTTeamObject teamWithName:@"Miami Dolphins" abbreviation:@"MIA" image:[UIImage imageNamed:@"dolphins"]];
    GTTeamObject *vikings = [GTTeamObject teamWithName:@"Minnesota Vikings" abbreviation:@"MIN" image:[UIImage imageNamed:@"vikings"]];
    GTTeamObject *patriots = [GTTeamObject teamWithName:@"New England Patriots" abbreviation:@"NE" image:[UIImage imageNamed:@"patriots"]];
    GTTeamObject *saints = [GTTeamObject teamWithName:@"New Orleans Saints" abbreviation:@"NO" image:[UIImage imageNamed:@"saints"]];
    GTTeamObject *giants = [GTTeamObject teamWithName:@"New York Giants" abbreviation:@"NYG" image:[UIImage imageNamed:@"giants"]];
    GTTeamObject *jets = [GTTeamObject teamWithName:@"New York Jets" abbreviation:@"NYJ" image:[UIImage imageNamed:@"jets"]];
    GTTeamObject *raiders = [GTTeamObject teamWithName:@"Oakland Raiders" abbreviation:@"OAK" image:[UIImage imageNamed:@"raiders"]];
    GTTeamObject *eagles = [GTTeamObject teamWithName:@"Philadelphia Eagles" abbreviation:@"PHI" image:[UIImage imageNamed:@"eagles"]];
    GTTeamObject *steelers = [GTTeamObject teamWithName:@"Pittsburgh Steelers" abbreviation:@"PIT" image:[UIImage imageNamed:@"steelers"]];
    GTTeamObject *chargers = [GTTeamObject teamWithName:@"San Diego Chargers" abbreviation:@"SD" image:[UIImage imageNamed:@"chargers"]];
    GTTeamObject *fortyniners = [GTTeamObject teamWithName:@"San Francisco 49ers" abbreviation:@"SF" image:[UIImage imageNamed:@"fortyniners"]];
    GTTeamObject *seahawks = [GTTeamObject teamWithName:@"Seattle Seahawks" abbreviation:@"SEA" image:[UIImage imageNamed:@"seahawks"]];
    GTTeamObject *rams = [GTTeamObject teamWithName:@"St. Louis Rams" abbreviation:@"STL" image:[UIImage imageNamed:@"rams"]];
    GTTeamObject *buccaneers = [GTTeamObject teamWithName:@"Tampa Bay Buccaneers" abbreviation:@"TB" image:[UIImage imageNamed:@"buccaneers"]];
    GTTeamObject *titans = [GTTeamObject teamWithName:@"Tennessee Titans" abbreviation:@"TEN" image:[UIImage imageNamed:@"titans"]];
    GTTeamObject *redskins = [GTTeamObject teamWithName:@"Washington Redskins" abbreviation:@"WAS" image:[UIImage imageNamed:@"redskins"]];
    
    _gameTimeNFLTeams = @[cardinals, falcons, ravens, bills, panthers, bears, bengals, browns, cowboys, broncos, lions, packers, texans, colts, jaguars, chiefs, dolphins, vikings, patriots, saints, giants, jets, raiders, eagles, steelers, chargers, fortyniners, seahawks, rams, buccaneers, titans, redskins];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - actions

- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    [self setupGametimeTeams];
    [self setupNFLTeams];
}

- (void)addBarButtonItemTapped {
    GTAddTeamViewController *addViewController = [[GTAddTeamViewController alloc] init];
    GTNavigationController *modalNavigationController = [[GTNavigationController alloc] initWithRootViewController:addViewController];
    [self presentViewController:modalNavigationController animated:YES completion:NULL];
}

#pragma mark - table view

static NSString *kGametimeTeamTableCellIdentifier = @"GametimeTeamTableCellIdentifier";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _gameTimeTeams && _gameTimeNFLTeams ? 2 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? MAX(_gameTimeTeams.count, 1) : _gameTimeNFLTeams.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGametimeTableViewCellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Your Teams" : @"NFL Teams";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // fantasy teams
        if (_gameTimeTeams.count == 0) {
            static NSString *teamPlaceholderCellIdentifier = @"GametimePlaceholderCellIdentifier";
            UITableViewCell *placeholderCell = [tableView dequeueReusableCellWithIdentifier:teamPlaceholderCellIdentifier];
            
            if (!placeholderCell) {
                placeholderCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:teamPlaceholderCellIdentifier];
                placeholderCell.textLabel.textAlignment = NSTextAlignmentCenter;
                placeholderCell.textLabel.textColor = [UIColor colorWithWhite:0.6 alpha:0.6];
            }
            
            placeholderCell.textLabel.text = @"+ Add A New Fantasy Team";
            
            return placeholderCell;
        }
        
        else {
            GTTeamTableViewCell *teamCell = [tableView dequeueReusableCellWithIdentifier:kGametimeTeamTableCellIdentifier forIndexPath:indexPath];
            return teamCell;
        }
    }
        
    else { // nfl teams
        GTTeamTableViewCell *teamCell = [tableView dequeueReusableCellWithIdentifier:kGametimeTeamTableCellIdentifier forIndexPath:indexPath];
        GTTeamObject *team = _gameTimeNFLTeams[indexPath.row];
        teamCell.teamAvatarView.image = team.teamImage;
        teamCell.teamTitleLabel.text = team.teamName;
        teamCell.teamDetailLabel.text = [NSString stringWithFormat:@"%@  ", team.teamAbbreviation];
        return teamCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self addBarButtonItemTapped];
    }
}

@end
