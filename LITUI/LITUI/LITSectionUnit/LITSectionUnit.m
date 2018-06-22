//
//  LITSectionUnit.m
//  AboveGEM
//
//  Created by Tao Yunfei on 14/09/2017.
//
//

@import LITUILegacy;

#import "LITSectionUnit.h"

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

@end
