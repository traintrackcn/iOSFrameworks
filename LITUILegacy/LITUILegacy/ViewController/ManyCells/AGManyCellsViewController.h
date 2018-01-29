//
//  AGManyItemsViewController.h
//  AboveGEM
//
//  Created by traintrackcn on 29/10/14.
//
//

#import "AGViewController.h"

@class AGMeta;
@class AGRemoteUnit;

@interface AGManyCellsViewController : AGViewController{
    NSMutableArray *items;
    AGMeta *meta;
    BOOL isLoadingMoreItems;
}

- (AGRemoteUnit *)assembleRUnitForData;
- (void)didLoadData:(id)data;

- (CGFloat )heightOfItemCell;

- (NSInteger)SectionItem;
- (NSInteger)SectionItemExtra;

- (id)valueOfSectionItemExtraAtIndex:(NSInteger)index;

- (void)reset;
- (NSArray *)itemsRawOfResponseData:(id)responseData;

@end
