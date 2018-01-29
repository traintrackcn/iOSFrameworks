//
//  AGSingleTextfieldEditor.h
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController.h"

@interface AGTextfieldEditor : AGViewController

- (BOOL)validate;

- (void)doConfirm;

@property (nonatomic, strong) id value;

@end
