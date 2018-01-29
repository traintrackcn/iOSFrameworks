//
//  NSObject+VC.h
//  AGUIKit
//
//  Created by Tao Yunfei on 11/10/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGObjectPool;

@import UIKit;

@interface NSObject (VC)

- (AGObjectPool *)objPool;
- (id)ws;
- (void)addOverlay:(UIView *)view;
- (void)enableOverlay:(BOOL)enabled;
- (UIView *)overlayContainer;
- (UIView *)overlayWithTag:(NSInteger)tag;
- (void)floatMessageProcessing;
- (void)floatMessage:(NSString *)message;
- (void)clearFloatedMessage;

- (void)presentWithDelegate:(id)delegate;

@end
