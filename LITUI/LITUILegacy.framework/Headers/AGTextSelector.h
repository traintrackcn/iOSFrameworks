//
//  DSSelector.h
//  og
//
//  Created by traintrackcn on 12/19/13.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGViewController.h"

@protocol AGTextSelectorDelegate <NSObject>

@optional
- (NSString *)titleForTextSelectorItem:(id)item;
- (NSArray *)textSelectorWillSortArray:(NSArray *)array;

@end

//@class AGVCConfiguration;
@interface AGTextSelector : AGViewController

+ (instancetype)instance;
+ (instancetype)instanceWithDelegate:(id<AGTextSelectorDelegate>)aDelegate;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (void)setItemsWithoutSort:(NSArray *)items;

@property (nonatomic, weak) NSArray *items;
@property (nonatomic, assign) Class cellCls;
//@property (nonatomic, assign) BOOL needsReloadPreviousVC;




@end
