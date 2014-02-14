//
//  NSDictionary+SHToQueryString.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "NSDictionary+SHToQueryString.h"
#import "NSString+SHHelper.h"

@implementation NSDictionary (SHToQueryString)

#pragma mark - Public method
- (NSString *)toQueryString
{
    NSString *queryString = @"?"; // Start with ?
    NSMutableArray *strings = [NSMutableArray array];
    for (id key in [self allKeys]) {
        NSString *keyString = [NSString urlEscape:[key description]];
        NSString *valueString = [NSString urlEscape:[self[key] description]];
        [strings addObject:[NSString stringWithFormat:@"%@=%@", keyString, valueString]];
    }
    queryString = [queryString stringByAppendingString:[strings componentsJoinedByString:@"&"]];
    
    return queryString;
}

@end
