//
//  AGSectionLoader.m
//  AboveGEM
//
//  Created by Tao Yunfei on 3/10/16.
//
//

@import LITCommon;

#import "AGSectionLoader.h"
#import "AGSectionUnit.h"
#import "AGVCConfiguration.h"
//#import "GlobalDefine.h"

@interface AGSectionLoader(){
    
}



@end

@implementation AGSectionLoader

- (void)setCore:(id)core{
    TLOG(@"core -> %@ %@", core, self);
    _core = core;
    [_core setAssociatedSectionLoader:self];
}

#pragma mark -

- (void)setValue:(id)value atIndex:(NSInteger)index{
    [self.core setValue:value atIndex:index];
}

- (id)valueAtIndex:(NSInteger)index{
    return [(AGSectionUnit *)self.core valueAtIndex:index];
}

- (id)paramterAtIndex:(NSInteger)index{
    return [self.core paramterAtIndex:index];
}

- (void)action:(id)action atIndex:(NSInteger)index{
    [self.core action:action atIndex:index];
}

- (NSInteger)numberOfRows{
    NSInteger num = [self.core numberOfRows];
    TLOG(@"core -> %@ num -> %@", self.core, @(num));
    return num;
}

- (void)didSelect:(NSInteger)index{
    [self.core didSelect:index];
}

- (id)headerValue{
    return [self.core headerValue];
}

@end
