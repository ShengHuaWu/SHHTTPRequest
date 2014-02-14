//
//  NSURLConnection+SHSynchronousHTTPRequest.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "NSURLConnection+SHSynchronousHTTPRequest.h"
#import "NSURLRequest+SHCreation.h"
#import "NSString+SHHelper.h"
#import "NSDictionary+SHToQueryString.h"

@implementation NSURLConnection (SHSynchronousHTTPRequest)

#pragma mark - Public method
+ (id)httpGetRequestWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters andError:(NSError *__autoreleasing *)error
{
    if ([parameters count] > 0) {
        path = [path stringByAppendingString:[parameters toQueryString]];
    }
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"GET" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:nil];
    
    NSError *err = nil;
    NSData *responseData = [self sendSynchronousRequest:request returningResponse:nil error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Send GET request error. Error: %@", [err localizedDescription]);
        return nil;
    }
#warning TODO: Need to create error
    id object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Parse JSON error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    return object;
}

+ (id)httpPostRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"POST" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:json];
    
    NSError *err = nil;
    NSData *responseData = [self sendSynchronousRequest:request returningResponse:nil error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Send POST request error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Parse JSON error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    return object;
}

+ (id)httpPutRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"PUT" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:json];
    
    NSError *err = nil;
    NSData *responseData = [self sendSynchronousRequest:request returningResponse:nil error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Send PUT request error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Parse JSON error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    return object;
}

+ (id)httpDeleteRequestWithPath:(NSString *)path header:(NSDictionary *)header andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"DELETE" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:nil];
    
    NSError *err = nil;
    NSData *responseData = [self sendSynchronousRequest:request returningResponse:nil error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Send DELETE request error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Parse JSON error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    return object;
}

@end
