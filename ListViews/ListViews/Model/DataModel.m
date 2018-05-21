//
//  DataModel.m
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+(NSMutableArray *)getDataFromJson:(NSArray *)array {
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        if ([dictionary objectForKey:@"title"] != [NSNull null] || [dictionary objectForKey:@"description"] != [NSNull null] || [dictionary objectForKey:@"imageHref"] != [NSNull null]) {
            
            DataModel *dataModel = [[DataModel alloc]init];
            
            if ([dictionary objectForKey:@"title"] != [NSNull null]) {
                dataModel.title = [dictionary objectForKey:@"title"];
            }
            
            if ([dictionary objectForKey:@"description"] != [NSNull null]) {
                dataModel.detail = [dictionary objectForKey:@"description"];
            }
            
            if ([dictionary objectForKey:@"imageHref"] != [NSNull null]) {
                NSString *strImgURLAsString = [dictionary objectForKey:@"imageHref"];
                [strImgURLAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *imgURL = [NSURL URLWithString:strImgURLAsString];
                dataModel.imageURL = imgURL;
            }
            
            [modelArray addObject:dataModel];
        }
    }
    
    return modelArray;
}

@end
