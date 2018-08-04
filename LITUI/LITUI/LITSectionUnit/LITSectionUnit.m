//
//  LITSectionUnit.m
//  AboveGEM
//
//  Created by Tao Yunfei on 14/09/2017.
//
//

@import LITUILegacy;

#import "LITSectionUnit.h"

@interface LITSectionUnit()

@property (nonatomic, strong) AGObjectPool *objPool;

@end

@implementation LITSectionUnit

- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    self = [super initWithSection:section config:config];
    if (self) {
//        _ws = self;
    }
    return self;
}

- (id)headerCls{
    return nil;
}

- (void)reload:(BOOL)animated{
//    TLOG(@"self.associatedVC -> %@ section -> %@", self.associatedVC, @(self.section));
    [self.associatedVC reloadVisibleIndexPathsInSection:self.section animated:animated];
}

#pragma mark - properties

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

@end
