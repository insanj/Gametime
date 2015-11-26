//
//  GTPlayerObject.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTPlayerObject : NSObject

@property (strong, nonatomic, readonly) NSURL *playerPhotoURL;

@property (strong, nonatomic, readonly) NSString *playerTeamAbbreviation, *playerFirstName, *playerLastName, *playerFullName, *playerPositionName, *playerStatusString, *playerCollegeName;

@property (nonatomic, readonly) NSInteger playerIdentifier, playerNumber, playerHeightFeet, playerHeightInches, playerWeight, playerExperience, playerAge;

@property (nonatomic, readonly) BOOL playerActive;

@property (nonatomic, readonly) NSInteger playerByeWeek, playerUpcomingGameWeek, playerUpcomingOpponentPositionRank;

@property (strong, nonatomic, readonly) NSString *playerUpcomingGameOpponent;

+ (instancetype)playerWithDictionaryRepresentation:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
