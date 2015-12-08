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

@dynamic teamName, teamImageData, teamAbbreviation, teamFantasy;

+ (instancetype)teamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image {
    GTTeamObject *teamObject = [GTTeamObject create];
    teamObject.teamFantasy = NO;
    teamObject.teamName = team;
    teamObject.teamAbbreviation = abbreviation;
    
   // dispatch_sync(dispatch_get_main_queue(), ^{
        teamObject.teamImageData = UIImageJPEGRepresentation(image, 1.0);
    //});

    return teamObject;
}

+ (instancetype)fantasyTeamWithName:(NSString *)team abbreviation:(NSString *)abbreviation image:(UIImage *)image {
    GTTeamObject *teamObject = [GTTeamObject create];
    teamObject.teamFantasy = YES;
    teamObject.teamName = team;
    teamObject.teamAbbreviation = abbreviation;
    
  ///  dispatch_sync(dispatch_get_main_queue(), ^{
        teamObject.teamImageData = UIImageJPEGRepresentation(image, 1.0);
//});
    
    return teamObject;
}

@end
