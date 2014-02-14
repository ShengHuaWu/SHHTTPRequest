//
//  NSString+SHHelper.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "NSString+SHHelper.h"
#import "SHNetworking.h"

@implementation NSString (SHHelper)

#pragma mark - Public method
+ (NSString *)urlEscape:(NSString *)unencodeString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodeString;
    CFStringRef legalURLCharactersToBeEscapedRef = (__bridge_retained CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ";
    NSString *string = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, originalStringRef, NULL, legalURLCharactersToBeEscapedRef, kCFStringEncodingUTF8);
    // Release the cf string
    CFRelease(originalStringRef);
    CFRelease(legalURLCharactersToBeEscapedRef);
    
    return string;
}

+ (NSString *)urlStringWithPath:(NSString *)path
{
    NSString *urlString = nil;
    NSDictionary *httpRequestInfo = [[NSBundle mainBundle] objectForInfoDictionaryKey:HTTPRequestInfoListKey];
    if ([httpRequestInfo[@"Port"] integerValue] == 80) {
        urlString = [NSString stringWithFormat:@"http://%@%@", httpRequestInfo[@"Host"], path];
    } else {
        urlString = [NSString stringWithFormat:@"http://%@:%d%@", httpRequestInfo[@"Host"], [httpRequestInfo[@"Port"] integerValue], path];
    }
    
    return urlString;
}

@end
