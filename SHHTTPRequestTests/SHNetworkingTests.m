//
//  SHNetworkingTests.m
//  SHHTTPRequest
//
//  Created by WuShengHua on 2014/6/25.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHNetworking.h"

@interface SHNetworkingTests : XCTestCase
@property (nonatomic, strong) SHNetworking *networking;
@end

@implementation SHNetworkingTests

- (void)setUp
{
    [super setUp];
    self.networking = [[SHNetworking alloc] init];
}

- (void)tearDown
{
    self.networking = nil;
    [super tearDown];
}

- (void)test_httpGetRequestWithURL_headers_parameters_response_andError
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/wines"];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [self.networking httpGetRequestWithURL:url headers:nil parameters:nil response:&response andError:&error];
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    XCTAssertNil(error, @"Error occurs, please check.");
    XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
    XCTAssertEqual([responseArray count], 2, @"The count of the array is not correct.");
}

- (void)test_httpGetRequestInBackgroundWithURL_headers_parameters_andCompletion
{
    BOOL __block waitForCompletion = YES; // In order to test the asynchronous block
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/wines"];
    [self.networking httpGetRequestInBackgroundWithURL:url headers:nil parameters:nil andCompletion:^(NSData *responseData, NSHTTPURLResponse *response, NSError *error) {
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        XCTAssertNil(error, @"Error occurs, please check.");
        XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
        XCTAssertEqual([responseArray count], 2, @"The count of the array is not correct.");
        XCTAssertEqual([NSThread isMainThread], YES, @"The completion block is not in the main thread.");
        
        waitForCompletion = NO;
    }];
    
    while (waitForCompletion) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

@end
