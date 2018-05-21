//
//  ViewController.m
//  ListViews
//
//  Created by Suresh on 17/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import "ViewController.h"
#import "ConnectionRequest.h"
#import "DataModel.h"
#import "ListTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

@synthesize tableView;

static NSString *cellIdentifier = @"ListTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Activity indicator
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.loadingIndicator startAnimating];
    [self.loadingIndicator hidesWhenStopped];
    self.loadingIndicator.center = self.view.center;
    [self.view addSubview:self.loadingIndicator];
}

// Table creation in ViewDidAppear method because of UnitTest cases
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    [self CreateTableView];
    if (self.dataList == nil) {
        [self fetchDetails];
    }
}


#pragma mark - Create TableView
- (void)CreateTableView {
    
    // init table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Add clear background color for loader visible
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    // Must set Delegate & DataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    NSDictionary *views = @{@"tableView":self.tableView};
    
    // tableviw auto layout
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[tableView]|" options:0 metrics:nil views:views]];
    
    // dynamic height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.tableFooterView = nil;
    
    // pull down refresh
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = (ListTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    

    cell.titleLabel.text = @"";
    cell.descriptionLabel.text = @"";
    cell.imageView.image = nil;
    
    [cell setterMethod:[self.dataList objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}

#pragma mark - Fetch details

- (void)refreshTable {
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
    [self fetchDetails];
}

//Fetch request using nsurlconnection
-(void)fetchDetails {
    typeof(self) weakSelf = self;
    
    [ConnectionRequest fetchRequestDetails:^(NSDictionary *result, NSError *error) {
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        [weakSelf.loadingIndicator stopAnimating];
        [[weakSelf tableView] reloadData];
        [[weakSelf refreshControl] performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.0];
        
        if (result != nil) {
            [weakSelf updateDetail:result];
        } else {
            
            NSString *title = @"Error";
            NSString *message = @"Something went wrong. Please try again";
            
            if ([UIAlertController class]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            } else {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
        }
    }];
}

//Scroll Updates
-(void)updateDetail:(NSDictionary *)details {
    
    if ([details objectForKey:@"title"]) {
        self.title = [details objectForKey:@"title"];
    }
    
    if (self.dataList == nil) {
        self.dataList = [NSMutableArray array];
    }
    
    if ([details objectForKey:@"rows"]) {
        self.dataList = nil;
        self.dataList = [DataModel getDataFromJson:[details objectForKey:@"rows"]];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
