//
//  AGMeta.m
//  AboveGEM
//
//  Created by traintrackcn on 22/9/14.
//
//

@import LITCommon;

#import "AGMeta.h"
//#import "GlobalDefine.h"

@implementation AGMeta


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setCount:NSNotFound]; // NSNotFound means meta has never been updated
    }
    return self;
}

- (void)updateWithRaw:(id)raw{
    [self setRaw:raw];
    
//    TLOG(@"raw -> %@", raw);
    
    if ([self isAvailableForKey:@"count"]) {
        id rawCount = [self objectForKey:@"count"];
        
        if ([rawCount isKindOfClass:[NSNumber class]]) {
            [self setCount:[self integerForKey:@"count"]];
        }else if([rawCount isKindOfClass:[NSDictionary class]]){
            [self setCount:[[(NSDictionary *)rawCount allValues].firstObject integerValue]];
        }
        
//        TLOG(@"count -> %d rawCount -> %@", self.count, rawCount);
    }
    
    if ([self isAvailableForKey:@"offset"]) {
        [self setOffset:[[raw objectForKey:@"offset"] integerValue]];
    }
    
    if ([self isAvailableForKey:@"limit"]) {
        [self setLimit:[[raw objectForKey:@"limit"] integerValue]];
    }
    
}

- (BOOL)hasNeverBeenUpdated{
    if (self.count == NSNotFound) return YES;
    return NO;
}

- (void)reset{
    [self setCount:NSNotFound];
}

#pragma mark - ops

- (BOOL)hasNext{
    if (self.hasNeverBeenUpdated) return YES;
    NSInteger nextOffset = self.offset + self.limit;
    if (nextOffset >= self.count) return NO;
    return YES;
}

- (BOOL)next{
    
//    TLOG(@"[self hasNeverBeenUpdated] -> %d self.count -> %ld",[self hasNeverBeenUpdated], self.count);
    
    if ([self hasNeverBeenUpdated]) {
        [self setOffset:0];
        return YES;
    }
    
    NSInteger nextOffset = self.offset + self.limit;
    
    if (nextOffset >= self.count) return NO;
    
    self.offset = nextOffset;
    return YES;
}

- (void)previous{
    NSInteger previousOffset = self.offset - self.limit;
    if (previousOffset < 0 ) {
        previousOffset = 0;
    }
    
    [self setOffset:previousOffset];
}

@end
