//
//  AGMultiValueCellSynchronizer.h
//  AboveGEM
//
//  Created by traintrackcn on 5/1/15.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface AGMultiValueCellSynchronizer : NSObject

+ (instancetype)instance;
- (void)synchronizeByAction:(id)action tableView:(UITableView *)tableView targetIndexPath:(NSIndexPath *)targetIndexPath;

@property (nonatomic, assign) CGPoint contentOffset;

@end
