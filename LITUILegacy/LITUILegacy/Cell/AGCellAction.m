//
//  AGCellAction.m
//  AboveGEM
//
//  Created by traintrackcn on 13/1/15.
//
//

#import "AGCellAction.h"

@implementation AGCellAction

+ (instancetype)instanceWithType:(NSString *)type userInfo:(id)userInfo{
    AGCellAction *instance = [AGCellAction instance];
    [instance setType:type];
    [instance setUserInfo:userInfo];
    return instance;
}

+ (instancetype)instanceWithType:(NSString *)type{
    return [self instanceWithType:type userInfo:nil];
}

@end
