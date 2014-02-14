//
//  SHNetworking.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SHNetWorkingCompletionBlock) (id responseObject);
typedef void (^SHNetWorkingFailureBlock) (NSError *error);

/**
 *  This key represents a NSDictionary, which is declared in the plist.
 *  The NSDictionary contains the Host as a NSString and the Port as a NSNumber.
 */
static NSString *const HTTPRequestInfoListKey = @"DermpathService"; // !!!: Need to modify

@interface SHNetworking : NSObject

#warning TODO: POST, PUT, DELETE
+ (void)httpGetRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

@end
