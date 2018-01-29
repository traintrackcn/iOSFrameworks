//
//  NSObject+FileLoader.m
//  AGNetwork
//
//  Created by Tao Yunfei on 7/28/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "NSObject+FileLoader.h"

@implementation NSObject (FileLoader)

- (DAFileLoader *)fileLoader{
    NSString *key = CURRENT_FUNCTION_NAME;
    DAFileLoader *item = [self.objPool objectForKey:key];
    if (!item){
        item = [DAFileLoader instance];
        //        TLOG(@"self.objPool -> %@", self.objPool);
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

@end
