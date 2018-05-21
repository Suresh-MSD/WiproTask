//
//  ViewController.h
//  ListViews
//
//  Created by Suresh on 17/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

