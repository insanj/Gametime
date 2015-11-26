//
//  GTDefaultsManager.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTeamObject.h"

@interface GTDefaultsManager : NSObject

+ (NSArray *)savedTeams;

+ (void)deleteSavedTeam:(GTTeamObject *)teamObject;

+ (void)addSavedTeam:(GTTeamObject *)teamObject;

@end
