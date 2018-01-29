//
//  LITAsset.m
//  AboveGEM
//
//  Created by Tao Yunfei on 04/09/2017.
//
//

#import "LITAsset.h"

@implementation LITAsset

- (void)updateWithRaw:(id)raw{
    [self setRaw:raw];
    
    if ([self isAvailableForKey:@"assetId"]){
        [self setIdentifier:[self stringForKey:@"assetId"]];
    }
    
    if ([self isAvailableForKey:@"assetUrl"]){
        [self setUrlStr:[self stringForKey:@"assetUrl"]];
        [self setUrl:[NSURL URLWithString:self.urlStr]];
    }
    
}

@end
