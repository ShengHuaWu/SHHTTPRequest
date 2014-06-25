//
//  SHNetworking.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SHNetworkingCompletion) (NSData *responseData, NSHTTPURLResponse *response, NSError *error);

/**
 *  This class is used to send http request synchronously or asynchronously.
 */

@interface SHNetworking : NSObject

/**
 *  @brief Send a GET request synchronously.
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
 *  @brief Send a POST request synchronously.
 *
 *  @param url      The request url
 *  @param headers  The request headers
 *  @param jsonData The JSON format data
 *  @param response The connection response
 *  @param error    The internet error
 *
 *  @return The response data
 */
- (NSData *)httpPostRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse **)response andError:(NSError **)error;

/**
 *  @brief Send a PUT request synchronously.
 *
 *  @param url      The request url
 *  @param headers  The request headers
 *  @param jsonData The JSON format data
 *  @param response The connection response
 *  @param error    The internet error
 *
 *  @return The response data
 */
- (NSData *)httpPutRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse **)response andError:(NSError **)error;

/**
 *  @brief Send a DELETE request synchronously.
 *
 *  @param url      The request url
 *  @param headers  The request headers
 *  @param response The connection response
 *  @param error    The internet error
 *
 *  @return The response data
 */
- (NSData *)httpDeleteRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers response:(NSHTTPURLResponse **)response andError:(NSError **)error;

/**
 *  @brief Send a GET request asynchronously. The completion and failure block are both executed in the main queue.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param parameters The request parameters that will be converted to a query string
 *  @param completion Return the response data, the connection response and the internet error
 */
- (void)httpGetRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters andCompletion:(SHNetworkingCompletion)completion;

/**
 *  @brief Send a POST request asynchronously. The completion and failure block are both executed in the main queue.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param jsonData   The JSON format data
 *  @param completion Return the response data, the connection response and the internet error
 */
- (void)httpPostRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion;

/**
 *  @brief Send a PUT request asynchronously. The completion and failure block are both executed in the main queue.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param jsonData   The JSON format data
 *  @param completion Return the response data, the connection response and the internet error
 */
- (void)httpPutRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion;

/**
 *  @brief Send a DELETE request asynchronously. The completion and failure block are both executed in the main queue.
 *
 *  @param url        The request url
 *  @param headers    The request headers
 *  @param completion Return the response data, the connection response and the internet error
 */
- (void)httpDeleteRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers andCompletion:(SHNetworkingCompletion)completion;

@end
