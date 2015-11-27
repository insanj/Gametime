//
//  GTTeamHeaderFooterView.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTTeamHeaderFooterView.h"
#import "CompactConstraint.h"
#import "UIImageView+WebCache.h"

@interface GTTeamHeaderFooterView ()

@property (strong, nonatomic) UIImageView *teamAvatarImageView;

@property (strong, nonatomic) UILabel *teamTitleLabel, *teamDetailLabel;

@end

@implementation GTTeamHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIView *clearView = [[UIView alloc] init];
        clearView.backgroundColor = [UIColor clearColor];
        self.backgroundView = clearView;
        self.contentView.backgroundColor = [UIColor clearColor];

        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:blurView];
        
        UIView *separatorView = [[UIView alloc] init];
        separatorView.translatesAutoresizingMaskIntoConstraints = NO;
        separatorView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
        [self.contentView addSubview:separatorView];
        
        [self.contentView addCompactConstraints:@[@"blur.left = super.left",
                                                  @"blur.right = super.right",
                                                  @"blur.top = super.top",
                                                  @"blur.bottom = super.bottom",
                                                  
                                                  @"separator.height = 1",
                                                  @"separator.left = super.left",
                                                  @"separator.right = super.right",
                                                  @"separator.bottom = super.bottom"]
                                        metrics:nil
                                          views:@{@"blur": blurView,
                                                  @"separator" : separatorView}];
        
        CGFloat imageWidth = 100.0;
        _teamAvatarImageView = [[UIImageView alloc] init];
        _teamAvatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _teamAvatarImageView.layer.masksToBounds = YES;
        _teamAvatarImageView.layer.cornerRadius = imageWidth / 2.0;
        _teamAvatarImageView.layer.borderWidth = 1.0;
        _teamAvatarImageView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
        [blurView.contentView addSubview:_teamAvatarImageView];
        
        _teamTitleLabel = [[UILabel alloc] init];
        _teamTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamTitleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:20.0];
        _teamTitleLabel.numberOfLines = 1;
        _teamTitleLabel.textColor = [UIColor blackColor];
        [blurView.contentView addSubview:_teamTitleLabel];
        
        _teamDetailLabel = [[UILabel alloc] init];
        _teamDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamDetailLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium];
        _teamDetailLabel.numberOfLines = 1;
        _teamDetailLabel.textColor = [UIColor blackColor];
        [blurView.contentView addSubview:_teamDetailLabel];
        
        _teamWeekButton = [[UIButton alloc] init];
        _teamWeekButton.translatesAutoresizingMaskIntoConstraints = NO;
        _teamWeekButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
        [_teamWeekButton setTitleColor:[UIColor colorWithRed:0.182f green:0.613f blue:0.312f alpha:1.00f] forState:UIControlStateNormal];
        [_teamWeekButton setTitle:@"Full Season" forState:UIControlStateNormal];
        [blurView.contentView addSubview:_teamWeekButton];
        
        [blurView.contentView addCompactConstraints:@[@"image.left = super.left + 15",
                                                  @"image.top = super.top + 15",
                                                  @"image.width = imageWidth",
                                                  @"image.height = imageWidth",
                                                  
                                                  @"title.left = image.right + 15",
                                                  @"title.top = super.top + 30",
                                                  @"title.right = super.right - 10",
                                                  
                                                  @"detail.left = image.right + 15",
                                                  @"detail.top = title.bottom",
                                                  @"detail.right = super.right - 10",
                                                  
                                                  @"button.left = image.right + 10",
                                                  @"button.right = super.right - 15",
                                                  @"button.bottom = super.bottom - 15"]
                                        metrics:@{@"imageWidth" : @(imageWidth)}
                                          views:@{@"image" : _teamAvatarImageView,
                                                  @"title" : _teamTitleLabel,
                                                  @"detail" : _teamDetailLabel,
                                                  @"button" : _teamWeekButton}];
    }
    
    return self;
}

- (void)setTeam:(GTTeamObject *)team {
    _team = team;
    
    _teamAvatarImageView.image = team.teamImage;
    
    //UIView *backgroundView = [[UIView alloc] init];
    //backgroundView.backgroundColor = [[self averageColorInImage:_team.teamImage] colorWithAlphaComponent:0.8];
    //self.backgroundView = backgroundView;
    
    _teamTitleLabel.text = team.teamName;
    
    if (_teamRosterCount > 0) {
        _teamDetailLabel.text = [NSString stringWithFormat:@"%@     %@ Players", team.teamAbbreviation, [NSNumberFormatter localizedStringFromNumber:@(_teamRosterCount) numberStyle:NSNumberFormatterDecimalStyle]];
    }
    
    else {
        _teamDetailLabel.text = team.teamAbbreviation;
    }
}

/*
// http://stackoverflow.com/questions/13694618/objective-c-getting-least-used-and-most-used-color-in-a-image/13695592#13695592
- (UIColor *)averageColorInImage:(UIImage *)image {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}
*/

@end
