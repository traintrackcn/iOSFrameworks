//
//  LITCollectionLayoutGridItems.h
//  AboveGEM
//
//  Created by Tao Yunfei on 19/09/2017.
//
//

#import "LITCollectionLayout.h"

@interface LITCollectionLayoutFullGridItems : LITCollectionLayout

- (void)setItemsPerLine:(NSInteger)itemsPerLine withItemHeight:(CGFloat)itemH;

@property (nonatomic, assign) CGFloat hSpace;
@property (nonatomic, assign) CGFloat vSpace;
@property (nonatomic, assign) CGFloat collectionW;

@end
