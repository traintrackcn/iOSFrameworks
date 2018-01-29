//
//  LITSectionButton.m
//  iPhone
//
//  Created by Tao Yunfei on 26/09/2017.
//

#import "LITSectionButton.h"
#import "LITCellForSectionButton.h"
#import "LITItemForSectionButton.h"
#import "LITCellSpaceAsBG.h"

typedef NS_ENUM(NSInteger, Cell) {
    CellSpace0,
    CellItem,
    CellSpace1,
    CellCount
};

@implementation LITSectionButton

- (NSInteger)numberOfRows{
//    TLOG(@"self.item.hidden -> %@ %@", @(self.item.hidden), self.item);
    if (self.item.hidden) return 0;
    return CellCount;
}

- (Class)clsAtIndex:(NSInteger)index{
    if (index == CellSpace0 || index == CellSpace1) return [LITCellSpaceAsBG class];
    return [LITCellForSectionButton class]; 
}

- (CGFloat)heightAtIndex:(NSInteger)index{
//    TLOG(@"self.item.paddingT -> %@ %@", @(self.item.paddingT), self.item);
    if (index == CellSpace0) return self.item.paddingT;
    if (index == CellSpace1) return self.item.paddingB;
    return [super heightAtIndex:index];
}

- (id)valueAtIndex:(NSInteger)index{
    return self.item;
}

@end
