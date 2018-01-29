//
//  LITCell+Border.m
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

@import LITUICommon;

#import "LITCell+Borders.h"

@implementation LITCell (Border)


- (void)initializeDefaultBorders{
    [self.contentView addSubview:self.borderTopViewStyleSolid];
    [self.contentView addSubview:self.borderBottomViewStyleSolid];
    [self.contentView addSubview:self.borderBottomViewStylePaddingL];
    [self.contentView addSubview:self.borderTopViewStylePaddingL];
    
    [self.borderTopViewStyleSolid setHidden:YES];
    [self.borderBottomViewStyleSolid setHidden:YES];
    [self.borderBottomViewStylePaddingL setHidden:YES];
    [self.borderTopViewStylePaddingL setHidden:YES];
    
}

//- (void)layoutDefaultBordersByPosition{
//    
//    if ([self.character atFirst]) {
//        [self.borderTopViewStyleSolid setHidden:NO];
//    }else{
//        [self.borderTopViewStyleSolid setHidden:YES];
//    }
//    
//    
//    if ([self.character atLast]) {
//        [self.borderBottomViewStyleSolid setHidden:NO];
//        [self.borderBottomViewStylePaddingL setHidden:YES];
//    }else{
//        [self.borderBottomViewStyleSolid setHidden:YES];
//        [self.borderBottomViewStylePaddingL setHidden:NO];
//    }
//    
//}

- (void)layoutDefaultBordersByFlag{
    [self.borderTopViewStyleSolid setHidden:!self.character.borderTop];
    [self.borderTopViewStylePaddingL setHidden:!self.character.borderTopPaddingL];
    [self.borderBottomViewStyleSolid setHidden:!self.character.borderBottom];
    [self.borderBottomViewStylePaddingL setHidden:!self.character.borderBottomPaddingL];
    
    if (!self.borderBottomViewStyleSolid.hidden) [self.borderBottomViewStyleSolid setFrame:self.borderBottomFrameStyleSolid];
    if (!self.borderBottomViewStylePaddingL.hidden) [self.borderBottomViewStylePaddingL setFrame:self.borderBottomFrameStylePaddingL];
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

@end
