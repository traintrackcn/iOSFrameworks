//
//  AGForm.h
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

//#import "AGModel.h"
@import LITCommon;

enum{
    AGIndexInvalid = -1,
    AGIndexDefault
};


@class AGViewController;
@class AGSectionUnit;

@interface AGVCConfiguration : AGModel{
}

//in [one cell one section] condition
- (void)autofitSpaceCellHeightInSection:(NSInteger)section statusBar:(BOOL)statusBar naviBar:(BOOL)naviBar;

#pragma mark - input properties' dic

- (void)clearSettingsForSection:(NSInteger)section;

- (void)setCellOptionalAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isCellOptionalAtIndexPath:(NSIndexPath *)indexPath;

//- (void)resetCellCls;
- (void)setCellCls:(Class)cls inSection:(NSInteger)section;

- (void)setCellCls:(Class)cls atIndexPath:(NSIndexPath *)indexPath;
- (void)setCellCls:(Class)cls atIndex:(NSInteger)idx inSection:(NSInteger)section;
- (Class)cellClsOfIndexPath:(NSIndexPath *)indexPath;

- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (void)setCellHeight:(CGFloat)height atFirstIndexPathInSection:(NSInteger)section;
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath forValue:(id)value;
//- (BOOL)cellHeightCalculatedAtIndexPath:(NSIndexPath *)indexPath;

//- (void)setCellDynamicHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)cellDynamicHeightAtIndexPath:(NSIndexPath *)indexPath;

- (void)setCellTitle:(NSString *)title inSection:(NSInteger)section;

- (void)setCellTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cellTitleOfIndexPath:(NSIndexPath *)indexPath;

- (void)setHeaderCls:(Class)cls forSection:(NSInteger)section;
- (Class)headerClsOfSection:(NSInteger)section;

- (void)setSeparatorForSection:(NSInteger)section;
- (void)removeSeparatorForSection:(NSInteger)section;
- (BOOL)separatorForSection:(NSInteger)section;

- (void)setSectionUnit:(AGSectionUnit *)unit;
- (AGSectionUnit *)unitOfSection:(NSInteger)section;

@property (nonatomic, weak) AGViewController *target;

//- (UITableViewCell *)currentCell;

//@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
