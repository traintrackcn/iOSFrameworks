//
//  AGRemoter.h
//  DirectSale
//
//  Created by Sean Guo on 7/14/12.
//  Copyright (c) 2012 Voxeo. All rights reserved.
//


#import "DSRequestInfo.h"
#import "DANetworkLoader.h"

@class AGRemoterResult;

@protocol AGRemoterDelegate <NSObject>

@optional
- (void)remoterDataReceived:(id)responseData requestType:(NSString *)requestType;
- (void)remoterResultReceived:(AGRemoterResult *)result requestType:(NSString *)requestType;
- (void)remoterErrorOccured:(AGRemoterResult *)result requestType:(NSString *)requestType;

@end

@interface AGRemoter : DANetworkLoader

+ (AGRemoter *)instanceWithDelegate:(id < AGRemoterDelegate>)aDelegate;
- (void)send:(DSRequestInfo *)req;

//- (AGRemoterResult *)assembleResultForError:(NSError *)error;
- (void)REQUEST:(NSString *)requestType method:(NSString *)method requestBody:(id)requestBody randomRequestId:(BOOL)randomRequestId protocolVersion:(NSString *)protocolVersion;

@property (nonatomic, weak) id < AGRemoterDelegate> delegate;


@end
