//
//  RequestCreationTests.m
//  SHHTTPRequest
//
//  Created by WuShengHua on 2014/6/20.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURLRequest+SHCreation.h"
#import <OCMock.h>

@interface RequestCreationTests : XCTestCase

@end

@implementation RequestCreationTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_requestWithHTTPMethod_url_header_andHTTPbody
{
    NSURLRequest *request = [NSURLRequest requestWithHTTPMethod:nil url:nil header:nil andHTTPBody:nil];
    XCTAssertNil(request, @"Method-or-url-nil should return a nil request.");
    
    request = [NSURLRequest requestWithHTTPMethod:@"GET" url:[NSURL URLWithString:@"http://localhost:3000/wines"] header:nil andHTTPBody:nil];
    XCTAssertEqualObjects([request HTTPMethod], @"GET", @"Method should be equal to GET.");
    XCTAssertEqualObjects([[request URL] absoluteString], @"http://localhost:3000/wines", @"Request url should be equal to http://localhost:3000/wines");
}

- (void)testNothing
{
    id mockObject = [OCMockObject mockForClass:[NSURLRequest class]];
    XCTAssertTrue(YES, @"");
}

@end
