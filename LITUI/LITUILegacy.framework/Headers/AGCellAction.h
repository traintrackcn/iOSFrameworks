//
//  AGCellAction.h
//  AboveGEM
//
//  Created by traintrackcn on 13/1/15.
//
//

//#import "AGModel.h"

@import LITCommon;

@interface AGCellAction : AGModel

+ (instancetype)instanceWithType:(NSString *)type userInfo:(id)userInfo;
+ (instancetype)instanceWithType:(NSString *)type;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) id userInfo;

@end
