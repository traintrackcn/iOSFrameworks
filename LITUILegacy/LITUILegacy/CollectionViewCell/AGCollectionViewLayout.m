//
//  AGCollectionViewLayout.m
//  AboveGEM
//
//  Created by traintrackcn on 10/12/14.
//
//

#import "AGCollectionViewLayout.h"

@implementation AGCollectionViewLayout

- (id)initWithCellSize:(CGSize)size{
    self = [super init];
    if (self){
        [self setCellSize:size];
    }
    return self;
}

#pragma mark - properties

- (NSMutableDictionary *)cellAttributes{
    if (!_cellAttributes){
        _cellAttributes = [NSMutableDictionary dictionary];
    }
    return _cellAttributes;
}

@end
