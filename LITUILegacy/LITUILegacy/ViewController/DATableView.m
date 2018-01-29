//
//  DATableView.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DATableView.h"
//#import "GlobalDefine.h"

@implementation DATableView

- (void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    TLOG(@"%@ contenInset -> %@", self.controllerClassName, NSStringFromUIEdgeInsets(contentInset));
}

@end
