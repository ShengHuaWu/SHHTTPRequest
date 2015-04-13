//
//  SHNetworkingTests.m
//  SHHTTPRequest
//
//  Created by WuShengHua on 2014/6/25.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

/**
 *  The tests in this class need to setup an simple api server.
 */

#import <XCTest/XCTest.h>
#import "SHNetworking.h"

@interface SHNetworkingTests : XCTestCase
@property (nonatomic, strong) SHNetworking *networking;
@property (nonatomic, strong) NSURL *testURL;
@end

@implementation SHNetworkingTests

- (void)setUp
{
    [super setUp];
    self.networking = [[SHNetworking alloc] init];
    self.testURL = [NSURL URLWithString:@"http://localhost:3000/wines"];
}

- (void)tearDown
{
    self.networking = nil;
    self.testURL = nil;
    [super tearDown];
}

- (void)DISABLE_test_httpGetRequestWithURL_headers_parameters_response_andError
{
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [self.networking httpGetRequestWithURL:self.testURL headers:nil parameters:@{@"id": @"53a3df191904b22d0db16ca0"} response:&response andError:&error];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
    XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
    
    XCTAssertEqualObjects(responseDict[@"name"], @"CHATEAU DE SAINT COSME", @"The name of first wine is not correct.");
}

- (void)DISABLE_test_httpGetRequestInBackgroundWithURL_headers_parameters_andCompletion
{
    BOOL __block waitForCompletion = YES; // In order to test the asynchronous block
    
    [self.networking httpGetRequestInBackgroundWithURL:self.testURL headers:nil parameters:nil andCompletion:^(NSData *responseData, NSHTTPURLResponse *response, NSError *error) {
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
        XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
        XCTAssertEqual([NSThread isMainThread], YES, @"The completion block is not in the main thread.");
        
        NSDictionary *firstObject = [responseArray firstObject];
        XCTAssertEqualObjects(firstObject[@"name"], @"CHATEAU DE SAINT COSME", @"The name of first wine is not correct.");
        
        waitForCompletion = NO;
    }];
    
    while (waitForCompletion) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)DISABLE_test_httpPostRequestWithURL_headers_jsonData_response_andError
{
    NSDictionary *jsonDict = @{@"name": @"new wine", @"year": @"1983", @"description": @"Just a new wine."};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSDictionary *headers = @{@"Content-Type": @"application/json"};
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [self.networking httpPostRequestWithURL:self.testURL headers:headers jsonData:jsonData response:&response andError:&error];
    XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
    XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    XCTAssertEqualObjects(responseDict[@"name"], @"new wine", @"The name of the response dictionary is not correct.");
}

- (void)DISABLE_test_httpPostRequestInBackgroundWithURL_headers_jsonData_andCompletion
{
    BOOL __block waitForCompletion = YES; // In order to test the asynchronous block
    
    NSDictionary *jsonDict = @{@"name": @"new wine", @"year": @"1983", @"description": @"Just a new wine."};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSDictionary *headers = @{@"Content-Type": @"application/json"};
    [self.networking httpPostRequestInBackgroundWithURL:self.testURL headers:headers jsonData:jsonData andCompletion:^(NSData *responseData, NSHTTPURLResponse *response, NSError *error) {
        XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
        XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
        XCTAssertEqual([NSThread isMainThread], YES, @"The completion block is not in the main thread.");
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        XCTAssertEqualObjects(responseDict[@"name"], @"new wine", @"The name of the response dictionary is not correct.");
        
        waitForCompletion = NO;
    }];
    
    while (waitForCompletion) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)DISABLE_test_httpPutRequestWithURL_headers_jsonData_response_andError
{
    NSURL *url = [self.testURL URLByAppendingPathComponent:@"53aa644112d5edd80872f81a"]; // Might need to change the id
    NSDictionary *headers = @{@"Content-Type": @"application/json"};
    NSDictionary *jsonDict = @{@"name": @"The new wine", @"year": @"1999", @"description": @"Good one."};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [self.networking httpPutRequestWithURL:url headers:headers jsonData:jsonData response:&response andError:&error];
    XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
    XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    XCTAssertEqualObjects(responseDict[@"name"], @"The new wine", @"The name of the response dictionary is not correct.");
}

- (void)test_httpPutRequestInBackgroundWithURL_headers_jsonData_andCompletion
{
    BOOL __block waitForCompletion = YES; // In order to test the asynchronous block
    
    NSURL *url = [self.testURL URLByAppendingPathComponent:@"53aa644112d5edd80872f81a"]; // Might need to change the id
    NSDictionary *headers = @{@"Content-Type": @"application/json"};
    NSDictionary *jsonDict = @{@"name": @"The new wine", @"year": @"1999", @"description": @"Good one."};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    
    [self.networking httpPutRequestInBackgroundWithURL:url headers:headers jsonData:jsonData andCompletion:^(NSData *responseData, NSHTTPURLResponse *response, NSError *error) {
        XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
        XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
        XCTAssertEqual([NSThread isMainThread], YES, @"The completion block is not in the main thread.");
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        XCTAssertEqualObjects(responseDict[@"name"], @"The new wine", @"The name of the response dictionary is not correct.");
        
        waitForCompletion = NO;
    }];
    
    while (waitForCompletion) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)DISABLE_test_httpDeleteRequestWithURL_headers_response_andError
{
    NSURL *url = [self.testURL URLByAppendingPathComponent:@"53aa5f3712d5edd80872f815"]; // Might need to change the id
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    [self.networking httpDeleteRequestWithURL:url headers:nil response:&response andError:&error];
    XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
    XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
}

- (void)DISABLE_test_httpDeleteRequestInBackgroundWithURL_headers_andCompletion
{
    BOOL __block waitForCompletion = YES; // In order to test the asynchronous block
    NSURL *url = [self.testURL URLByAppendingPathComponent:@"53aa607012d5edd80872f816"]; // Might need to change the id
    [self.networking httpDeleteRequestInBackgroundWithURL:url headers:nil andCompletion:^(NSData *responseData, NSHTTPURLResponse *response, NSError *error) {
        XCTAssertNil(error, @"Error occurs. %@.", [error localizedDescription]);
        XCTAssertEqual([response statusCode], 200, @"The connection response status code is not 200.");
        XCTAssertEqual([NSThread isMainThread], YES, @"The completion block is not in the main thread.");
        
        waitForCompletion = NO;
    }];
    
    while (waitForCompletion) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)test_travis_ci
{
    XCTAssert(YES, @"It will not be failed.");
}

@end
