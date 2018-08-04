//
//  AGViewController+SectionComponents.m
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;
@import LITUILegacy;

#import "NSObject+SectionUtils.h"
#import "LITSectionUnit.h"
#import "LITCell.h"
#import "LITVC.h"
#import "LITVCCore.h"


#define KEY_SECTION_PREFIX @"KEY_SECTION_PREFIX"
#define KEY_SECTION_DIC @"KEY_SECTION_DIC"

@implementation NSObject (SectionUtils)

- (DASectionButton *)sectionButton:(NSInteger)section{
//    NSString *key = [self keyOfSection:section];
    id key = @(section);
    DASectionButton *item = [self.sectionDic objectForKey:key];
    if (!item) {
        item = [DASectionButton instanceWithSection:section config:self.config];
        [self.sectionDic setObject:item forKey:key ];
    }
    return item;
}



#pragma mark -




- (id)sectionItemWithClass:(Class)cls inSection:(NSInteger)section{
    id item = [self sectionInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:self.config];
        [self.sectionDic setObject:item forKey:@(section)];
    }
    return item;
    
}

- (id)sectionWithClass:(Class)cls withConfig:(AGVCConfiguration *)config inSection:(NSInteger)section{
    id item = [self sectionInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:config];
        [self.sectionDic setObject:item forKey:@(section)];
    }
    return item;
}

#pragma mark - LIT stuff

- (id)sectionWithClass:(Class)cls inSection:(NSInteger)section{
    LITSectionUnit *s = [self sectionWithClass:cls withConfig:self.config inSection:section];
    
    if ([self isKindOfClass:[LITCell class]]){
        [s setAssociatedVC:[(LITCell *)self associatedVC]];
    }else if ([self isKindOfClass:[LITVC class]]) {
        [s setAssociatedVC:self];
    }
    
    
    return s;
//    return [self sectionWithClass:cls withConfig:self.config inSection:section];
}

- (id)sectionInSection:(NSInteger)section{
//    NSString *key = [self keyOfSection:section];
    id item = [self.sectionDic objectForKey:@(section)];
//    TLOG(@"key -> %@ item -> %@", key , item);
    return item;
}

- (void)resetSection:(NSInteger)section{
//    NSString *key = [self keyOfSection:section];
    [self.sectionDic removeObjectForKey:@(section)];
}

- (void)resetSections{
    [self.objPool removeObjectForKey:KEY_SECTION_DIC];
}

#pragma mark -

- (NSMutableDictionary *)sectionDic{
    id dic = [self.objPool objectForKey:KEY_SECTION_DIC];
    if (!dic){
        dic = [NSMutableDictionary dictionary];
        [self.objPool setObject:dic forKey:KEY_SECTION_DIC];
    }
    return dic;
}


#pragma mark - utils

//- (NSString *)keyOfSection:(NSInteger)section{
//    return [NSString stringWithFormat:@"%@_%@", KEY_SECTION_PREFIX, [NSNumber numberWithInteger:section]];
//
//}

@end
