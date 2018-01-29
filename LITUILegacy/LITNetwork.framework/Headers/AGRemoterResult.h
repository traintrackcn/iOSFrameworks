//
//  AGOperationResult.h
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#define META_CODE_UNEXPECTED -999
#define META_CODE_ERROR_PARSING -1
#define META_CODE_CANCELED 1

@class AGRemoterError;
@class DSRequestInfo;

@interface AGRemoterResult : AGModel

- (BOOL)isError;
- (BOOL)isTimeout;
- (BOOL)isCanceled;
- (BOOL)isNotModified;
- (BOOL)isInvalidAuthentication;
- (BOOL)isInvalidConnection;
- (NSString *)type;


- (void)parseError:(NSError *)error errorRaw:(id)errorRaw responseRaw:(id)responseRaw;

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) DSRequestInfo *request;
@property (nonatomic, strong) id responseData;
@property (nonatomic, strong) id metaData;
@property (nonatomic, strong) AGRemoterError *errorParsed;
@property (nonatomic, strong) NSError *errorOriginal;
@property (nonatomic, strong) id responseHeaders;

@end
