//
//  AGViewController+DisplayMessages.h
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import UIKit;

@interface UITableViewController (DisplayMessages)


- (void)floatMessageProcessing;
- (void)floatMessage:(NSString *)message;
- (void)clearFloatedMessage;


#pragma mark - display messages at the top of table view

- (BOOL)setFailureMessages:(NSArray *)messages;
- (BOOL)setSuccessMessages:(NSArray *)messages;
//- (void)clearMessages;
- (void)clearSetMessages;


@end
