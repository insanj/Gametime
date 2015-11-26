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

- (instancetype)initWithFantasyTeam:(GTTeamObject *)team;

- (instancetype)initWithNFLTeam:(GTTeamObject *)team;

@end
