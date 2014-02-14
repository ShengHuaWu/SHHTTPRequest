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
*  @brief This method is used to create a HTTP request.
*
*  @param method    The HTTP method of the request. It could be @"GET", @"POST", @"PUT", @"DELETE".
*  @param urlString The url string of the request. It could append with the query string (http://...?...&...).
*  @param header    The header of the request. It contains Content-Type, Accept, ...
*  @param body      The HTTP body of the request. It could be a NSDictionary or a NSArray.
*
*  @return The instance of NSURLRequest
*/
+ (instancetype)requestWithHTTPMethod:(NSString *)method urlString:(NSString *)urlString header:(NSDictionary *)header andHTTPBody:(id)body;

@end
