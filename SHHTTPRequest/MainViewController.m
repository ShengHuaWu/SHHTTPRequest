//
//  MainViewController.m
//  SHHTTPRequest
//
//  Created by ShengHuaWu on 2014/2/14.
//  Copyright (c) 2014年 ShengHuaWu. All rights reserved.
//

#import "MainViewController.h"
#import "SHNetworking.h"

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

@end
