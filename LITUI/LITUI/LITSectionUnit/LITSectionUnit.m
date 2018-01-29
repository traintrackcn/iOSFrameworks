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

- (id)headerCls{
    return nil;
}

- (void)reload:(BOOL)animated{
//    TLOG(@"self.associatedVC -> %@ section -> %@", self.associatedVC, @(self.section));
    [self.associatedVC reloadVisibleIndexPathsInSection:self.section animated:animated];
}

@end
