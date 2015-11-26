//
//  GTPlayerTableViewCell.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTPlayerTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface GTPlayerTableViewCell ()

@property (strong, nonatomic) UIImageView *playerImageView;

@property (strong, nonatomic) UILabel *playerNameLabel, *playerPositionLabel;

@property (strong, nonatomic) UILabel *playerInfoLabel;

@property (strong, nonatomic) UILabel *playerUpcomingLabel, *playerActiveLabel;

@end

@implementation GTPlayerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

@end
