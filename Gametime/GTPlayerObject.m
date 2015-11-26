//
//  GTPlayerObject.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTPlayerObject.h"

@implementation GTPlayerObject

+ (instancetype)playerWithDictionaryRepresentation:(NSDictionary *)dictionary {
    GTPlayerObject *playerObject = [GTPlayerObject new];
    [playerObject setValue:[NSURL URLWithString:dictionary[@"PhotoUrl"]] forKey:@"playerPhotoURL"];
    
    [playerObject setValue:dictionary[@"Team"] forKey:@"playerTeamAbbreviation"];
    [playerObject setValue:dictionary[@"FirstName"] forKey:@"playerFirstName"];
    [playerObject setValue:dictionary[@"LastName"] forKey:@"playerLastName"];
    [playerObject setValue:dictionary[@"Name"] forKey:@"playerFullName"];
    [playerObject setValue:dictionary[@"Position"] forKey:@"playerPositionName"];
    [playerObject setValue:dictionary[@"Status"] forKey:@"playerStatusString"];
    [playerObject setValue:dictionary[@"College"] forKey:@"playerCollegeName"];
    
    [playerObject setValue:dictionary[@"PlayerID"] forKey:@"playerIdentifier"];
    [playerObject setValue:dictionary[@"Number"] forKey:@"playerNumber"];
    [playerObject setValue:dictionary[@"HeightFeet"] forKey:@"playerHeightFeet"];
    [playerObject setValue:dictionary[@"HeightInches"] forKey:@"playerHeightInches"];
    [playerObject setValue:dictionary[@"Weight"] forKey:@"playerWeight"];
    [playerObject setValue:dictionary[@"Experience"] forKey:@"playerExperience"];
    [playerObject setValue:dictionary[@"Age"] forKey:@"playerAge"];
    
    [playerObject setValue:dictionary[@"Active"] forKey:@"playerActive"];
    
    [playerObject setValue:dictionary[@"ByeWeek"] forKey:@"playerByeWeek"];
    [playerObject setValue:dictionary[@"UpcomingGameWeek"] forKey:@"playerUpcomingGameWeek"];
    [playerObject setValue:dictionary[@"UpcomingOpponentPositionRank"] forKey:@"playerUpcomingOpponentPositionRank"];
    
    [playerObject setValue:dictionary[@"UpcomingGameOpponent"] forKey:@"playerUpcomingGameOpponent"];
    return playerObject;
}

- (NSDictionary *)dictionaryRepresentation {
    return @{@"PhotoUrl" : _playerPhotoURL.absoluteString,
             @"Team" : _playerTeamAbbreviation,
             @"FirstName" : _playerFirstName,
             @"LastName" : _playerLastName,
             @"Name" : _playerFullName,
             @"Position" : _playerPositionName,
             @"Status" : _playerStatusString,
             @"College" : _playerCollegeName,
             
             @"PlayerID" : @(_playerIdentifier),
             @"Number" : @(_playerNumber),
             @"HeightFeet" : @(_playerHeightFeet),
             @"HeightInches" : @(_playerHeightInches),
             @"Weight" : @(_playerWeight),
             @"Experience" : @(_playerExperience),
             @"Age" : @(_playerAge),
             
             @"Active" : @(_playerActive),
             
             @"ByeWeek" : @(_playerByeWeek),
             @"UpcomingGameWeek" : @(_playerUpcomingGameWeek),
             @"UpcomingOpponentPositionRank" : @(_playerUpcomingOpponentPositionRank),
             
             @"playerUpcomingGameOpponent" : _playerUpcomingGameOpponent};
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
