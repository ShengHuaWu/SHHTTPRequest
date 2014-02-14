//
//  NSURLRequest+SHCreation.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "NSURLRequest+SHCreation.h"

@implementation NSURLRequest (SHCreation)

#pragma mark - Public method
+ (instancetype)requestWithHTTPMethod:(NSString *)method urlString:(NSString *)urlString header:(NSDictionary *)header andHTTPBody:(id)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:method];
    // Hande header
    if ([header count] > 0) {
        for (NSString *key in [header allKeys]) {
            [request setValue:header[key] forKey:key];
        }
    }
    // Header body (JSON data)
    if (body) {
        NSError *error = nil;
        NSData *httpBody = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"[Debug]Failed to convert to JSON data. Error: %@", [error localizedDescription]);
            return nil;
        }
        [request setHTTPBody:httpBody];
    }
    
    return [request copy];
}

@end
