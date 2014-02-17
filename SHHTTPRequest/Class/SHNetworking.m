//
//  SHNetworking.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "SHNetworking.h"
#import "NSURLRequest+SHCreation.h"
#import "NSString+SHHelper.h"
#import "NSDictionary+SHToQueryString.h"

@implementation SHNetworking

#pragma mark - Synchronous
+ (id)httpGetRequestWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters andError:(NSError *__autoreleasing *)error
{
    if ([parameters count] > 0) {
        path = [path stringByAppendingString:[parameters toQueryString]];
    }
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"GET" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:nil];
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    if (err) {
        *error = err;
        NSLog(@"[Debug]Send GET request error. Error: %@", [err localizedDescription]);
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

+ (id)httpPostRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"POST" urlString:[NSString urlStringWithPath:path] header:header andHTTPBody:json];
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
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
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
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
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
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

#pragma mark - Asynchronous
+ (void)httpGetRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock
{
    // Send the GET request in a background thread
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        NSError *error = nil;
        id responseObject = [self httpGetRequestWithPath:path header:header parameters:parameters andError:&error];
        // Back to the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            } else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }
            }
        }];
    }];
}

+ (void)httpPostRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock
{
    // Send the GET request in a background thread
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        NSError *error = nil;
        id responseObject = [self httpPostRequestWithPath:path header:header json:json andError:&error];
        // Back to the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            } else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }
            }
        }];
    }];
}

+ (void)httpPutRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock
{
    // Send the GET request in a background thread
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        NSError *error = nil;
        id responseObject = [self httpPutRequestWithPath:path header:header json:json andError:&error];
        // Back to the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            } else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }
            }
        }];
    }];
}

+ (void)httpDeleteRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock
{
    // Send the GET request in a background thread
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        NSError *error = nil;
        id responseObject = [self httpDeleteRequestWithPath:path header:header andError:&error];
        // Back to the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            } else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }
            }
        }];
    }];
}

@end
