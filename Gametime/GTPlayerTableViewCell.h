//
//  GTPlayerTableViewCell.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTPlayerObject.h"

static CGFloat kGametimePlayerTableViewCellHeight = 70.0;

@interface GTPlayerTableViewCell : UITableViewCell

@property (strong, nonatomic) GTPlayerObject *player;

@end
