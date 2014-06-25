//
//  SHNetworking.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SHNetWorkingCompletionBlock) (id responseObject);
typedef void (^SHNetworkingCompletion) (NSData *responseData, NSHTTPURLResponse *response, NSError *error);
typedef void (^SHNetWorkingFailureBlock) (NSError *error);

/**
 *  This key represents a NSDictionary, which is declared in the plist.
 *  The NSDictionary contains the AppID as a NSString, the AppKey as a NSTring, the Host as a NSString and the Port as a NSNumber.
 */
static NSString *const HTTPRequestInfoKey = @"HTTPRequestInfo"; // !!!: Need to be modified


/**
 *  This class is used to send http request synchronously or asynchronously.
 */

@interface SHNetworking : NSObject

/**
 *  @brief Send the GET request synchronously.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param parameters The request parameters that will be converted to a query string
 *  @param response   The connection response
 *  @param error      The internet error
 *
 *  @return The response data
 */
- (NSData *)httpGetRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters response:(NSHTTPURLResponse **)response andError:(NSError **)error;
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
 *  @brief Send a HTTP GET request asynchronously. The completion and failure block are both executed in the main queue.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param parameters The request parameters that will be converted to a query string
 *  @param completion Return the response data, the connection response and the internet error
 */
- (void)httpGetRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters andCompletion:(SHNetworkingCompletion)completion;
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
