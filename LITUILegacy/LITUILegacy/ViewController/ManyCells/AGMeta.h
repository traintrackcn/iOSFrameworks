//
//  AGMeta.h
//  AboveGEM
//
//  Created by traintrackcn on 22/9/14.
//
//

//#import "AGModel.h"
@import LITCommon;

@interface AGMeta : AGModel

- (BOOL)next;
- (BOOL)hasNext;
- (void)previous; //for requeset excpetion
- (void)reset;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;

@end
