//
//  AGRemoteDataCoordinator.m
//  AboveGEM
//
//  Created by traintrackcn on 20/1/15.
//
//

@import LITCommon;

#import "AGRemoteUnit.h"
#import "AGRemoter.h"
#import "AGRemoterResult.h"
#import "AGNetworkDefine.h"

@interface AGRemoteUnit()<AGRemoterDelegate>{
    void(^requestCompletion)(id data, id error);
}

@property (nonatomic, strong) AGRemoter *remoter;
@property (nonatomic, strong) DSRequestInfo *requestInfo;
@property (nonatomic, strong) id responseData;
@property (nonatomic, strong) id responseHeaders;
@property (nonatomic, strong) id responseError;
@property (nonatomic, strong) id responseMetaData;



@end

@implementation AGRemoteUnit

+ (instancetype)instance{
    AGRemoteUnit *instance = [[AGRemoteUnit alloc] init];
    return instance;
}

- (void)dealloc{
//    TLOG(@"%@",self);
    [self cancel];
}

#pragma mark - properties

- (NSString *)methodStr{
    if (self.method == AGRemoteUnitMethodDELETE) return @"DELETE";
    if (self.method == AGRemoteUnitMethodPOST) return @"POST";
    if (self.method == AGRemoteUnitMethodPUT) return @"PUT";
    if (self.method == AGRemoteUnitMethodHEAD) return @"HEAD";
    return @"GET";
}

- (AGRemoter *)remoter{
    if (!_remoter) {
        _remoter = [AGRemoter instanceWithDelegate:self];
    }
    return _remoter;
}

- (DSRequestInfo *)requestInfo{
    if (!_requestInfo) _requestInfo = [DSRequestInfo instance];
    [_requestInfo setMethod:self.methodStr];
    [_requestInfo setRandomRequestId:self.randomRequestId];
    [_requestInfo setHideActivityIndicator:self.hideActivityIndicator];
    if (self.requestType) [_requestInfo setRequestType:self.requestType];
    if (self.requestBody) [_requestInfo setRequestBody:self.requestBody];
    if (self.protocolVersion) [_requestInfo setProtocolVersion:self.protocolVersion];
    if (self.thirdPartyUrl) [_requestInfo setThirdPartyUrl:self.thirdPartyUrl];
    if (self.thirdPartyHeaders) [_requestInfo setThirdPartyHeaders:self.thirdPartyHeaders];
    if (self.headers) [_requestInfo setHeaders:self.headers];
    [_requestInfo setTimeoutInterval:self.timeoutInterval];
    return _requestInfo;
}

#pragma mark - events


- (id)didGetResponseData:(id)responseData{
    return responseData;
}

- (id)didGetResponseHeaders:(id)responseHeaders{
    return responseHeaders;
}

#pragma mark - availability

//- (BOOL)isDataCached{
//    if(self.responseData) return YES;
//    return NO;
//}

- (BOOL)isRequesting{
    if (_remoter) return YES;
    return NO;
}

#pragma mark - ops

- (void)waitAMomentForRemoterThenRequestWithCompletion:(void(^)(id data, id error))completion{
    [self performSelector:@selector(requestWithCompletion:) withObject:completion afterDelay:1.0f];
//    TLOG(@"wait 1s ...");
}

#pragma mark - remote ops

- (void)requestWithCompletion:(void(^)(id data, id error))completion{

    
//    TLOG(@"completion -> %@", completion);
    
//    if ([self isDataCached]) {
//        requestCompletion = completion;
//        [self executeBlock];
//        return;
//    }
    
    //processing another request, wait 1s
    if ([self isRequesting]) {
        [self waitAMomentForRemoterThenRequestWithCompletion:completion];
        return;
    }
    
    requestCompletion = completion;
    
    
    [self.remoter send:self.requestInfo];
    
}

- (void)executeBlock{
    if (requestCompletion) {
        @try {
//            TLOG(@"requestCompletion -> %@ %@", requestCompletion, [self.data raw]);
            requestCompletion(self.responseData, self.responseError);
        }
        @catch (NSException *exception) {
            TLOG(@"exception -> %@", exception);
        }
    }
    
    if (self.cacheEnabled) {
        [self requestFlowEnd];
    }else{
        [self reset];
    }
    
}

- (void)requestFlowEnd{
    [self setRemoter:nil];
    [self setResponseError:nil];
    requestCompletion = nil;
}

- (void)reset{
    [self setResponseData:nil];
    [self requestFlowEnd];
}

- (void)cancel{
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; //also cancel in queue requests
    [_remoter cancel];
}

#pragma mark - AGRemoterDelegate

- (void)remoterResultReceived:(AGRemoterResult *)result requestType:(NSString *)requestType{
    id responseData = result.responseData;
    id responseHeaders = result.responseHeaders;
    
    @try {
        id processedData = [self didGetResponseData:responseData];
        id processedHeaders = [self didGetResponseHeaders:responseHeaders];
        [self setResponseData:processedData];
        [self setResponseHeaders:processedHeaders];
        [self setResponseMetaData:result.metaData];
    }@catch (NSException *exception) {
        //            [AGFlurryMonitor logClientException:exception fnName:CURRENT_FUNCTION_NAME];
    }
    [self executeBlock];
}

- (void)remoterErrorOccured:(AGRemoterResult *)result requestType:(NSString *)requestType{
    TLOG(@"result -> %@", @(result.code));
    [self setResponseError:result.errorParsed];
    [self executeBlock];
}

@end
