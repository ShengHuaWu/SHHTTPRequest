//
//  SHNetworking.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "SHNetworking.h"
#import "NSURLConnection+SHSynchronousHTTPRequest.h"

@implementation SHNetworking

#pragma mark - Public method
+ (void)httpGetRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock
{
    // Send the GET request in a background thread
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        NSError *error = nil;
        id responseObject = [NSURLConnection httpGetRequestWithPath:path header:header parameters:parameters andError:&error];
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
