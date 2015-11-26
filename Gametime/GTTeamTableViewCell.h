//
//  GTTeamTableViewCell.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kGametimeTeamTableViewCellHeight = 70.0;

@interface GTTeamTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *teamAvatarView;

@property (strong, nonatomic) UILabel *teamTitleLabel, *teamDetailLabel;

@end
