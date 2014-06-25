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
+ (instancetype)requestWithHTTPMethod:(NSString *)method url:(NSURL *)url headers:(NSDictionary *)headers andHTTPBody:(NSData *)body
{
    // Return nil if method or url do not exist.
    if (![method length] || !url) return nil;
    
    // Create the instance
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // Set HTTP method
    [request setHTTPMethod:method];
    
    // Set HTTP header
    for (NSString *key in [headers allKeys]) {
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    
    // Set HTTP body
    if ([body length]) {
        [request setHTTPBody:body];
    }
    
    return [request copy];
}

@end
