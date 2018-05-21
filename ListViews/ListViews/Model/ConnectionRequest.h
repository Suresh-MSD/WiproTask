//
//  ConnectionRequest.h
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionRequest : NSObject
+(void)fetchRequestDetails:(void (^)(NSDictionary *results, NSError *error))completion;
@end
