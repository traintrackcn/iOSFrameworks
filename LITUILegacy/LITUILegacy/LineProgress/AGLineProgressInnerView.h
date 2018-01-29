//
//  AGLineProgressInnerView.h
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

#import <UIKit/UIKit.h>

@interface AGLineProgressInnerView : UIView

//@property (nonatomic, copy) void(^updateTextLabelBlock)(AGRemoterResult *result);
@property (nonatomic, copy) void(^updateTextLabelBlock)(CGRect frame);

@end
