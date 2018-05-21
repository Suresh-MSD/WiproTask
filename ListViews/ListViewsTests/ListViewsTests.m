//
//  ListViewsTests.m
//  ListViewsTests
//
//  Created by Suresh on 17/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "ListTableViewCell.h"

@interface ListViewsTests : XCTestCase
@property (nonatomic, strong) ViewController *viewController;
@end

@implementation ListViewsTests

- (void)setUp {
    [super setUp];
    //Setup Viewcontroller
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    window.rootViewController = navigationController;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    
    [self.viewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [self.viewController viewDidAppear:NO];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.viewController.view.subviews;
    XCTAssertTrue([subviews containsObject:self.viewController.tableView], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.viewController.tableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testTableViewCellCellReuseIdentifier
{
    //Cell ReuseIdentifier
    ListTableViewCell *cell = (ListTableViewCell *)[self.viewController tableView:self.viewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *reuseIdentifier = @"ListTableViewCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:reuseIdentifier], @"Table not creating reusable cells");
}

- (void)testTableViewHasDataSource
{
    //Check DataSource
    XCTAssertNotNil(self.viewController.tableView.dataSource, @"UITableView DataSource not to be nil");
}

- (void)testUITableViewDataSourceConform
{
   //Conform DataSource Protocol
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"Views not conforming DataSource");
}

- (void)testTableViewIsConnectedToDelegate
{
    //Check Delegate
    XCTAssertNotNil(self.viewController.tableView.delegate, @"UITableView Delegate not to be nil");
}

- (void)testUITableViewDelegateConform
{
    //Conform Delegate Protocol
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"Views not conforming Delegate");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
