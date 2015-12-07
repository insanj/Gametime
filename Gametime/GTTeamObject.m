//
//  GTTeamObject.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTTeamObject.h"
#import "UIImage+Gametime.h"

@implementation GTTeamObject

@synthesize teamName = _teamName, teamImagePath = _teamImagePath, teamAbbreviation = _teamAbbreviation;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation imagePath:(NSString *)imagePath {
    GTTeamObject *teamObject = [[GTTeamObject alloc] init];
    teamObject.teamName = team;
    teamObject.teamImagePath = imagePath;
    teamObject.teamAbbreviation = abbreviation;
    return teamObject;
}

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image {
    GTTeamObject *teamObject = [[GTTeamObject alloc] init];
    teamObject.teamName = team;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@%@.jpg", [paths firstObject], abbreviation];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
    
    teamObject.teamImagePath = filePath;
    teamObject.teamAbbreviation = abbreviation;
    return teamObject;
}

+ (instancetype)fantasyTeamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image {
    GTTeamObject *teamObject = [GTTeamObject create];
    teamObject.teamName = team;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@%@.jpg", [paths firstObject], abbreviation];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
    
    teamObject.teamImagePath = filePath;
    teamObject.teamAbbreviation = abbreviation;
    return teamObject;
}

/*
+ (instancetype)teamWithDictionaryRepresentation:(NSDictionary *)dictionary {
    GTTeamObject *teamObject = [[GTTeamObject alloc] init];
    teamObject.teamName = dictionary[@"teamName"];
    teamObject.teamImagePath = dictionary[@"teamImage"];
    teamObject.teamAbbreviation = dictionary[@"teamAbbreviation"];
    return teamObject;
}

- (NSDictionary *)dictionaryRepresentation {
    return @{@"teamName" : _teamName,
             @"teamImage" : _teamImagePath,
             @"teamAbbreviation" : _teamAbbreviation};
}
*/

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        return [((GTTeamObject *)object).teamAbbreviation isEqualToString:self.teamAbbreviation];
    }
    
    return NO;
}

@end
