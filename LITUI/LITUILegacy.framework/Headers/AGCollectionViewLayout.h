//
//  AGCollectionViewLayout.h
//  AboveGEM
//
//  Created by traintrackcn on 10/12/14.
//
//

#import <UIKit/UIKit.h>

@interface AGCollectionViewLayout : UICollectionViewLayout

- (id)initWithCellSize:(CGSize)size;

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGFloat cellHSpace;
@property (nonatomic, assign) CGFloat cellVSpace;
@property (nonatomic, assign) CGFloat paddingLR;
@property (nonatomic, strong) NSMutableDictionary *cellAttributes;

@end
