//
//  MainViewController.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "MainViewController.h"
#import "SHNetworking.h"
#import "NSString+SHHelper.h"

static NSString *const ReusableCellIdentifier = @"Cell";

typedef NS_ENUM(NSInteger, TestMethod) {
    TestMethodUnknown = -1,
    TestMethodGetCode = 0,
    TestMethodGetToken,
    TestMethodLogin,
    TestMethodAddSlide,
    TestMethodDeleteSlide,
    TestMethodScanUpdate
};

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *testMethods;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userKey;
@end

@implementation MainViewController

#pragma mark - View life cycle
- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReusableCellIdentifier];
    self.view = tableView;
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.testMethods = @[@"get code", @"get token", @"login", @"add slide", @"delete slide", @"scan update"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.testMethods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReusableCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.testMethods[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == TestMethodGetCode) {
        [self getCode];
    } else if (indexPath.row == TestMethodGetToken) {
        [self getToken];
    } else if (indexPath.row == TestMethodLogin) {
        [self login];
    } else if (indexPath.row == TestMethodAddSlide) {
        [self addSlide];
    } else if (indexPath.row == TestMethodDeleteSlide) {
        [self deleteSlide];
    } else if (indexPath.row == TestMethodScanUpdate) {
        [self scanUpdate];
    }
}

#pragma mark - Test method
- (void)getCode
{
    NSDictionary *httpRequestInfo = [[NSBundle mainBundle] objectForInfoDictionaryKey:HTTPRequestInfoKey];
    NSString *path = [NSString stringWithFormat:@"/appClient/getCode/%@", httpRequestInfo[@"AppID"]];
    [SHNetworking httpGetRequestInBackgroundWithPath:path header:nil parameters:nil completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSDictionary *dataDict = resultDict[@"data"];
        self.code = dataDict[@"code"];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)getToken
{
    if (![self.code length]) return;
    
    NSDictionary *httpRequestInfo = [[NSBundle mainBundle] objectForInfoDictionaryKey:HTTPRequestInfoKey];
    NSString *originalString = [NSString stringWithFormat:@"%@:%@", self.code, httpRequestInfo[@"AppKey"]];
    NSDictionary *header = @{@"Authorization": [NSString stringWithFormat:@"Basic %@", [NSString base64String:originalString]]};
    [SHNetworking httpGetRequestInBackgroundWithPath:@"/appClient/getToken" header:header parameters:nil completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSDictionary *dataDict = resultDict[@"data"];
        self.token = dataDict[@"token"];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)login
{
    NSDictionary *header = @{@"Authorization": [NSString stringWithFormat:@"Basic %@", [NSString base64String:@"Collection:Collection1234"]], @"Token": self.token};
    [SHNetworking httpGetRequestInBackgroundWithPath:@"/user/login/Collection" header:header parameters:nil completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSDictionary *dataDict = resultDict[@"data"];
        self.userKey = dataDict[@"userKey"];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)addSlide
{
    // !!!: The JSON object need to be an array
    [SHNetworking httpPostRequestInBackgroundWithPath:@"/dlcs/slide" header:@{@"Token": self.token, @"userKey": self.userKey} json:@[@{@"cassetteID": @"gKGSE2wX7clG", @"number": [NSNumber numberWithInteger:1]}] completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
        
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)deleteSlide
{
    [SHNetworking httpDeleteRequestInBackgroundWithPath:@"/dlcs/slide/bv3r94sgFPW9" header:@{@"Token": self.token, @"userKey": self.userKey} completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)scanUpdate
{
    [SHNetworking httpPutRequestInBackgroundWithPath:@"/dlcs/scan/WR8NuTq3x37" header:@{@"Token": self.token, @"userKey": self.userKey} json:nil completionBlock:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
