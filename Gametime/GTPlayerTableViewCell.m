//
//  GTPlayerTableViewCell.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTPlayerTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CompactConstraint.h"

@interface GTPlayerTableViewCell ()

@property (strong, nonatomic) UIImageView *playerImageView;

@property (strong, nonatomic) UILabel *playerNameLabel, *playerPositionLabel;

@property (strong, nonatomic) UILabel *playerInfoLabel, *playerPointsString;

@property (strong, nonatomic) UILabel *playerUpcomingLabel;

@end

@implementation GTPlayerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.preservesSuperviewLayoutMargins = NO;
        self.layoutMargins = self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CGFloat imageViewHeight = 50.0
        ;
        _playerImageView = [[UIImageView alloc] init];
        _playerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _playerImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _playerImageView.layer.masksToBounds = YES;
        _playerImageView.layer.cornerRadius = imageViewHeight / 2.0;
        _playerImageView.layer.borderWidth = 1.0;
        _playerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_playerImageView];
        
        _playerNameLabel = [[UILabel alloc] init];
        _playerNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _playerNameLabel.textAlignment = NSTextAlignmentLeft;
        _playerNameLabel.numberOfLines = 1;
        _playerNameLabel.textColor = [UIColor blackColor];
        _playerNameLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
        [self.contentView addSubview:_playerNameLabel];
        
        _playerPositionLabel = [[UILabel alloc] init];
        _playerPositionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _playerPositionLabel.textAlignment = NSTextAlignmentRight;
        _playerPositionLabel.numberOfLines = 1;
        _playerPositionLabel.textColor = [UIColor darkGrayColor];
        _playerPositionLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        [self.contentView addSubview:_playerPositionLabel];
        
        _playerInfoLabel = [[UILabel alloc] init];
        _playerInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _playerInfoLabel.textAlignment = NSTextAlignmentLeft;
        _playerInfoLabel.numberOfLines = 1;
        _playerInfoLabel.textColor = [UIColor darkGrayColor];
        _playerInfoLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        [self.contentView addSubview:_playerInfoLabel];

        _playerPointsString = [[UILabel alloc] init];
        _playerPointsString.translatesAutoresizingMaskIntoConstraints = NO;
        _playerPointsString.textAlignment = NSTextAlignmentRight;
        _playerPointsString.numberOfLines = 1;
        _playerPointsString.textColor = [UIColor darkGrayColor];
        _playerPointsString.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        [self.contentView addSubview:_playerPointsString];
        
        _playerUpcomingLabel = [[UILabel alloc] init];
        _playerUpcomingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _playerUpcomingLabel.textAlignment = NSTextAlignmentLeft;
        _playerUpcomingLabel.numberOfLines = 1;
        _playerUpcomingLabel.textColor = [UIColor darkGrayColor];
        _playerUpcomingLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
        [self.contentView addSubview:_playerUpcomingLabel];
        
        [self.contentView addCompactConstraints:@[@"image.left = super.left + 15",
                                                  @"image.width = imageWidth",
                                                  @"image.height = imageWidth",
                                                  @"image.centerY = super.centerY",
                                                  
                                                  @"name.left = image.right + 10",
                                                  @"name.top = super.top + 10",
                                                  @"name.right = position.left - 5",
                                                  
                                                  @"position.right = super.right - 15",
                                                  @"position.top = super.top + 5",
                                                  
                                                  @"info.top = name.bottom",
                                                  @"info.left = name.left",
                                                  @"info.right = points.left - 5",
                                                  
                                                  @"points.right = super.right - 15",
                                                  @"points.top = info.top",
                                                  
                                                  @"upcoming.left = info.left",
                                                  @"upcoming.top = info.bottom",
                                                  @"upcoming.right = super.right - 10",]
                                        metrics:@{@"imageWidth" : @(imageViewHeight)}
                                          views:@{@"image" : _playerImageView,
                                                  @"name" : _playerNameLabel,
                                                  @"position" : _playerPositionLabel,
                                                  @"info" : _playerInfoLabel,
                                                  @"points" : _playerPointsString,
                                                  @"upcoming" : _playerUpcomingLabel}];
    }
    
    return self;
}

- (void)setPlayer:(GTPlayerObject *)player {
    _player = player;
    
    [_playerImageView sd_setImageWithURL:[NSURL URLWithString:_player.playerPhotoURL] placeholderImage:nil];
    
    _playerNameLabel.text = [NSString stringWithFormat:@"%@ #%@", _player.playerFullName, @(_player.playerNumber)];
    _playerPositionLabel.text = _player.playerPositionName;
    
    _playerInfoLabel.text = [NSString stringWithFormat:@"%@, %@", _player.playerStatusString.uppercaseString, _player.playerExperienceString];
    
    _playerPointsString.text = [NSString stringWithFormat:@"%@", [NSNumberFormatter localizedStringFromNumber:@(_player.playerFantasyPoints) numberStyle:NSNumberFormatterDecimalStyle]];

    if (_player.playerUpcomingOpponentPositionRank) {
        _playerUpcomingLabel.text  = [NSString stringWithFormat:@"WEEK %@ vs %@ (RANK %@ AGAINST)", @(_player.playerUpcomingGameWeek), _player.playerUpcomingGameOpponent, @(_player.playerUpcomingOpponentPositionRank)];
    }
    
    else if (_player.playerUpcomingOpponentRank){
        _playerUpcomingLabel.text  = [NSString stringWithFormat:@"WEEK %@ vs %@ (RANK %@)", @(_player.playerUpcomingGameWeek), _player.playerUpcomingGameOpponent, @(_player.playerUpcomingOpponentRank)];
    }
    
    else {
        _playerUpcomingLabel.text  = [NSString stringWithFormat:@"WEEK %@ vs %@", @(_player.playerUpcomingGameWeek), _player.playerUpcomingGameOpponent];
    }
}

@end
