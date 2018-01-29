//
//  DSAlertUtil.h
//  og
//
//  Created by traintrackcn on 13-5-20.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAlertUtil : NSObject 

- (void)showAlertShoppingServiceUnavailable;
- (void)showAlertWarningMessage:(NSString *)msg;

+ (void)presentAlertFrom:(UIViewController *)presentFrom
                    title:(NSString *)title
                  message:(NSString *)message
              cancelTitle:(NSString *)cancelTitle
            cancelHandler:(void(^)(UIAlertAction *action))cancelHandler
             confirmTitle:(NSString *)confirmTitle
           confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
              deleteTitle:(NSString *)deleteTitle
            deleteHandler:(void(^)(UIAlertAction *action))deleteHandler;

+ (void)presentAlertFrom:(UIViewController *)presentFrom
                    title:(NSString *)title
                  message:(NSString *)message
             confirmTitle:(NSString *)confirmTitle
           confirmHandler:(void(^)(UIAlertAction *action))confirmHandler;

#pragma mark - svp status/alert/progress

+ (void)showSVPProcessing;
+ (void)showSVPSaving;
+ (void)showSVPValidating;
+ (void)showSVPKeywordIsEmpty;
+ (void)showSVPStatusForCustomText:(NSString *)text;
+ (void)showSVPErrorForCustomText:(NSString *)text;
+ (void)showSVPSuccessForCustomText:(NSString *)text;
+ (void)dismissSVP;

#pragma mark - panel
+ (void)showGlobalPanelErrorConnectionError;
+ (void)showGobalPanelErrorCannotReachHost;
+ (void)showGlobalPanelErrorOops;



#pragma mark - 
+ (UIWindow *)window;

@end
