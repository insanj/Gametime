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

@property (strong, nonatomic) NSString *teamName, *teamAbbreviation, *teamImagePath;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation imagePath:(NSString *)teamImagePath;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)teamImage;

+ (instancetype)fantasyTeamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)teamImage;

// + (instancetype)teamWithDictionaryRepresentation:(NSDictionary *)dictionary;

// - (NSDictionary *)dictionaryRepresentation;

@end
