//
//  ConnectionRequest.m
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import "ConnectionRequest.h"

@implementation ConnectionRequest

static NSString *URL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

+(void)fetchRequestDetails:(void (^)(NSDictionary *results, NSError *error))completion {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //Convert as UTF8 before parsing
        NSError* error = nil;
        NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        NSData *dataUTF8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:0 error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (json != nil) {
                completion(json, nil);
            } else {
                NSLog(@"error: %@", error);
                completion(nil, error);
            }
        });
    }];
}

@end
