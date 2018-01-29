//
//  DANetworkLoader.m
//  AGNetwork
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DANetworkLoader.h"
//#import "GlobalDefine.h"
//#import "AFHTTPClient.h"
#import "AGNetworkDefine.h"
#import "AFHTTPRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface DANetworkLoader(){
    
}

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation DANetworkLoader

+ (instancetype)instance{
    return [[self.class alloc] init];
}

+ (void)initialize{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

#pragma mark - lifecycle

- (void)dealloc{
//    TLOG(@"");
    [self cancel];
}

#pragma mark - op

- (void)cancel{
    while (self.queue.count > 0) {
        AFHTTPRequestOperation *operation = self.queue.firstObject;
        [self dequeue:operation];
    }
}



- (void)enqueue:(AFHTTPRequestOperation *)operation{
    [self enqueue:operation hideActivityIndicator:NO];
    
}

- (void)enqueue:(AFHTTPRequestOperation *)operation hideActivityIndicator:(BOOL)hideActivityIndicator{
    [self.queue addObject:operation];
    if (NETWORK.allowInvalidSSL) [operation setSecurityPolicy:self.securityPolicy];
    
    if (hideActivityIndicator){
        [operation setUserInfo:@{
                                 @"hide-activity-indicator":@(YES)
                                 }];
    }
    
    [operation start];
}

- (id)securityPolicy{
    AFSecurityPolicy *policy= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
//    [policy setValidatesCertificateChain:NO];
//    operation.securityPolicy=sec;
    return policy;
}

- (void)dequeue:(AFHTTPRequestOperation *)operation{
    if ([self.queue containsObject:operation]) {
        [self.queue removeObject:operation];
        [operation cancel];
        
        operation = nil;
    }
}

#pragma mark - properties

- (NSMutableArray *)queue{
    if (!_queue) {
        _queue = [NSMutableArray array];
    }
    return _queue;
}

//- (AFHTTPClient *)client{
//    if (!_client) {
//        NSURL *baseURL = [NSURL URLWithString:@""];
//        _client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
//        if (AG_NETWORK_DEFINE.allowInvalidSSL){
//            TLOG(@"allow invalid certificate");
//            [_client setAllowsInvalidSSLCertificate:YES];
//        }
//    }
//    return _client;
//}

@end
