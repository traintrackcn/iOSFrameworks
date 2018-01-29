//
//  AGMultiHeaderView.m
//  AboveGEM
//
//  Created by traintrackcn on 3/2/15.
//
//

#import "AGMultiHeaderView.h"
#import "AGCollectionViewCellOfMultiHeaderCell.h"

@implementation AGMultiHeaderView

- (Class)collectionViewCellCls{
    return [AGCollectionViewCellOfMultiHeaderCell class];
}

@end
