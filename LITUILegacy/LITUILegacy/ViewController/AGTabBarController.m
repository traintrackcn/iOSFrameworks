//
//  AGCommissionEarningsViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//
@import LITCommon;
@import LITUICommon;

#import "AGTabBarController.h"
#import "AGCollectionViewCellValue.h"
#import "AGTabBarCell.h"
#import "AGHorizontalViewControllersCell.h"
#import "AGVCConfiguration.h"


typedef NS_ENUM(NSInteger, Section) {
    SectionTabBar,
    SectionContent,
    SectionCount
};

@interface AGTabBarController (){
    
    
}

@end

@implementation AGTabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self.config setCellCls:[AGTabBarCell class] inSection:SectionTabBar];
        [self.config setCellCls:[AGHorizontalViewControllersCell class] inSection:SectionContent];
        
        
        CGFloat cellH = STYLE_DEVICE_HEIGHT - STYLE_STATUS_BAR_HEIGHT - STYLE_NAVIGATION_BAR_HEIGHT ;
        if ([self isSectionTabBarAvailable]) cellH -= [AGTabBarCell height];
        [self.config setCellHeight:cellH atFirstIndexPathInSection:SectionContent];
        
    }
    return self;
}


#pragma mark - table view stuff

//- (NSArray *)titleItems{
//    if (_titleItems) return _titleItems;
//    return titleValueArr;
//}
//
//- (NSArray *)contentItems{
//    if (_contentItems) return _contentItems;
//    return contentValueArr;
//}

- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    id value;
    
    if (section == SectionTabBar){
        value = self.titleItems;
    }
    
    if (section == SectionContent) {
        value = self.contentItems;
    }
    
    return value;
}

- (NSInteger)numberOfSections{
    return SectionCount;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section == SectionTabBar) {
        if ([self isSectionTabBarAvailable]) return 1;
    }
    if (section == SectionContent) return 1;
    return 0;
}

#pragma mark - 

- (BOOL)isSectionTabBarAvailable{
    return YES;
}

#pragma mark - events

- (void)tabBarDidChangeToIndex:(NSInteger)index{
    [self.contentCell selectIndexAndScrollToIndex:index];
}

- (void)contentDidChangeToIndex:(NSInteger)index{
    [self.tabBarCell setSelectedIndex:index];
}

#pragma mark - AGCellDelegate

- (void)action:(id)action atIndexPath:(NSIndexPath *)indexPath{
    //    TLOG(@"action -> %@", action);
    NSInteger section = indexPath.section;
//    NSString *type = [action objectForKey:@"type"];
    AGCollectionViewCellValue *value = [action objectForKey:@"value"];
    
    if (section == SectionContent){
        //        TLOG(@"make tab bar cell sync")
        [self contentDidChangeToIndex:value.index];
    }
    
    if (section == SectionTabBar){
        //        TLOG(@"make VCs cell sync");
        [self tabBarDidChangeToIndex:value.index];
    }
    
}


#pragma mark - properties

- (AGHorizontalViewControllersCell *)contentCell{
    return (AGHorizontalViewControllersCell *)[self cellAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SectionContent]];
}

- (AGTabBarCell *)tabBarCell{
    return (AGTabBarCell *)[self cellAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SectionTabBar]];
}

@end
