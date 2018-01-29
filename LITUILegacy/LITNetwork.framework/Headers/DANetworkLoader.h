//
//  DANetworkLoader.h
//  AGNetwork
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

//@class AFHTTPClient;
@interface DANetworkLoader : NSObject

+ (instancetype)instance;

- (void)cancel;
- (void)enqueue:(AFHTTPRequestOperation *)operation;
- (void)enqueue:(AFHTTPRequestOperation *)operation hideActivityIndicator:(BOOL)hideActivityIndicator;
- (void)dequeue:(AFHTTPRequestOperation *)operation;
//@property (nonatomic, strong) AFHTTPClient *client;

@end
