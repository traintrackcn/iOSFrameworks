//
//  DATextAreaDelegate.h
//  Distributors
//
//  Created by Tao Yunfei on 5/11/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import Foundation;
@import UIKit;

@class AGCell;
@interface DATextInputDelegate : NSObject <UITextFieldDelegate, UITextViewDelegate>

- (instancetype)initWithCell:(UITableViewCell *)cell;
- (AGCell *)cell;

@end
