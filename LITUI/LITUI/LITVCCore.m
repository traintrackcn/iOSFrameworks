//
//  LITVCCore.m
//  iPhone
//
//  Created by Tao Yunfei on 15/10/2017.
//

@import LITCommon;
@import LITUILegacy;

#import "LITVCCore.h"

@interface LITVCCore ()

@property (nonatomic, strong) NSMutableDictionary *cellHs;

@end

@implementation LITVCCore

- (void)setCellH:(NSNumber *)h atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [self.cellHs setObject:h forKey:key];
//    TLOG(@"cellHs -> %@", self.cellHs);
}

- (NSNumber *)cellHAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    return [self.cellHs objectForKey:key];
}

#pragma mark - utils

- (NSString *)keyOfIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
}

#pragma mark - properties

- (NSMutableDictionary *)cellHs{
    if (!_cellHs) {
        _cellHs = [NSMutableDictionary dictionary];
    }
    return _cellHs;
}

@end
