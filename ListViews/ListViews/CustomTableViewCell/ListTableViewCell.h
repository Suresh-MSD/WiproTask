//
//  ListTableViewCell.h
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface ListTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *descriptionLabel;

-(void)setterMethod:(DataModel *)item;
-(void)setImageFromURL:(NSURL*)imageURL;

@end
