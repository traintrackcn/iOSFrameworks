//
//  AGLineProgressInnerView.m
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

#import "AGLineProgressInnerView.h"

@implementation AGLineProgressInnerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
//    TLOG(@"self.updateTextLabelBlock -> %@", self.updateTextLabelBlock);
    if (self.updateTextLabelBlock) {
        self.updateTextLabelBlock(frame);
    }
    
}

@end
