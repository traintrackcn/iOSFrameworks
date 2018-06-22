//
//  NSObject+LITJSONLoader.m
//  LITNetwork
//
//  Created by traintrackcn on 2018/6/18.
//  Copyright © 2018 abovegem. All rights reserved.
//

#import "NSObject+LITJSONLoader.h"

@import LITCommon;

@implementation NSObject (LITJSONLoader)

- (NSMutableDictionary *)jsonLoaders{
    NSString *key = @"KEY_JSON_LOADERS";
    NSMutableDictionary *item = [self.objPool objectForKey:key];
    if (!item){
        item = [NSMutableDictionary dictionary];
        //        TLOG(@"self.objPool -> %@", self.objPool);
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

@end
