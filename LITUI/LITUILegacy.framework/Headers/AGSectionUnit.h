//
//  AGSection.h
//  AboveGEM
//
//  Created by traintrackcn on 15/1/15.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
@import LITCommon;
//#import "GlobalDefine.h"

@class AGVCConfiguration;
@class AGViewController;
@class AGSectionLoader;


@interface AGSectionUnit : NSObject

+ (instancetype)instanceWithSection:(NSInteger)section config:(AGVCConfiguration *)config;
- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config;

- (void)setValue:(id)value atIndex:(NSInteger)index;
- (id)valueAtIndex:(NSInteger)index;
- (id)titleAtIndex:(NSInteger)index;
- (Class)clsAtIndex:(NSInteger)index;
- (CGFloat)heightAtIndex:(NSInteger)index;
- (BOOL)visibilityAtIndex:(NSInteger)index;
- (id)paramterAtIndex:(NSInteger)index DEPRECATED_WITH_MSG("use parameterAtIndex instead");
- (id)parameterAtIndex:(NSInteger)index;
- (void)action:(id)action atIndex:(NSInteger)index;
- (NSInteger)numberOfRows;
- (void)didSelect:(NSInteger)index;

- (id)headerTitle;
- (id)headerValue;
- (id)headerCls;

- (AGVCConfiguration *)config;
- (NSInteger)section;
- (id)associatedViewController DEPRECATED_MSG_ATTRIBUTE("use associatedVC inst"); 

@property (nonatomic, assign) BOOL readonly;
@property (nonatomic, weak) id associatedVC;

@property (nonatomic, weak) AGSectionLoader *associatedSectionLoader;

@end
