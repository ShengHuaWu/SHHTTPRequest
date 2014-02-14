//
//  MainViewController.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "MainViewController.h"
#import "SHNetworking.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *httpRequestInfo = [[NSBundle mainBundle] objectForInfoDictionaryKey:HTTPRequestInfoListKey];
    NSString *path = [NSString stringWithFormat:@"/appClient/getCode/%@", httpRequestInfo[@"AppID"]];
    [SHNetworking httpGetRequestInBackgroundWithPath:path header:nil parameters:nil completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
