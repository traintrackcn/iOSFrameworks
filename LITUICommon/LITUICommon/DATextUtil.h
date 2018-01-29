//
//  DATextUtil.h
//  AGUIKit
//
//  Created by Tao Yunfei on 6/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>
@import LITCommon;
@import UIKit;

#define DA_TEXT_UTIL [DATextUtil singleton]

@interface DATextUtil : NSObject

- (CGSize)labelSizeRestrictedToMaxSize:(CGSize)maxSize attributedText:(NSAttributedString *)attributedText;
- (CGSize)textViewSizeRestrictedToMaxSize:(CGSize)maxSize attributedText:(NSAttributedString *)attributedText;

@end
