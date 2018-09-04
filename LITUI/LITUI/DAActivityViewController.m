//
//  DAActivityViewController.m
//  uomada
//
//  Created by Tao Yunfei on 13/12/2016.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DAActivityViewController.h"
//#import "GlobalDefine.h"


@interface UIActivityViewController (Private)

- (BOOL)_shouldExcludeActivityType:(UIActivity*)activity;

@end

@implementation DAActivityViewController

- (instancetype)initWithActivityItems:(NSArray *)activityItems applicationActivities:(NSArray<__kindof UIActivity *> *)applicationActivities{
    self = [super initWithActivityItems:activityItems applicationActivities:applicationActivities];
    if (self) {
//        self.excludedActivityTypes = @[UIActivityTypePrint,
//                                       UIActivityTypeAssignToContact,
//                                       UIActivityTypeSaveToCameraRoll,
//                                       UIActivityTypeAirDrop,
//                                       UIActivityTypeOpenInIBooks,
//                                       @"com.apple.mobilenotes.SharingExtension",
//                                       @"com.apple.reminders.RemindersEditorExtension",
//                                       @"com.tencent.xin.sharetimeline",
//                                       @"com.apple.mobileslideshow.StreamShareService"
////                                       UIActivityTypeCopyToPasteboard
//                                       ]; //Exclude whichever aren't relevant
        [self setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            TLOG(@"completed: %@, \n%d, \n%@, \n%@,", activityType, completed, returnedItems, activityError);
            
        }];
    }
    return self;
}

- (BOOL)_shouldExcludeActivityType:(UIActivity *)activity{
    NSString *activityType = activity.activityType;
    if ([activityType isEqualToString:@"com.apple.reminders.RemindersEditorExtension"]) return YES;
    if ([activityType isEqualToString:@"com.apple.mobilenotes.SharingExtension"]) return YES;
    if ([activityType isEqualToString:@"com.tencent.xin.sharetimeline"]) return YES;
    if ([activityType isEqualToString:@"com.apple.mobileslideshow.StreamShareService"]) return YES;
    return [super _shouldExcludeActivityType:activity];
}

@end
