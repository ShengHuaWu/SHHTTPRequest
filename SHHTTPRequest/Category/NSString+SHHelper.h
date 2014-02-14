//
//  NSString+SHHelper.h
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHHelper)

/**
 *  @brief This method is used to convert a string to a url.
 *
 *  @param unencodeString The unencode string
 *
 *  @return The url
 */
+ (NSString *)urlEscape:(NSString *)unencodeString;

/**
 *  @brief This method is used to create a url string
 *
 *  @param path The path of an api
 *
 *  @return The url string
 */
+ (NSString *)urlStringWithPath:(NSString *)path;

@end
