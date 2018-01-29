//
//  AGCollectionViewCell.m
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITNetwork;

#import "AGCollectionViewCell.h"

@interface AGCollectionViewCell()

@end

@implementation AGCollectionViewCell


#pragma mark - properties

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
    }
    return _objPool;
}

@end
