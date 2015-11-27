//
//  GTTeamViewController.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "GTTeamObject.h"

@interface GTTeamViewController : UITableViewController

@property (nonatomic, readwrite) NSInteger teamSeasonWeekNumber; // 2015, 0 means all season long

- (instancetype)initWithFantasyTeam:(GTTeamObject *)team;

- (instancetype)initWithNFLTeam:(GTTeamObject *)team;

@end
