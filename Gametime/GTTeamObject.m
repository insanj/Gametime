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


- (void)setTeamImage:(UIImage *)teamImage {
    _teamImage = [teamImage imageWithWidth:300.0];
}

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image {
    GTTeamObject *teamObject = [[GTTeamObject alloc] init];
    teamObject.teamName = team;
    teamObject.teamImage = image;
    teamObject.teamAbbreviation = abbreviation;
    return teamObject;
}

+ (instancetype)teamWithDictionaryRepresentation:(NSDictionary *)dictionary {
    GTTeamObject *teamObject = [[GTTeamObject alloc] init];
    teamObject.teamName = dictionary[@"teamName"];
    
    NSData *savedImageData = dictionary[@"teamImage"];
    teamObject.teamImage = savedImageData ? [UIImage imageWithData:savedImageData] : nil;
    
    teamObject.teamAbbreviation = dictionary[@"teamAbbreviation"];
    return teamObject;
}

- (NSDictionary *)dictionaryRepresentation {
    if (_teamImage) {
        return @{@"teamName" : _teamName,
                 @"teamImage" : UIImagePNGRepresentation(_teamImage),
                 @"teamAbbreviation" : _teamAbbreviation};
    }
    
    else {
        return @{@"teamName" : _teamName,
                 @"teamAbbreviation" : _teamAbbreviation};
    }
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        return [((GTTeamObject *)object).teamAbbreviation isEqualToString:self.teamAbbreviation];
    }
    
    return NO;
}

@end
