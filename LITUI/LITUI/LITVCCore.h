//
//  LITVCCore.h
//  iPhone
//
//  Created by Tao Yunfei on 15/10/2017.
//

//#import "AGModel.h"

@import LITCommon;

@class LITVC;


@interface LITVCCore : AGModel

- (void)setCellH:(NSNumber *)h atIndexPath:(NSIndexPath *)indexPath;
- (NSNumber *)cellHAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) LITVC *vc;

@end
