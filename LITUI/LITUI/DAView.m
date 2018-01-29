//
//  DAView.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/22/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DAView.h"
//#import "AGObjectPool.h"

@implementation DAView

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

@end
