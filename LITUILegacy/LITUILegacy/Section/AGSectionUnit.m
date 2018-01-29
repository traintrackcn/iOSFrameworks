//
//  AGSection.m
//  AboveGEM
//
//  Created by traintrackcn on 15/1/15.
//
//

#import "AGSectionUnit.h"
#import "AGVCConfiguration.h"
#import "AGHeaderViewStyleDefault.h"

@interface AGSectionUnit(){
    
}

@property (nonatomic, weak) AGVCConfiguration *config;
@property (nonatomic, assign) NSInteger section;

@end

@implementation AGSectionUnit


+ (instancetype)instanceWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    return [[self.class alloc] initWithSection:section config:config];
}

- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    self = [super init];
    if (self) {
        [self setConfig:config];
        [self setSection:section];
        [self setReadonly:NO];
        [config setSectionUnit:self];
        [self setAssociatedVC:self.config.target];
    }
    return self;
}

- (id)valueAtIndex:(NSInteger)index{
    return nil;
}

- (id)titleAtIndex:(NSInteger)index{
    return nil;
}

- (Class)clsAtIndex:(NSInteger)index{
    return nil;
}

- (Class)headerCls{
    if (!self.numberOfRows) return nil;
    return [AGHeaderViewStyleDefault class];
}



- (id)paramterAtIndex:(NSInteger)index{
    return nil;
}

- (id)parameterAtIndex:(NSInteger)index{
    return [self paramterAtIndex:index];
}

- (CGFloat)heightAtIndex:(NSInteger)index{
    return NSNotFound;
}

- (BOOL)visibilityAtIndex:(NSInteger)index{
    return YES;
}

- (void)action:(id)action atIndex:(NSInteger)index{
     
}

- (void)setValue:(id)value atIndex:(NSInteger)index{
    
}



- (NSInteger)numberOfRows{
    return 0;
}

- (id)headerValue{
    return nil;
}

- (id)headerTitle{
    return nil;
}

- (void)didSelect:(NSInteger)index{
    
}

//- (Class)headerClass{
//    return [AGHeaderViewStyleDefault class];
//}

#pragma mark - properties

- (AGViewController *)associatedViewController{
    return self.associatedVC;
}

@end
