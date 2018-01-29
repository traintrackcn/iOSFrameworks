//
//  DASectionButton.m
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DASectionButton.h"
#import "DAButtonCell.h"
#import "DAButtonItem.h"
#import "DACell.h"
#import "AGVCConfiguration.h"


typedef NS_ENUM(NSInteger, SectionCell) {
    SectionCellSeparator1,
    SectionCellButton,
    SectionCellSeparator2,
    SectionCellCount
};

@implementation DASectionButton

@synthesize paddingT = _paddingT;
@synthesize paddingB = _paddingB;

- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    self = [super initWithSection:section config:config];
    if (self) {
        
        
        [self.config setCellCls:[DACell class] inSection:section];
        [self.config setCellCls:[DAButtonCell class] atIndexPath:[NSIndexPath indexPathForRow:SectionCellButton inSection:section]];
        
        [self setPaddingT:NSNotFound];
        [self setPaddingB:NSNotFound];
        
    }
    return self;
}

- (NSInteger)numberOfRows{
    return SectionCellCount;
}

- (id)headerCls{
    return nil;
}

- (id)valueAtIndex:(NSInteger)index{
    id value;
    if (index == SectionCellButton) {
//        TLOG(@"self.value -> %@", self.value);
        value = (DAButtonItem *)self.item;
    }
    return value;
}

#pragma mark - setters

- (void)setDisabled:(BOOL)disabled{
    _disabled = disabled;
}

- (void)setPaddingT:(NSInteger)paddingT{
    _paddingT = paddingT;
    [self.config setCellHeight:self.paddingT atIndexPath:[NSIndexPath indexPathForRow:SectionCellSeparator1 inSection:self.section]];
}

- (void)setPaddingB:(NSInteger)paddingB{
    _paddingB = paddingB;
    [self.config setCellHeight:self.paddingB atIndexPath:[NSIndexPath indexPathForRow:SectionCellSeparator2 inSection:self.section]];
}

#pragma mark - styles

- (NSInteger)paddingT{
    if (_paddingT == NSNotFound) return 8.0;
    return _paddingT;
}

- (NSInteger)paddingB{
    if (_paddingB == NSNotFound) return 8.0;
    return _paddingB;
}

- (id)paramterAtIndex:(NSInteger)index{
    if(index == SectionCellButton){
        return [NSNumber numberWithBool:self.disabled];
    }
    return nil;
}

@end
