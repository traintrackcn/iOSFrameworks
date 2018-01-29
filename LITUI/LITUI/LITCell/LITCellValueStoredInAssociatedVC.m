//
//  LITCellValueStoredInAssociatedVC.m
//  AboveGEM
//
//  Created by Tao Yunfei on 19/09/2017.
//
//

@import LITCommon;

#import "LITCellValueStoredInAssociatedVC.h"
//#import "AGObjectPool.h"

@implementation LITCellValueStoredInAssociatedVC

- (void)setValue:(id)value{
    [self _setValue:value];
}

- (void)_setValue:(id)value{
    if (!value) return;
    [self.objPoolOfAssociatedVC setObject:value forKey:self.indexPath];
}

- (id)value{
    return [self.objPoolOfAssociatedVC objectForKey:self.indexPath];
}

@end
