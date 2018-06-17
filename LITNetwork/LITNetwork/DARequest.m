//
//  DARequestBox.m
//  Distributors
//
//  Created by Tao Yunfei on 4/21/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DARequest.h"
#import "AGRemoteUnit.h"

@interface DARequest(){
    AGRemoteUnit *_rUnit;
}

//@property (nonatomic, weak) DARequest *ws;
@property (nonatomic, strong) id responseMetaData;
@property (nonatomic, strong) id responseHeaders;
//@property (nonatomic, strong) AGRemoteUnit *rUnit;

@end

@implementation DARequest

+ (instancetype)instance{
    return [[self.class alloc] init];
}

- (void)dealloc{
    [self cancel];
//    TLOG(@"%@", NSStringFromClass(self.class));
}

#pragma mark - 

- (void)cancel{
    [_rUnit cancel];
}

#pragma mark - remote stuff

- (void)requestWithCompletion:(void (^)(id, id))completion{
    [self requestWithCompletion:completion userInfo:nil];
}

- (void)requestWithCompletion:(void (^)(id, id))completion userInfo:(id)userInfo{
//    TLOG(@"");
    AGRemoteUnit *rUnit = [self rUnit:userInfo];
    __weak DARequest *ws = self;
    [rUnit requestWithCompletion:^(id data, id error) {
//        TLOG(@"");
        [ws requestCallbackWithCompletion:completion data:data error:error userInfo:userInfo rUnit:rUnit];
    }];
}

- (void)requestCallbackWithCompletion:(void (^)(id, id))completion data:(id)data error:(id)error userInfo:(id)userInfo rUnit:(AGRemoteUnit *)rUnit{
//        TLOG(@"data -> %@", data);
    [self setResponseMetaData:rUnit.responseMetaData];
    [self setResponseHeaders:rUnit.responseHeaders];
    
    if (error) {
//        completion(nil, error);
        [self requestFailedWithCompletion:completion error:error userInfo:userInfo];
        return;
    }
    

    
    [self requestSuccessfulWithCompletion:completion data:data userInfo:userInfo];
}

- (void)requestSuccessfulWithCompletion:(void (^)(id, id))completion data:(id)data userInfo:(id)userInfo{
    completion(data, nil);
}

- (void)requestFailedWithCompletion:(void (^)(id, id))completion error:(id)error userInfo:(id)userInfo{
    completion(nil,error);
}

- (AGRemoteUnit *)rUnit:(id)userInfo{
    if (!_rUnit) {
        _rUnit = [AGRemoteUnit instance];
        [_rUnit setMethod:self.method];
    }
    
    id requestType = [self requestType:userInfo];
    id requestBody = [self requestBody:userInfo];
    id thirdPartyUrl = [self thirdPartyUrl:userInfo];
    id thirdPartyHeaders = [self thirdParthHeaders:userInfo];
    id headers = [self headers:userInfo];
    id apiVersion = [self apiVersion:userInfo];
    id serverUrl = [self serverUrl:userInfo];
    
    if (requestType) [_rUnit setRequestType:requestType];
    if (requestBody) [_rUnit setRequestBody:requestBody];
    if (thirdPartyUrl) [_rUnit setThirdPartyUrl:thirdPartyUrl];
    if (thirdPartyHeaders) [_rUnit setThirdPartyHeaders:thirdPartyHeaders];
    if (headers) [_rUnit setHeaders:headers];
    if (apiVersion) [_rUnit setApiVersion:apiVersion];
    if (serverUrl) [_rUnit setServerUrl:serverUrl];
//    if (requestForm) [_rUnit setRequestForm:requestForm];
//    TLOG(@"thirdPartyUrl -> %@", thirdPartyUrl);
    
//    TLOG(@"requestBody -> %@ rUnit.requestBody -> %@", requestBody, _rUnit.requestBody);
    
    [_rUnit setRandomRequestId:self.randomRequestId];
    [_rUnit setHideActivityIndicator:self.hideActivityIndicator];
    [_rUnit setTimeoutInterval:self.timeoutInterval];
    
    return _rUnit;
}

- (id)requestBody:(id)userInfo{
    return nil;
}

- (id)requestType:(id)userInfo{
    return nil;
}

- (id)thirdPartyUrl:(id)userInfo{
    return nil;
}

- (id)thirdParthHeaders:(id)userInfo{
    return nil;
}

- (id)headers:(id)userInfo{
    return nil;
}

- (id)apiVersion:(id)userInfo{
    return nil;
}

- (id)serverUrl:(id)userInfo{
    return nil;
}

- (NSInteger)method{
    return AGRemoteUnitMethodGET;
}

- (NSTimeInterval)timeoutInterval{
    return 60.0;
}

#pragma mark - properties

- (AGRemoteUnit *)rUnit{
    return _rUnit;
}

//- (DARequest *)ws{
//    if (!_ws) {
//        _ws = self;
//    }
//    return _ws;
//}

@end
