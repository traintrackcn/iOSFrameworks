//
//  AGButton.m
//  AboveGEM
//
//  Created by traintrackcn on 23/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGButtonItem.h"

@implementation AGButtonItem

+ (instancetype)instanceWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    return [[AGButtonItem alloc] initWithTitle:title target:target action:action];
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    self = [super init];
    if (self) {
        [self setTitle:title.uppercaseString];
        [self setTarget:target];
        [self setAction:action];
    }
    return self;
}

@end
