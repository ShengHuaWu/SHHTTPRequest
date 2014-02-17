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
static NSString *const HTTPRequestInfoListKey = @"DermpathService"; // !!!: Need to be modified


/**
 *  This class is used to send http request synchronously or asynchronously.
 */

@interface SHNetworking : NSObject

/**
 *  @brief This method synchronously send a HTTP GET request.
 *
 *  @param path       The path of the request. It does not contain the host url.
 *  @param header     The header of the request. It contains Content-Type, Accept, ...
 *  @param parameters The parameters of the request. It will be converted to a query string.
 *  @param error      The connection of JSON parse error
 *
 *  @return The respose of the http GET request
 */
+ (id)httpGetRequestWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters andError:(NSError **)error;

/**
 *  @brief This method synchronously send a HTTP POST request.
 *
 *  @param path   The path of the request. It does not contain the host url.
 *  @param header The header of the request. It contains Content-Type, Accept, ...
 *  @param json   The JSON data. It could be a NSDictionary or a NSArray.
 *  @param error  The connection of JSON parse error
 *
 *  @return The respose of the http POST request
 */
+ (id)httpPostRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

/**
 *  @brief This method synchronously send a HTTP PUT request.
 *
 *  @param path   The path of the request. It does not contain the host url.
 *  @param header The header of the request. It contains Content-Type, Accept, ...
 *  @param json   The JSON data. It could be a NSDictionary or a NSArray.
 *  @param error  The connection of JSON parse error
 *
 *  @return The respose of the http PUT request
 */
+ (id)httpPutRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

/**
 *  @brief This method synchronously send a HTTP DELETE request.
 *
 *  @param path   The path of the request. It does not contain the host url.
 *  @param header The header of the request. It contains Content-Type, Accept, ...
 *  @param error  The connection of JSON parse error
 *
 *  @return The respose of the http DELETE request
 */
+ (id)httpDeleteRequestWithPath:(NSString *)path header:(NSDictionary *)header andError:(NSError **)error;

/**
 *  @brief This method asynchronously send a HTTP GET request.
 *
 *  @param path            The path of the request. It does not contain the host url.
 *  @param header          The header of the request. It contains Content-Type, Accept, ...
 *  @param parameters      The parameters of the request. It will be converted to a query string.
 *  @param completionBlock The completion block. It returns the respose of the GET request.
 *  @param failureBlock    The failure block. It returns the error of the GET request.
 */
+ (void)httpGetRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

/**
 *  @brief This method asynchronously send a HTTP POST request.
 *
 *  @param path            The path of the request. It does not contain the host url.
 *  @param header          The header of the request. It contains Content-Type, Accept, ...
 *  @param json            The JSON data. It could be a NSDictionary or a NSArray.
 *  @param completionBlock The completion block. It returns the respose of the POST request.
 *  @param failureBlock    The failure block. It returns the error of the POST request.
 */
+ (void)httpPostRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

/**
 *  @brief This method asynchronously send a HTTP POST request.
 *
 *  @param path            The path of the request. It does not contain the host url.
 *  @param header          The header of the request. It contains Content-Type, Accept, ...
 *  @param json            The JSON data. It could be a NSDictionary or a NSArray.
 *  @param completionBlock The completion block. It returns the respose of the PUT request.
 *  @param failureBlock    The failure block. It returns the error of the PUT request.
 */
+ (void)httpPutRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

/**
 *  @brief This method asynchronously send a HTTP DELETE request.
 *
 *  @param path            The path of the request. It does not contain the host url.
 *  @param header          The header of the request. It contains Content-Type, Accept, ...
 *  @param completionBlock The completion block. It returns the respose of the DELETE request.
 *  @param failureBlock    The failure block. It returns the error of the DELETE request.
 */
+ (void)httpDeleteRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

@end
