//
//  SHNetworking.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "SHNetworking.h"
#import "NSURLRequest+SHCreation.h"

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
    NSURL *queryURL = url;
    if ([parameters count] > 0) {
        NSString *queryString = @"?"; // Start with ?
        NSMutableArray *strings = [NSMutableArray array];
        for (id key in [parameters allKeys]) {
            [strings addObject:[NSString stringWithFormat:@"%@=%@", key, parameters[key]]];
        }
        queryString = [queryString stringByAppendingString:[strings componentsJoinedByString:@"&"]];
        NSString *urlString = [[queryURL absoluteString] stringByAppendingString:queryString];
        queryURL = [NSURL URLWithString:urlString];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"GET" url:queryURL headers:headers andHTTPBody:nil];
    NSHTTPURLResponse *res = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
    *response = res;
    *error = err;
    
    if (err) {
        NSLog(@"[Debug] Send GET request error: %@.", [err localizedDescription]);
        return nil;
    }
    
    return responseData;
}

- (NSData *)httpPostRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse *__autoreleasing *)response andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"POST" url:url headers:headers andHTTPBody:jsonData];
    NSHTTPURLResponse *res = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
    *response = res;
    *error = err;
    
    if (err) {
        NSLog(@"[Debug] Send POST request error: %@.", [err localizedDescription]);
        return nil;
    }
    
    return responseData;    
}

- (NSData *)httpPutRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse *__autoreleasing *)response andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"PUT" url:url headers:headers andHTTPBody:jsonData];
    NSHTTPURLResponse *res = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
    *response = res;
    *error = err;
    
    if (err) {
        NSLog(@"[Debug] Send PUT request error: %@.", [err localizedDescription]);
        return nil;
    }
    
    return responseData;
}

- (NSData *)httpDeleteRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers response:(NSHTTPURLResponse *__autoreleasing *)response andError:(NSError *__autoreleasing *)error
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:@"DELETE" url:url headers:headers andHTTPBody:nil];
    NSHTTPURLResponse *res = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
    *response = res;
    *error = err;
    
    if (err) {
        NSLog(@"[Debug] Send DELETE request error: %@.", [err localizedDescription]);
        return nil;
    }
    
    return responseData;
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

- (void)httpPostRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion
{
    SHNetworking *__weak weakSelf = self;
    // Send POST request in the background queue
    [self.operationQueue addOperationWithBlock:^{
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [weakSelf httpPostRequestWithURL:url headers:headers jsonData:jsonData response:&response andError:&error];
        
        // Back to the main queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completion) completion(responseData, response, error);
        }];
    }];
}

- (void)httpPutRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion
{
    SHNetworking *__weak weakSelf = self;
    // Send PUT request in the background queue
    [self.operationQueue addOperationWithBlock:^{
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [weakSelf httpPutRequestWithURL:url headers:headers jsonData:jsonData response:&response andError:&error];
        
        // Back to the main queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completion) completion(responseData, response, error);
        }];
    }];
}

- (void)httpDeleteRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers andCompletion:(SHNetworkingCompletion)completion
{
    SHNetworking *__weak weakSelf = self;
    // Send DELETE request in the background queue
    [self.operationQueue addOperationWithBlock:^{
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [weakSelf httpDeleteRequestWithURL:url headers:headers response:&response andError:&error];
        
        // Back to the main queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completion) completion(responseData, response, error);
        }];
    }];
}

@end
