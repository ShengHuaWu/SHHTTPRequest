//
//  NSURLConnection+SHSynchronousHTTPRequest.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This category synchronously sends the GET, POST, PUT and DELETE request to the host (wed service or RESTful API).
 */

@interface NSURLConnection (SHSynchronousHTTPRequest)

+ (id)httpGetRequestWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters andError:(NSError **)error;

+ (id)httpPostRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

+ (id)httpPutRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

+ (id)httpDeleteRequestWithPath:(NSString *)path header:(NSDictionary *)header andError:(NSError **)error;

@end
