//
//  GTTeamObject.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTTeamObject : NSObject

@property (strong, nonatomic) NSString *teamName, *teamAbbreviation;

@property (strong, nonatomic) UIImage *teamImage;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image;

+ (instancetype)teamWithDictionaryRepresentation:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
