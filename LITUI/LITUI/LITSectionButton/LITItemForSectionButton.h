//
//  LITItemForSectionButton.h
//  iPhone
//
//  Created by Tao Yunfei on 26/09/2017.
//



//#import "AGModel.h"

@import UIKit;
@import LITCommon;

@interface LITItemForSectionButton : AGModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) CGFloat paddingT;
@property (nonatomic, assign) CGFloat paddingB;
@property (nonatomic, assign) BOOL hidden;

@end
