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
            [request setValue:header[key] forHTTPHeaderField:key];
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

+ (instancetype)requestWithHTTPMethod:(NSString *)method url:(NSURL *)url header:(NSDictionary *)header andHTTPBody:(NSData *)body
{
    // Return nil if method or url do not exist.
    if (![method length] || !url) return nil;
    
    // Create the instance
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // Set HTTP method
    [request setHTTPMethod:method];
    
    // Set HTTP header
    for (NSString *key in [header allKeys]) {
        [request setValue:header[key] forHTTPHeaderField:key];
    }
    
    // Set HTTP body
    if ([body length]) {
        [request setHTTPBody:body];
    }
    
    return [request copy];
}

@end
