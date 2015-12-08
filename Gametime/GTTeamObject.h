//
//  GTTeamObject.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveRecord.h"

@interface GTTeamObject : NSManagedObject

@property (strong, nonatomic) NSString *teamName, *teamAbbreviation;

@property (strong, nonatomic) NSData *teamImageData;

@property (nonatomic, readwrite) BOOL teamFantasy;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image;

+ (instancetype)fantasyTeamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image;

@end
