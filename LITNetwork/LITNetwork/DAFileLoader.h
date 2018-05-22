//
//  DAFileLoader.h
//  AGNetwork
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DANetworkLoader.h"
//#import "NSObject+Singleton.h"

#define DA_FILE_LOADER [DAFileLoader singleton]

@interface DAFileLoader : DANetworkLoader

- (void)REQUEST:(NSURL *)fileURL localURL:(NSURL *)localURL completion:(void(^)(id data, id error))completion;

- (void)REQUEST:(NSURL *)fileURL completion:(void(^)(id data, id error))completion;

@end
