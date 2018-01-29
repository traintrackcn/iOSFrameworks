//
//  AGTextCellStyleMultiValues.h
//  AboveGEM
//
//  Created by traintrackcn on 31/12/14.
//
//

#import "AGCell.h"

extern NSString *AGMultiValueCellContentOffsetDidChange;
@class AGMultiValueView;

@interface AGMultiValueCell : AGCell{
    
}

+ (NSMutableArray *)assembleItemWithValues:(NSArray *)values;

@property (nonatomic, strong) AGMultiValueView *multiValueView;

@end
