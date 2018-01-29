//
//  AGObjectPool.h
//  AGUIKit
//
//  Created by Tao Yunfei on 11/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGModel.h"

@interface AGObjectPool : AGModel

- (nonnull id)objectForKey:(nonnull id<NSCopying>)key;
- (void)setObject:(nullable id)object forKey:(nonnull id<NSCopying>)key;
- (void)removeObjectForKey:(nonnull id<NSCopying>)key;
- (NSDictionary *)allDic;

@property (nonatomic, copy , nullable) NSString *parentClassName;

@end
