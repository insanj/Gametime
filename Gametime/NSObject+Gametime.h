//
//  NSObject+Gametime.h
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Gametime)

- (void)safeSetURL:(NSURL *)url forKey:(NSString *)key;

- (void)safeSetString:(NSString *)string forKey:(NSString *)key;

- (void)safeSetNumber:(NSNumber *)number forKey:(NSString *)key;

@end
