//
//  AGViewController+DisplayMessages.m
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "UITableViewController+Message.h"
#import "AGVCSuccessMessagesView.h"
#import "AGVCFailureMessagesView.h"
#import "NSObject+VC.h"

typedef NS_ENUM(NSInteger, UIViewTag) {
    UIViewTagFloatMessageBox = 999
};


@implementation UITableViewController (DisplayMessages)

#pragma mark - float message ops

- (void)floatMessageProcessing{
    [self floatMessage:TEXT(KEY_UI_MSG_PROCESSING)];
}

- (void)floatMessage:(NSString *)message{
//    TLOG(@"");
    UIView *v = [self overlayWithTag:UIViewTagFloatMessageBox];
//     TLOG(@"v -> %@", v);
    if (!v){
        v = [self assemblerFloatedView];
        [self addOverlay:v];
        [self enableOverlay:YES];
//        TLOG(@"v -> %@", v);
    }
    
    UILabel *titleView = (UILabel *)[v subviews].firstObject;
    [titleView setText:message];
//    [v.layer removeAllAnimations];
    
    [UIView animateWithDuration:.33 animations:^{
        [v setAlpha:1];
    }];
    
    
}

- (void)clearFloatedMessage{
    UIView *v = [self overlayWithTag:UIViewTagFloatMessageBox];
//    TLOG(@"v -> %@", v);
    if (!v) return;
    if (v.subviews.count >= 2){
        UIActivityIndicatorView *indicatorV = (UIActivityIndicatorView *)[v.subviews objectAtIndex:1];
        [indicatorV stopAnimating];
    }
    [v removeFromSuperview];
    [self enableOverlay:NO];
}

#pragma mark - floated message assemblers

- (UIView *)assemblerFloatedView{
    CGFloat w = 124;
    CGFloat h = 100;
    CGFloat x = (self.overlayContainer.frame.size.width - w)/2.0;
    CGFloat y = (self.overlayContainer.frame.size.height - h)/3.0;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    [v.layer setCornerRadius:12.0];
    [v setClipsToBounds:YES];
    [v setTag:UIViewTagFloatMessageBox];
    
    [v setBackgroundColor:[COLOR(RGB_FLOATING_MESSAGE_BACKGROUND) colorWithAlphaComponent:.7]];
    
    
    //assemble title view
    UILabel *titleView = [self assembleFloatedTitleLabel:CGSizeMake(w, h)];
    [v addSubview:titleView];
    
    //assemble indicator
    UIView *indicatorV = [self assembleFloatedIndicator:CGSizeMake(w, h)];
    [v addSubview:indicatorV];
    
    [v setAlpha:0];
    
    
    
    return v;
}

- (UIView *)assembleFloatedIndicator:(CGSize)containerSize{
    CGFloat w = 60;
    CGFloat h = 60;
    CGFloat x = (containerSize.width - w)/2.0;
    CGFloat y = 10;
    
    
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [v setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [v.layer setBorderWidth:1];
    [v startAnimating];
    return v;
}

- (UILabel *)assembleFloatedTitleLabel:(CGSize)containerSize{
    CGFloat padding = 4.0f;
    CGFloat w = containerSize.width;
    CGFloat h = 30.0;
    CGFloat x = 0;
    CGFloat y = containerSize.height - h - padding;
    CGRect frame = CGRectMake(x, y, w, h);
    UILabel *l = [[UILabel alloc] initWithFrame:frame];
    [l setAdjustsFontSizeToFitWidth:YES];
    [l setFont:[UIFont boldSystemFontOfSize:16.0]];
    //        TLOG(@"%@ self.parentViewController -> %@",self.class, self.navigationController);
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setTextColor:COLOR(RGB_FLOATING_MESSAGE)];
    return l;
}





#pragma mark - display message ops

- (BOOL)setSuccessMessages:(NSArray *)messages{
    if (!messages.count) return NO;
    [self displayMessages:messages cls:[AGVCSuccessMessagesView class]];
    return YES;
}

- (BOOL)setFailureMessages:(NSArray *)messages{
    if (!messages.count) return NO;
    [self displayMessages:messages cls:[AGVCFailureMessagesView class]];
    return YES;
}

- (void)displayMessages:(NSArray *)messages cls:(Class)cls{
    if (messages.count == 0) return;
    if (cls == nil) cls = [AGVCMessagesView class];
    
    AGVCMessagesView *v = [[cls alloc] init];
    [v updateMessages:messages];
    [self.tableView setTableHeaderView:v];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)clearSetMessages{
    [self.tableView setTableHeaderView:nil];
}

@end
