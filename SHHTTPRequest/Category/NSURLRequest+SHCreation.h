//
//  NSURLRequest+SHCreation.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This category is used to create the HTTP request.
 */

@interface NSURLRequest (SHCreation)

/**
 *  @brief Create a NSURLRequest instance for a HTTP request with HTTP method, the url, the header and the body.
 *
 *  @param method  The HTTP method. It could be @"GET", @"POST", @"PUT", @"DELETE".
 *  @param url     The url of HTTP request.
 *  @param headers The header of HTTP request.
 *  @param body    The body of HTTP request.
 *
 *  @return The instance of NSURLRequest associated with the parameters.
 */
+ (instancetype)requestWithHTTPMethod:(NSString *)method url:(NSURL *)url headers:(NSDictionary *)headers andHTTPBody:(NSData *)body;
@end
