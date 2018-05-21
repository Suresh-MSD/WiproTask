//
//  DataModel.h
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *detail;
@property(nonatomic, strong) NSURL *imageURL;

+(NSMutableArray *)getDataFromJson:(NSArray *)array;

@end
