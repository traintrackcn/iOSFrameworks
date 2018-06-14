//
//  DAFileLoader.m
//  AGNetwork
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//
@import LITCommon;
@import UIKit;

#import "DAFileLoader.h"
#import "AFHTTPRequestOperation.h"
//#import "GlobalDefine.h"
//#import "AFHTTPClient.h"

//#import "DAFileUtil.h"

@interface DAFileLoader(){
    
}

@end

@implementation DAFileLoader


- (void)REQUEST:(NSURL *)fileURL localURL:(NSURL *)localURL completion:(void(^)(id data, id error))completion{
    
//    if ([DA_FILE_UTIL isExistLocalURL:localURL]) {
//        NSData *data = [NSData dataWithContentsOfFile:localURL.absoluteString];
//        TLOG(@"[in cache] %@", localURL.absoluteString);
//        completion(data, nil);
//        return;
//    }
    
    
//    AFHTTPRequestOperation *operation = [self operationInstanceWithFileURL:fileURL localURL:localURL completion:completion];
//    [self.client enqueueHTTPRequestOperation:operation];
    
    AFHTTPRequestOperation *operation = [self operationInstanceWithFileURL:fileURL localURL:localURL completion:completion];
    [self enqueue:operation];
}

- (AFHTTPRequestOperation *)operationInstanceWithFileURL:(NSURL *)fileURL localURL:(NSURL *)localURL completion:(void(^)(id, id))completion{
    NSMutableURLRequest* rq = [NSMutableURLRequest requestWithURL:fileURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    
    //    NSString* path=[@"/PATH/TO/APP" stringByAppendingPathComponent: imageNameToDisk];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:localURL.absoluteString append:NO];
    [operation setOutputStream:outputStream];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
        TLOG(@"file completed %@", localURL.absoluteString);
        [self dequeue:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
        [self dequeue:operation];
    }];
    
//    [operation start];
    return operation;
}

#pragma mark -

- (void)REQUEST:(NSURL *)fileURL completion:(void(^)(id data, id error))completion{
    AFHTTPRequestOperation *operation = [self operationInstanceWithFileURL:fileURL completion:completion];
    [self enqueue:operation];
}

- (AFHTTPRequestOperation *)operationInstanceWithFileURL:(NSURL *)fileURL completion:(void(^)(id, id))completion{
    NSMutableURLRequest* rq = [NSMutableURLRequest requestWithURL:fileURL];
    [self setExtraHeadersForURLRequest:rq];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
//        TLOG(@"file completed %@", localURL.absoluteString);
        [self dequeue:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
        [self dequeue:operation];
    }];
    
    //    [operation start];
    return operation;
}

- (void)setExtraHeadersForURLRequest:(NSMutableURLRequest *)req{
    NSMutableDictionary *headers = self.headers;
    for (NSInteger i = 0; i<headers.allKeys.count; i++) {
        NSString *key = [headers.allKeys objectAtIndex:i];
        NSString *value = [headers valueForKey:key];
        [req setValue:value forHTTPHeaderField:key];
    }
}

#pragma mark - headers

- (id)headers{
    return nil;
}

@end
