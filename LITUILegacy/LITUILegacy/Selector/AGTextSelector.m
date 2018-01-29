//
//  DSRegistrationCountrySelector.m
//  og
//
//  Created by traintrackcn on 12/11/13.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGTextSelector.h"
//#import "AGModel.h"
#import "AGViewController.h"
#import "AGVCConfiguration.h"
#import "AGSelectorItem.h"
//#import "DSValueUtil.h"
#import "AGButtonCell.h"
#import "AGButtonItem.h"
//#import "GlobalDefine.h"
#import "AGTextCellStyleTitleOnly.h"


@interface AGTextSelector(){
    NSArray *itemsFirstLettersSorted;
    NSArray *itemsSorted;
//    UITableView *tableV;
//    UILabel *titleV;
//    UIView *layoutV;
}

@property (nonatomic, weak) id<AGTextSelectorDelegate> delegate;

@end


@implementation AGTextSelector

+ (instancetype)instance{
    return [[self.class alloc] init];
}

+ (instancetype)instanceWithDelegate:(id<AGTextSelectorDelegate>)aDelegate{
    AGTextSelector *instance = [[self.class alloc] init];
    [instance setDelegate:aDelegate];
    return instance;
}

#pragma mark - setters

- (void)setItemsWithoutSort:(NSArray *)items{
    _items = items;
    itemsSorted = [NSMutableArray arrayWithObject:items];
    for (NSInteger section = 0; section < self.SectionCount; section++) {
        [self.config setCellCls:[AGTextCellStyleTitleOnly class] inSection:section];
    }
    
    
    [self reloadVisibleIndexPaths];

}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self sortItems];
    
//    TLOG(@"SectionCount -> %d", self.SectionCount);
//    TLOG(@"itemsSorted -> %@", itemsSorted);
    
    for (NSInteger section = 0; section < self.SectionCount; section++) {
        [self.config setCellCls:[AGTextCellStyleTitleOnly class] inSection:section];
    }
    
    
    [self reloadVisibleIndexPaths];
}

#pragma mark - Sections

- (NSInteger)SectionCount{
    return itemsSorted.count;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSections{
    return self.SectionCount;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSArray *tmpItems = [itemsSorted objectAtIndex:section];
    return tmpItems.count;
}



- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = indexPath.section;
    id value;
    
    value = [self titleAtIndexPath:indexPath];
    
//    TLOG(@"value -> %@", value);
    
    return value;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return itemsFirstLettersSorted;
}

#pragma mark - properties

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id nowValue = [self itemAtIndexPath:indexPath];
    [self setValueForAssociatedIndexPath:nowValue];
    [self setNeedsReloadAssociatedIndexPath];
    
//    if (self.needsReloadPreviousVC){
//        [self.previousViewController setNeedsReloadAll];
//    }else{
//        [self.previousViewController setFlagDoReload:YES];
//    }
        
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    NSArray *tmpItems = [itemsSorted objectAtIndex:section];
    return [DSValueUtil itemAtIndex:index inArray:tmpItems];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    return [self titleOfItem:item];
}

- (NSString *)titleOfItem:(id)item{
    NSString *title = @"";
//    TLOG(@"_delegate -> %@", _delegate);
//    TLOG(@"_delegate -> %@ %@", _delegate, [_delegate titleForTextSelectorItem:item]);
    if (_delegate && [_delegate respondsToSelector:@selector(titleForTextSelectorItem:)]){
        title = [_delegate titleForTextSelectorItem:item];
    }else if ([item respondsToSelector:@selector(name)]) {
        title = [(AGSelectorItem *)item name];
    }else if ([item respondsToSelector:@selector(key)]) {
        title = [(AGSelectorItem *)item key];
    }else if ([item respondsToSelector:@selector(optionText)]) {
        title = [(AGSelectorItem *)item optionText];
    }
    
    return title;
}

#pragma mark - sorters

- (void)sortItems{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    for (int i=0; i<self.items.count; i++) {
        id item = [self.items objectAtIndex:i];
        NSString *firstLetter;
        NSString *title = [self titleOfItem:item];
//        TLOG(@"title -> %@", title);
        if (title) {
            firstLetter = [title substringWithRange:NSMakeRange(0, 1)];
        }else{
            firstLetter = @"";
        }
        

        NSMutableArray *arrWithTheFirstLetter = [d objectForKey:firstLetter];
        BOOL alreadyHasTheArr = [DSValueUtil isAvailable:arrWithTheFirstLetter];
        
        if (!alreadyHasTheArr) {
            arrWithTheFirstLetter = [NSMutableArray array];
            [d setObject:arrWithTheFirstLetter forKey:firstLetter];
        }
        
        [arrWithTheFirstLetter addObject:item];
        
    }
    
    
    //
    
//    arrWithTheFirstLetter = [arrWithTheFirstLetter sortedArrayUsingSelector:@selector(compare:)];
    
    
    //
    
    NSArray *tmpFirstLetters = [d allKeys];
    NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *sortDesArr = [NSArray arrayWithObject:sortDes];
    //    LOG_DEBUG(@"items -> %@", items);
//    items = [items sortedArrayUsingDescriptors:sortDesArr];
    itemsFirstLettersSorted = [tmpFirstLetters sortedArrayUsingDescriptors:sortDesArr];
//    TLOG(@"itemsFirstLettersSorted -> %@", itemsFirstLettersSorted);
    
    NSMutableArray *tmpItemsSorted = [NSMutableArray arrayWithCapacity:itemsFirstLettersSorted.count];
    for (int i=0; i<itemsFirstLettersSorted.count; i++) {
        NSString *firstLetter = [itemsFirstLettersSorted objectAtIndex:i];
        NSArray *arrWithTheFirstLetter = [d objectForKey:firstLetter];
        
        if (_delegate && [_delegate respondsToSelector:@selector(textSelectorWillSortArray:)]){
            arrWithTheFirstLetter = [_delegate textSelectorWillSortArray:arrWithTheFirstLetter];
        }
        
//        TLOG(@"arrWithTheFirstLetter -> %@", arrWithTheFirstLetter);
        [tmpItemsSorted addObject:arrWithTheFirstLetter];
    }
    
    itemsSorted  = tmpItemsSorted;
//    TLOG(@"itemsSorted -> %@", itemsSorted);

}



#pragma mark - interactive actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
