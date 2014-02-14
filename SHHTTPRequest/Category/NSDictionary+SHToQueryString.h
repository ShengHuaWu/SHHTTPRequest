//
//  NSDictionary+SHToQueryString.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This category is used to convert a NSDictionary to a query string.
 */

@interface NSDictionary (SHToQueryString)

/**
 *  @brief This method is used to convert a NSDictionary to a query string.
 *
 *  @return The query string with ? at the beginning.
 */
- (NSString *)toQueryString;

@end
