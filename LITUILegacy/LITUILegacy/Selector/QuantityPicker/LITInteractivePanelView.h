//
//  LITTouchPannel.h
//  AGUIKit
//
//  Created by Tao Yunfei on 25/08/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LITInteractivePanelViewDelegate <NSObject>

@optional
- (void)didTapLeftInteractivePanel;
- (void)didTapRightInteractivePanel;

@end

@interface LITInteractivePanelView : UIView

@property (nonatomic, weak) id<LITInteractivePanelViewDelegate> delegate;

@end
