//
//  NSObject+ObjPool.h
//  AGUIKit
//
//  Created by Tao Yunfei on 6/15/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGObjectPool;

@interface NSObject (ObjPool)

- (AGObjectPool *)objPool;

@end
