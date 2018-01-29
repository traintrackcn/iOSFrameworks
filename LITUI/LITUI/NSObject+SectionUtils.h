//
//  AGViewController+SectionComponents.h
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

//#import "GlobalDefine.h"
#import <Foundation/Foundation.h>

@class DASectionButton;
@class AGVCConfiguration;
@interface NSObject (SectionUtils)

//- (NSString *)keyOfSection:(NSInteger)section;
- (DASectionButton *)sectionButton:(NSInteger)section;
- (id)sectionItemWithClass:(Class)cls inSection:(NSInteger)section DEPRECATED_WITH_MSG("Use sectionWithClass:inSection: instead");
- (id)sectionItemInSection:(NSInteger)section; DEPRECATED_WITH_MSG("Use sectionInSection:inSection: instead");
- (id)sectionWithClass:(Class)cls withConfig:(AGVCConfiguration *)config inSection:(NSInteger)section DEPRECATED;


- (id)sectionWithClass:(Class)cls inSection:(NSInteger)section;
- (id)sectionInSection:(NSInteger)section;
- (void)resetSection:(NSInteger)section;

@end
