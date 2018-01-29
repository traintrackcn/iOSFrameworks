//
//  AGViewController+Separator.m
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController+Separator.h"
#import "AGSeparatorCell.h"
#import "AGVCConfiguration.h"

@implementation AGViewController(Separator)


- (void)enableSeparators{
    for (NSInteger section = 0; section < [self numberOfSections]; section ++) {
        [self.config setSeparatorForSection:section];
    }
}

- (BOOL)isSeparatorCellAvailableInSection:(NSInteger)section{
    NSInteger numOfRowsInSection = [self numberOfRowsInSection:section];
    if (numOfRowsInSection == 0) return NO;
    return YES;
}

- (BOOL)isSeparatorCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    NSInteger numOfRowsInSection = [self numberOfRowsInSection:section];
    NSInteger separatorIdx = numOfRowsInSection;
    BOOL isSectionHasSeparator = [self.config separatorForSection:section];
    
    if (!isSectionHasSeparator) return NO;
    
    
    
    if (separatorIdx == 0) return NO;
    if (idx == separatorIdx) return YES;
    return NO;
}

- (AGSeparatorCell *)assembleSeparatorCell{
    AGSeparatorCell *cell = [[AGSeparatorCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AGSeparatorCell"];
    return cell;
}



@end
