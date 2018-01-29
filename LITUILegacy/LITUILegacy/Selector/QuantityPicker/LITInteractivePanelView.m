//
//  LITTouchPannel.m
//  AGUIKit
//
//  Created by Tao Yunfei on 25/08/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "LITInteractivePanelView.h"
//#import "GlobalDefine.h"

@interface LITInteractivePanelView(){
    
}

//@property (nonatomic, assign) BOOL tappedLeftArea;

@end

@implementation LITInteractivePanelView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAny:)];
        [self addGestureRecognizer:gr];
    }
    return self;
}

#pragma mark - 

- (void)didTapAny:(id)sender{
//    TLOG(@"sender -> %@", sender);
    UITapGestureRecognizer *gr = (UITapGestureRecognizer *)sender;
    
    CGPoint pos = [gr locationInView:self];
    if (pos.x < self.frame.size.width/2.0) {
        [self dispatchDidTapLeft];
    }else{
        [self dispatchDidTapRight];
    }
}


#pragma mark - dispatchers

- (void)dispatchDidTapRight{
//    TLOG(@"");
    if (_delegate && [_delegate respondsToSelector:@selector(didTapRightInteractivePanel)]){
        [_delegate didTapRightInteractivePanel];
    }
}

- (void)dispatchDidTapLeft{
//    TLOG(@"");
    if (_delegate && [_delegate respondsToSelector:@selector(didTapLeftInteractivePanel)]){
        [_delegate didTapLeftInteractivePanel];
    }
}

@end
