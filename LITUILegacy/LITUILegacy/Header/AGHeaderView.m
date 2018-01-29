//
//  AGHeader.m
//  AboveGEM
//
//  Created by traintrackcn on 21/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGHeaderView.h"
#import "AGViewController.h"
#import "AGCell.h"

@implementation AGHeaderView


#pragma mark - 

- (void)_setValue:(id)value{
    _value = value;
}

#pragma mark - interactive ops

- (void)didTapAny:(id)sender{
    [self didTap:nil];
}

- (void)didTap:(id)sender{
    
}

#pragma mark - properties

//- (UITableView *)tableView{
//    if ([self.associatedViewController isKindOfClass:[AGViewController class]]) {
//        return [(AGViewController *)self.associatedViewController tableView];
//    }
//    return nil;
//}

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}


#pragma mark - properties

- (NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForRow:NSNotFound inSection:self.section];
}

#pragma mark - styles

+ (CGFloat)height{
    return 44.0;
}

- (CGFloat)height{
    if (_height) return _height;
    return [self.class height];
}

@end
