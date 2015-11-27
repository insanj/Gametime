//
//  NSObject+Gametime.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "NSObject+Gametime.h"

@implementation NSObject (Gametime)

- (void)safeSetURL:(NSURL *)url forKey:(NSString *)key {
    if (!url || [url isKindOfClass:[NSNull class]]) {
        [self setValue:[NSURL URLWithString:@""] forKey:key];
    }
    
    else {
        [self setValue:url forKey:key];
    }
}

- (void)safeSetString:(NSString *)string forKey:(NSString *)key {
    if (!string || [string isKindOfClass:[NSNull class]]) {
        [self setValue:@"" forKey:key];
    }
    
    else {
        [self setValue:string forKey:key];
    }
}

- (void)safeSetNumber:(NSNumber *)number forKey:(NSString *)key {
    if (!number || [number isKindOfClass:[NSNull class]]) {
        [self setValue:@(0) forKey:key];
    }
    
    else {
        [self setValue:number forKey:key];
    }
}

@end
