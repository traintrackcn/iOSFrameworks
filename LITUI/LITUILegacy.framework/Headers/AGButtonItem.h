//
//  AGButton.h
//  AboveGEM
//
//  Created by traintrackcn on 23/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

//#import "AGModel.h"

@interface AGButtonItem : AGModel

+ (instancetype)instanceWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id target;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, assign) SEL action;

@end
