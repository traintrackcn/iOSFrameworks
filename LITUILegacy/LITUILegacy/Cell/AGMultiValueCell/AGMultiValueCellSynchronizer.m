//
//  AGMultiValueCellSynchronizer.m
//  AboveGEM
//
//  Created by traintrackcn on 5/1/15.
//
//

#import "AGMultiValueCellSynchronizer.h"
#import "AGMultiValueCell.h"
#import "AGMultiValueView.h"


@implementation AGMultiValueCellSynchronizer

+ (instancetype)instance{
    AGMultiValueCellSynchronizer *instance = [[AGMultiValueCellSynchronizer alloc] init];
    return instance;
}

#pragma mark - 


- (void)synchronizeByAction:(id)action tableView:(UITableView *)tableView targetIndexPath:(NSIndexPath *)targetIndexPath{
    NSString *actionType = [action objectForKey:@"type"];
    id targetCell = [tableView cellForRowAtIndexPath:targetIndexPath];
    NSInteger targetSection = targetIndexPath.section;
    
    if ([actionType isEqualToString:AGMultiValueCellContentOffsetDidChange]) {
        NSArray *cells = [tableView visibleCells];
        CGPoint contentOffset = [[action objectForKey:@"value"] CGPointValue];
        for (NSInteger i = 0; i<cells.count; i++) {
            UITableViewCell *cell = [cells objectAtIndex:i];
            if ([cell isEqual:targetCell]) continue;
            if (cell.indexPath.section != targetSection) continue;
            //            TLOG(@"cell -> %@", NSStringFromCGPoint(contentOffset));
            [[(AGMultiValueCell *)cell multiValueView] setContentOffset:contentOffset];
        }
        //        TLOG(@"============")
        [self setContentOffset:contentOffset];
    }
}

@end
