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

+ (NSString*)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i = 0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end
