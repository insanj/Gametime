//
//  GTPlayerObject.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTPlayerObject.h"
#import "NSObject+Gametime.h"

@implementation GTPlayerObject

@synthesize playerPhotoURL = _playerPhotoURL, playerTeamAbbreviation = _playerTeamAbbreviation, playerFirstName = _playerFirstName, playerLastName = _playerLastName, playerFullName = _playerFullName, playerPositionName = _playerPositionName, playerStatusString = _playerStatusString, playerCollegeName = _playerCollegeName, playerIdentifier = _playerIdentifier, playerNumber = _playerNumber, playerHeightFeet = _playerHeightFeet, playerHeightInches = _playerHeightInches, playerWeight = _playerWeight, playerExperienceString = _playerExperienceString, playerAge = _playerAge, playerActive = _playerActive, playerByeWeek = _playerByeWeek, playerUpcomingGameWeek = _playerUpcomingGameWeek, playerUpcomingGameOpponent = _playerUpcomingGameOpponent, playerUpcomingOpponentRank = _playerUpcomingOpponentRank, playerUpcomingOpponentPositionRank = _playerUpcomingOpponentPositionRank, playerFantasyPoints = _playerFantasyPoints;

+ (instancetype)playerWithDictionaryRepresentation:(NSDictionary *)dictionary {
    GTPlayerObject *playerObject = [GTPlayerObject create];
    [playerObject safeSetString:dictionary[@"PhotoUrl"] forKey:@"playerPhotoURL"];
    [playerObject safeSetString:dictionary[@"Team"] forKey:@"playerTeamAbbreviation"];
    [playerObject safeSetString:dictionary[@"FirstName"] forKey:@"playerFirstName"];
    [playerObject safeSetString:dictionary[@"LastName"] forKey:@"playerLastName"];
    [playerObject safeSetString:dictionary[@"Name"] forKey:@"playerFullName"];
    [playerObject safeSetString:dictionary[@"Position"] forKey:@"playerPositionName"];
    [playerObject safeSetString:dictionary[@"Status"] forKey:@"playerStatusString"];
    [playerObject safeSetString:dictionary[@"College"] forKey:@"playerCollegeName"];
    
    [playerObject safeSetNumber:dictionary[@"PlayerID"] forKey:@"playerIdentifier"];
    [playerObject safeSetNumber:dictionary[@"Number"] forKey:@"playerNumber"];
    [playerObject safeSetNumber:dictionary[@"HeightFeet"] forKey:@"playerHeightFeet"];
    [playerObject safeSetNumber:dictionary[@"HeightInches"] forKey:@"playerHeightInches"];
    [playerObject safeSetNumber:dictionary[@"Weight"] forKey:@"playerWeight"];
    [playerObject safeSetNumber:dictionary[@"ExperienceString"] forKey:@"playerExperienceString"];
    [playerObject safeSetNumber:dictionary[@"Age"] forKey:@"playerAge"];
    
    if (dictionary[@"Activated"]) {
        [playerObject safeSetNumber:dictionary[@"Activated"] forKey:@"playerActive"];
    }
    
    else {
        [playerObject safeSetNumber:dictionary[@"Active"] forKey:@"playerActive"];
    }

    [playerObject safeSetNumber:dictionary[@"ByeWeek"] forKey:@"playerByeWeek"];
    [playerObject safeSetNumber:dictionary[@"UpcomingGameWeek"] forKey:@"playerUpcomingGameWeek"];
    [playerObject safeSetString:dictionary[@"UpcomingGameOpponent"] forKey:@"playerUpcomingGameOpponent"];
    [playerObject safeSetNumber:dictionary[@"UpcomingOpponentRank"] forKey:@"playerUpcomingOpponentRank"];
    [playerObject safeSetNumber:dictionary[@"UpcomingOpponentPositionRank"] forKey:@"playerUpcomingOpponentPositionRank"];

    NSDictionary *seasonDict = dictionary[@"PlayerSeason"];
    if (seasonDict && ![seasonDict isKindOfClass:[NSNull class]]) {
        [playerObject safeSetNumber:seasonDict[@"FantasyPoints"] forKey:@"playerFantasyPoints"];
    }
    
    else if (dictionary[@"FantasyPoints"]) {
        [playerObject safeSetNumber:dictionary[@"FantasyPoints"] forKey:@"playerFantasyPoints"];
    }
    
    return playerObject;
}

+ (NSDictionary *)mappings {
    return @{@"PhotoUrl": @"playerPhotoURL",
             @"Team": @"playerTeamAbbreviation",
             @"FirstName": @"playerFirstName",
             @"LastName": @"playerLastName",
             @"Name" : @"playerFullName",
             @"Position" : @"playerPositionName",
             @"Status" : @"playerStatusString",
             @"College" : @"playerCollegeName",
             @"ExperienceString" : @"playerExperienceString",

             @"FantasyPoints" : @"playerFantasyPoints",

             @"PlayerID" : @"playerIdentifier",
             @"Number" : @"playerNumber",
             @"HeightFeet" : @"playerHeightFeet",
             @"HeightInches" : @"playerHeightInches",
             @"Weight" : @"playerWeight",
             @"Age" : @"playerAge",
             
             @"Active" : @"playerActive",
             
             @"ByeWeek" : @"playerByeWeek",
             @"UpcomingGameWeek" : @"playerUpcomingGameWeek",
             @"UpcomingGameOpponent" : @"playerUpcomingGameOpponent",
             @"UpcomingOpponentRank" : @"playerUpcomingOpponentRank",
             @"UpcomingOpponentPositionRank" : @"playerUpcomingOpponentPositionRank",
             @"UpcomingGameOpponent" : @"playerUpcomingGameOpponent"};
}

- (NSDictionary *)dictionaryRepresentation {
    return @{@"PhotoUrl" : _playerPhotoURL,
             @"Team" : _playerTeamAbbreviation,
             @"FirstName" : _playerFirstName,
             @"LastName" : _playerLastName,
             @"Name" : _playerFullName,
             @"Position" : _playerPositionName,
             @"Status" : _playerStatusString,
             @"College" : _playerCollegeName,
             @"ExperienceString" : _playerExperienceString,

             @"FantasyPoints" : @(_playerFantasyPoints),
             
             @"PlayerID" : @(_playerIdentifier),
             @"Number" : @(_playerNumber),
             @"HeightFeet" : @(_playerHeightFeet),
             @"HeightInches" : @(_playerHeightInches),
             @"Weight" : @(_playerWeight),
             @"Age" : @(_playerAge),
             
             @"Active" : @(_playerActive),

             @"ByeWeek" : @(_playerByeWeek),
             @"UpcomingGameWeek" : @(_playerUpcomingGameWeek),
             @"UpcomingGameOpponent" : _playerUpcomingGameOpponent,
             @"UpcomingOpponentRank" : @(_playerUpcomingOpponentRank),
             @"UpcomingOpponentPositionRank" : @(_playerUpcomingOpponentPositionRank),
             @"UpcomingGameOpponent" : _playerUpcomingGameOpponent};
}

- (void)mergeWithPlayer:(GTPlayerObject *)player {
    if (self.playerPhotoURL.length == 0) {
        [self safeSetString:player.playerPhotoURL forKey:@"playerPhotoURL"];
    }
    
    // [playerObject safeSetString:dictionary[@"Team"] forKey:@"playerTeamAbbreviation"];
    // [playerObject safeSetString:dictionary[@"FirstName"] forKey:@"playerFirstName"];
    // [playerObject safeSetString:dictionary[@"LastName"] forKey:@"playerLastName"];
    // [playerObject safeSetString:dictionary[@"Name"] forKey:@"playerFullName"];
    // [playerObject safeSetString:dictionary[@"Position"] forKey:@"playerPositionName"];
    
    if (self.playerStatusString.length == 0) {
        [self safeSetString:player.playerStatusString forKey:@"playerStatusString"];
    }

    // [playerObject safeSetString:dictionary[@"College"] forKey:@"playerCollegeName"];
    // [playerObject safeSetNumber:dictionary[@"PlayerID"] forKey:@"playerIdentifier"];
    // [playerObject safeSetNumber:dictionary[@"Number"] forKey:@"playerNumber"];
    // [playerObject safeSetNumber:dictionary[@"HeightFeet"] forKey:@"playerHeightFeet"];
    // [playerObject safeSetNumber:dictionary[@"HeightInches"] forKey:@"playerHeightInches"];
    // [playerObject safeSetNumber:dictionary[@"Weight"] forKey:@"playerWeight"];
    if (self.playerStatusString.length == 0) {
        [self safeSetString:player.playerExperienceString forKey:@"playerExperienceString"];
    }
    
    if (!self.playerAge) {
        [self safeSetNumber:@(player.playerAge) forKey:@"playerAge"];
    }
    
    // [playerObject safeSetNumber:dictionary[@"ByeWeek"] forKey:@"playerByeWeek"];
    
    if (!self.playerUpcomingGameWeek) {
        [self safeSetNumber:@(player.playerUpcomingGameWeek) forKey:@"playerUpcomingGameWeek"];
    }
    
    if (self.playerUpcomingGameOpponent.length == 0) {
        [self safeSetString:player.playerUpcomingGameOpponent forKey:@"playerUpcomingGameOpponent"];
    }
    
    if (!self.playerUpcomingGameOpponent) {
        [self safeSetNumber:@(player.playerUpcomingOpponentRank) forKey:@"playerUpcomingOpponentRank"];
    }
    
    if (!self.playerUpcomingOpponentPositionRank) {
        [self safeSetNumber:@(player.playerUpcomingOpponentPositionRank) forKey:@"playerUpcomingOpponentPositionRank"];
    }    
}

/*
 "PlayerID": 16236,
 "Team": "PHI",
 "Number": 1,
 "FirstName": "Cody",
 "LastName": "Parkey",
 "Position": "K",
 "Status": "Injured Reserve",
 "Height": "6'0\"",
 "Weight": 189,
 "BirthDate": "1992-02-19T00:00:00",
 "College": "Auburn",
 "Experience": 2,
 "FantasyPosition": "K",
 "Active": true,
 "PositionCategory": "ST",
 "Name": "Cody Parkey",
 "Age": 23,
 "ExperienceString": "2nd Season",
 "BirthDateString": "February 19, 1992",
 "PhotoUrl": "http://static.fantasydata.com/headshots/nfl/low-res/16236.png",
 "ByeWeek": 8,
 "UpcomingGameOpponent": "NE",
 "UpcomingGameWeek": 13,
 "ShortName": "C.Parkey",
 "AverageDraftPosition": null,
 "DepthPositionCategory": null,
 "DepthPosition": null,
 "DepthOrder": null,
 "DepthDisplayOrder": null,
 "CurrentTeam": "PHI",
 "CollegeDraftTeam": "IND",
 "CollegeDraftYear": 2014,
 "CollegeDraftRound": null,
 "CollegeDraftPick": null,
 "IsUndraftedFreeAgent": true,
 "HeightFeet": 6,
 "HeightInches": 0,
 "UpcomingOpponentRank": 11,
 "UpcomingOpponentPositionRank": 7,
 "CurrentStatus": "Injured Reserve",
 "UpcomingSalary": 4700,
 "FantasyAlarmPlayerID": 300712,
 "InjuryStatus": null, ............
 */

@end
