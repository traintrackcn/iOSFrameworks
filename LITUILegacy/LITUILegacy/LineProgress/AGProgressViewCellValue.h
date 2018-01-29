//
//  AGProgressViewCellValue.h
//  AboveGEM
//
//  Created by traintrackcn on 19/1/15.
//
//

//#import "AGModel.h"

@import LITCommon;

@interface AGProgressViewCellValue : AGModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSNumber *percent;
@property (nonatomic, strong) id userInfo;

@end
