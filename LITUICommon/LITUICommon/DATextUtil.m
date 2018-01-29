//
//  DATextUtil.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DATextUtil.h"

@interface DATextUtil(){
    
}

//@property (nonatomic, strong) UILabel *helperForLabel;
@property (nonatomic, strong) UITextView *helperForTextView;

@end

@implementation DATextUtil


- (CGSize)labelSizeRestrictedToMaxSize:(CGSize)maxSize attributedText:(NSAttributedString *)attributedText {
    
//    Class cls = aCls?aCls:[UILabel class];
//    UILabel *helper = [[cls alloc] init];
//    [helper setNumberOfLines:0];
//    [helper setAttributedText:attributedText];
//    CGSize size = [helper sizeThatFits:maxSize];
//    return size;
    CGRect rect = [attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
    
    
}

//- (UILabel *)helperForLabel{
//    if (!_helperForLabel) {
//        _helperForLabel = [[UILabel alloc] init];
//        [_helperForLabel setNumberOfLines:0];
//    }
//    return _helperForLabel;
//}

- (CGSize)textViewSizeRestrictedToMaxSize:(CGSize)maxSize attributedText:(NSAttributedString *)attributedText{
    [self.helperForTextView setAttributedText:attributedText];
    CGSize size = [self.helperForTextView sizeThatFits:maxSize];
    return size;
}

- (UITextView *)helperForTextView{
    if (!_helperForTextView){
        _helperForTextView = [[UITextView alloc] init];
    }
    return _helperForTextView;
}


@end
