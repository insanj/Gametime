//
//  GTTeamHeaderFooterView.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTeamObject.h"

static CGFloat kGametimeTeamHeaderViewHeight = 130.0;

@interface GTTeamHeaderFooterView : UITableViewHeaderFooterView

@property (strong, nonatomic) GTTeamObject *team;

@property (strong, nonatomic) UIButton *teamWeekButton;

@property (nonatomic, readwrite) NSInteger teamRosterCount;

@end
