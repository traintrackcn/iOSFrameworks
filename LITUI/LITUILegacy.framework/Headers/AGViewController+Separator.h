//
//  AGViewController+Separator.h
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController.h"

@class AGSeparatorCell;
@interface AGViewController(Separator)

- (void)enableSeparators;
- (BOOL)isSeparatorCellAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isSeparatorCellAvailableInSection:(NSInteger)section;
- (AGSeparatorCell *)assembleSeparatorCell;

@end
