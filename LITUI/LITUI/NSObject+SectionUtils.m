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


#define KEY_SECTION_PREFIX @"KEY_SECTION_PREFIX"

@implementation NSObject (SectionUtils)

- (DASectionButton *)sectionButton:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    DASectionButton *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [DASectionButton instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:key ];
    }
    return item;
}


- (id)sectionItemWithClass:(Class)cls inSection:(NSInteger)section{
    id item = [self sectionInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:[self keyOfSection:section]];
    }
    return item;
    
}

- (id)sectionWithClass:(Class)cls withConfig:(AGVCConfiguration *)config inSection:(NSInteger)section{
    id item = [self sectionInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:config];
        [self.objPool setObject:item forKey:[self keyOfSection:section]];
    }
    return item;
}

- (id)sectionItemInSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    id item = [self.objPool objectForKey:key];
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
    NSString *key = [self keyOfSection:section];
    id item = [self.objPool objectForKey:key];
//    TLOG(@"key -> %@ item -> %@", key , item);
    return item;
}

- (void)resetSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [self.objPool removeObjectForKey:key];
}

#pragma mark - utils

- (NSString *)keyOfSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@_%@", KEY_SECTION_PREFIX, [NSNumber numberWithInteger:section]];

}

@end
