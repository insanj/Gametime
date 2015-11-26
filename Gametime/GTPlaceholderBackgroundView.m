//
//  GTPlaceholderBackgroundView.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTPlaceholderBackgroundView.h"
#import "CompactConstraint.h"

@implementation GTPlaceholderBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _placeholderTitleLabel = [[UILabel alloc] init];
        _placeholderTitleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:0.8];
        _placeholderTitleLabel.numberOfLines = 0;
        _placeholderTitleLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderTitleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:20.0];
        _placeholderTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_placeholderTitleLabel];
        
        _placeholderDetailLabel = [[UILabel alloc] init];
        _placeholderDetailLabel.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        _placeholderDetailLabel.numberOfLines = 0;
        _placeholderDetailLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderDetailLabel.font = [UIFont systemFontOfSize:16.0];
        _placeholderDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_placeholderDetailLabel];
        
        [self addCompactConstraints:@[@"title.bottom = super.centerY",
                                      @"title.left = super.left + 10",
                                      @"title.right = super.right - 10",
                                      
                                      @"detail.top = super.centerY",
                                      @"detail.left = super.left + 10",
                                      @"detail.right = super.right - 10"]
                            metrics:nil
                              views:@{@"title" : _placeholderTitleLabel,
                                      @"detail" : _placeholderDetailLabel}];
    }
    
    return self;
}

@end
