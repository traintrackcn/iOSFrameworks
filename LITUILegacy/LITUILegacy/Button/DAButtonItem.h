//
//  DAButtonItem.h
//  Distributors
//
//  Created by Tao Yunfei on 1/5/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGButtonItem.h"
#import <UIKit/UIKit.h>

@interface DAButtonItem : AGButtonItem

+ (instancetype)instanceWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color target:(id)target action:(SEL)action;

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *color;

@end
