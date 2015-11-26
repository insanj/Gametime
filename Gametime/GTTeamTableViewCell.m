//
//  GTTeamTableViewCell.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTTeamTableViewCell.h"
#import "CompactConstraint.h"

@interface GTTeamTableViewCell ()

@end

@implementation GTTeamTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat imageViewWidth = kGametimeTeamTableViewCellHeight + 20.0;
        _teamAvatarView = [[UIImageView alloc] init];
        _teamAvatarView.translatesAutoresizingMaskIntoConstraints = NO;
        _teamAvatarView.contentMode = UIViewContentModeScaleAspectFill;
        _teamAvatarView.layer.masksToBounds = YES;
        _teamAvatarView.layer.cornerRadius = 10.0; // imageViewWidth / 2.0;
        [self.contentView addSubview:_teamAvatarView];
        
        _teamTitleLabel = [[UILabel alloc] init];
        _teamTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamTitleLabel.textColor = [UIColor blackColor];
        _teamTitleLabel.font = [UIFont fontWithName:@"AvenirNext" size:16.0];
        _teamTitleLabel.numberOfLines = 1;
        _teamTitleLabel.textAlignment = NSTextAlignmentLeft;
        _teamTitleLabel.adjustsFontSizeToFitWidth = YES;
        _teamTitleLabel.minimumScaleFactor = 0.8;
        _teamTitleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:_teamTitleLabel];
        
        _teamDetailLabel = [[UILabel alloc] init];
        _teamDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamDetailLabel.textColor = [UIColor darkGrayColor];
        _teamDetailLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        _teamDetailLabel.numberOfLines = 1;
        _teamDetailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_teamDetailLabel];
        
        [self.contentView addCompactConstraints:@[@"avatar.left = super.left + 15",
                                                  @"avatar.top = super.top + 5",
                                                  @"avatar.bottom = super.bottom - 5",
                                                  @"avatar.width = imageViewWidth",
                                                  
                                                  @"title.left = avatar.right + 15",
                                                  @"title.right = super.right - 15",
                                                  @"title.bottom = super.centerY",
                                                  
                                                  @"detail.left = avatar.right + 15",
                                                  @"detail.right = super.right - 15",
                                                  @"detail.top = super.centerY"]
                                        metrics:@{@"imageViewWidth" : @(imageViewWidth)}
                                          views:@{@"avatar" : _teamAvatarView,
                                                  @"title" : _teamTitleLabel,
                                                  @"detail" : _teamDetailLabel}];
    }
    
    return self;
}

@end
