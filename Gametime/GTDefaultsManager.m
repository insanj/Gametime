//
//  GTDefaultsManager.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTDefaultsManager.h"
#import "GTTeamObject.h"

static NSString *kGametimeSavedTeamsDefaultsKey = @"GametimeSavedTeamsDefaultsKey";

@implementation GTDefaultsManager

+ (NSArray *)savedTeams {
    NSArray *savedTeams = [[NSUserDefaults standardUserDefaults] arrayForKey:kGametimeSavedTeamsDefaultsKey];
    if (!savedTeams || savedTeams.count == 0) {
        return @[];
    }
    
    else {
        NSMutableArray *transformedTeams = [NSMutableArray array];
        for (NSDictionary *dict in savedTeams) {
            [transformedTeams addObject:[GTTeamObject teamWithDictionaryRepresentation:dict]];
        }
        
        return transformedTeams;
    }
}

+ (void)deleteSavedTeam:(GTTeamObject *)teamObject {
    NSMutableArray *savedTeams = [NSMutableArray arrayWithArray:[self savedTeams]];
    [savedTeams removeObject:teamObject];
    [self saveTeams:savedTeams];
}

+ (void)addSavedTeam:(GTTeamObject *)teamObject {
    NSMutableArray *savedTeams = [NSMutableArray arrayWithArray:[self savedTeams]];
    [savedTeams addObject:teamObject];
    [self saveTeams:savedTeams];
}

+ (void)saveTeams:(NSArray *)teams {
    if (!teams || teams.count == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:kGametimeSavedTeamsDefaultsKey];
    }
    
    else {
        NSMutableArray *transformedTeams = [NSMutableArray array];
        for (GTTeamObject *team in teams) {
            [transformedTeams addObject:[team dictionaryRepresentation]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:transformedTeams forKey:kGametimeSavedTeamsDefaultsKey];
    }
}

@end
