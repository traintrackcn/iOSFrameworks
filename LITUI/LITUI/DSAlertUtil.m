//
//  DSAlertUtil.m
//  og
//
//  Created by traintrackcn on 13-5-20.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

//#import "MKInfoPanel.h"
#import "SVProgressHUD.h"
#import "DSAlertUtil.h"
#import "AGTextCoordinator.h"
#import "AGUITextKeyDefine.h"

static const CGFloat DS_SECONDS_HIDE_AFTER = 3.0f;


typedef enum {
    ViewTagPermissionError = 100,
    ViewTagInvaildProfileAddress,
    ViewTagShoppingService,
    ViewTagWarning,
    ViewTagUserAgreementViewTag
}ViewTag;

@interface DSAlertUtil()<UIAlertViewDelegate>{
    BOOL bAlerted;
}

@end

@implementation DSAlertUtil


#pragma mark - show alert

+ (void)presentAlertFrom:(UIViewController *)presentFrom
                    title:(NSString *)title
                  message:(NSString *)message
             confirmTitle:(NSString *)confirmTitle
           confirmHandler:(void(^)(UIAlertAction *action))confirmHandler{
    [self presentAlertFrom:presentFrom title:title message:message cancelTitle:nil cancelHandler:nil confirmTitle:confirmTitle confirmHandler:confirmHandler deleteTitle:nil deleteHandler:nil];
}


+ (void)presentAlertFrom:(UIViewController *)presentFrom
                    title:(NSString *)title
                  message:(NSString *)message
              cancelTitle:(NSString *)cancelTitle
            cancelHandler:(void(^)(UIAlertAction *action))cancelHandler
             confirmTitle:(NSString *)confirmTitle
           confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
              deleteTitle:(NSString *)deleteTitle
            deleteHandler:(void(^)(UIAlertAction *action))deleteHandler{
    
    
    if ([message isKindOfClass:[NSArray class]]) {
        message  = [(NSArray *)message componentsJoinedByString:@"\n"];
    }
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle){
        UIAlertAction *cancelA = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [ac addAction:cancelA];
    }
    
    if (confirmTitle){
        UIAlertAction *confirmA = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
        [ac addAction:confirmA];
    }
    
    if (deleteTitle){
        UIAlertAction *deleteA = [UIAlertAction actionWithTitle:deleteTitle style:UIAlertActionStyleDefault handler:deleteHandler];
        [ac addAction:deleteA];
    }
    
    [presentFrom presentViewController:ac animated:YES completion:nil];
}



- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...{
    
    if (bAlerted) return;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];
    [alert setTag:tag];
    [alert show];
    bAlerted = YES;
}



- (void)showAlertShoppingServiceUnavailable{
    NSString *msg = @"Shopping service is unavailable.";
    [self showAlertWithTitle:TEXT_FOR_KEY(KEY_LBL_WARNING) message:msg tag:ViewTagShoppingService cancelButtonTitle:TEXT_FOR_KEY(KEY_LBL_OK) otherButtonTitles:nil];
}


- (void)showAlertWarningMessage:(NSString *)msg{
    [self showAlertWithTitle:TEXT_FOR_KEY(KEY_LBL_WARNING) message:msg tag:ViewTagWarning cancelButtonTitle:TEXT_FOR_KEY(KEY_LBL_OK) otherButtonTitles:nil];
}


- (void)showAlertUserAgreement{
    
}


#pragma mark - SVProgressHUD



+ (void)showSVPKeywordIsEmpty{
    [SVProgressHUD showErrorWithStatus:TEXT_FOR_KEY(KEY_UI_MSG_KEYWORK_IS_EMPTY)];
}

+ (void)showSVPProcessing{
    [SVProgressHUD showWithStatus:TEXT_FOR_KEY(KEY_UI_MSG_PROCESSING) maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPSaving{
    [SVProgressHUD showWithStatus:TEXT_FOR_KEY(KEY_UI_MSG_SAVING) maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPValidating{
    [SVProgressHUD showWithStatus:TEXT_FOR_KEY(KEY_UI_MSG_VALIDATING) maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPStatusForCustomText:(NSString *)text{
    [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPErrorForCustomText:(NSString *)text{
    [SVProgressHUD showErrorWithStatus:text ];
}

+ (void)showSVPSuccessForCustomText:(NSString *)text{
    [SVProgressHUD showSuccessWithStatus:text];
}


+ (void)dismissSVP{
    [SVProgressHUD dismiss];
}

#pragma mark - kinds of panels

+ (void)showGlobalPanelErrorConnectionError{
//    [self showGlobalPanelStyleErrorWithTitle:TEXT(KEY_LBL_NETWORK_ERROR)
//                     subtitle:TEXT(KEY_UI_MSG_CHECK_YOUR_CONNECTION)];
}

+ (void)showGobalPanelErrorCannotReachHost{
//     [self showGlobalPanelStyleErrorWithTitle:TEXT(KEY_LBL_SERVER_MAINTENANCE)
//                      subtitle:TEXT(KEY_UI_MSG_UNDERGOING_MAINTENANCE)];
}

+ (void)showGlobalPanelErrorOops{
//    [self showGlobalPanelStyleErrorWithTitle:TEXT(KEY_LBL_OOPS) subtitle:TEXT(KEY_UI_MSG_OOPS_SOMETING_WRONG)];
}

//+ (void)showGlobalPanelErrorOops{
//    [self showGlobalPanelStyleErrorWithTitle:[AGTextCoordinator textOopsSomethingWrong] subtitle:nil];
//}

//+ (void)showGlobalPanelStyleErrorWithTitle:(NSString *)title subtitle:(NSString *)subtitle{
//    [MKInfoPanel showPanelInWindow: self.window
//                              type:MKInfoPanelTypeError
//                             title:title
//                          subtitle:subtitle
//                         hideAfter:DS_SECONDS_HIDE_AFTER];
//    
//}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    bAlerted = NO;
    
    NSInteger tag = [alertView tag];
    
//    LOG_DEBUG(@"alertView btnIdx -> %ld tag -> %ld", (long)buttonIndex, (long)tag);
    
    switch (tag) {
        case ViewTagPermissionError:
//            [[DSRootViewController sharedInstance] dismiss];
            break;
        case ViewTagShoppingService:
//            [[DSRootViewController sharedInstance] showCatalogsVCWithToggle:NO initMenuSelection:NO];
            break;
        default:
            break;
    }
    
}


#pragma mark - properties
+ (UIWindow *)window{
    //    LOG_DEBUG(@"windows -> %@", [[UIApplication sharedApplication] windows]);
    return [[[UIApplication sharedApplication] windows] objectAtIndex:0];
}



@end
