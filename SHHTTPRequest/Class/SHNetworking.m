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

@interface SHNetworking ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation SHNetworking


#pragma mark - Designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark - Synchronous
- (NSData *)httpGetRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters response:(NSHTTPURLResponse *__autoreleasing *)response andError:(NSError *__autoreleasing *)error
{
    if ([parameters count] > 0) {
        NSString *queryString = [parameters toQueryString];
        url = [url URLByAppendingPathComponent:queryString];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"GET" url:url header:headers andHTTPBody:nil];
    
    NSHTTPURLResponse *res = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
    *response = res;
    *error = err;
    
    if (err) {
        NSLog(@"[Debug] Send GET request error. Error: %@", [err localizedDescription]);
        return nil;
    }
    
    return responseData;
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
- (void)httpGetRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters andCompletion:(SHNetworkingCompletion)completion
{
    SHNetworking *__weak weakSelf = self;
    // Send GET request in the background queue
    [self.operationQueue addOperationWithBlock:^{
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [weakSelf httpGetRequestWithURL:url headers:headers parameters:parameters response:&response andError:&error];
        
        // Back to the main queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completion) completion(responseData, response, error);
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
