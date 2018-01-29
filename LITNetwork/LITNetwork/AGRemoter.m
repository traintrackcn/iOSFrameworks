//
//  AGRemoter.m
//  DirectSale
//
//  Created by Sean Guo on 7/14/12.
//  Copyright (c) 2012 Voxeo. All rights reserved.
//

@import LITCommon;

#import "AGRemoter.h"
#import "AGRemoterResult.h"
#import "AGRemoterError.h"
#import "AGNetworkDefine.h"
//#import "NSObject+Singleton.h"
#import "DSRequestInfo.h"
#import "AGRequestBinary.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLResponseSerialization.h"
//#import "DAAppMonitor.h"

#define kErrorCode @"code"



@interface AGRemoter(){
    
}



@end


@implementation AGRemoter
@synthesize delegate;

+ (void)initialize{
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

+ (AGRemoter *)instanceWithDelegate:(id< AGRemoterDelegate>)aDelegate{
    AGRemoter *instance = [[AGRemoter alloc] init];
    [instance setDelegate:aDelegate];
    return instance;
}

#pragma mark - main ops

- (void)send:(DSRequestInfo *)requestInfo{
    
    [requestInfo assemble];
    
    //log without headers
//    TLOG(@"[Request] %@ %@ %@ ",[requestInfo method], [requestInfo URL].absoluteString, [requestInfo requestBody]);
    
    // log with headers
    id headers = [requestInfo allHTTPHeaderFields];
//    headers = @"";
    TLOG(@"[Request] %@ %@ %@ %@ ",[requestInfo method], [requestInfo URL].absoluteString, headers,  [requestInfo requestBody]);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requestInfo];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self operation:operation successfulWithResponse:responseObject];
        [self dequeue:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        TLOG(@"before failure callback");
        [self operation:operation failedWithError:error];
        [self dequeue:operation];
    }];
    
    [self enqueue:operation hideActivityIndicator:requestInfo.hideActivityIndicator];
    
}



#pragma mark -

- (void)operation:(AFHTTPRequestOperation *)operation successfulWithResponse:(id)responseRaw{
//    TLOG(@"operation.responseString -> %@",operation.responseString);
//    TLOG(@"responseDataRaw -> %@", responseRaw);
    NSDictionary *responseHeaders =  operation.response.allHeaderFields;
    AGRemoterResult *result = [AGRemoterResult instance];
    
//    TLOG(@"operation.request.allHeaderFields -> %@", operation.request.allHTTPHeaderFields);
    
    if (responseHeaders != nil) {
        NSString *serverCurrentTime = [responseHeaders objectForKey:@"X-SERVER-CURRENT-TIME"];
        if (NETWORK.serverCurrentTimeReceivedBlock) {
            NETWORK.serverCurrentTimeReceivedBlock(serverCurrentTime);
        }
    }
    
    id metaData;
    id responseData;
    id code;
    id errorRaw;
    
    if ([responseRaw isKindOfClass:[NSDictionary class]]) {
        metaData = [responseRaw objectForKey:@"meta"];
        code = [metaData objectForKey:@"code"];
        errorRaw = [metaData objectForKey:@"error"];
        responseData = [responseRaw objectForKey:@"response"];
    }
    
    if (!responseData) responseData = responseRaw;
    
//    TLOG(@"responseData -> %@", responseData);
    
//    TLOG(@"before setCode");
    [result setCode: operation.response.statusCode ];
    [result setRequest: (DSRequestInfo *)[operation request] ];
    [result setMetaData: metaData];
    [result setResponseData: responseData ];
    [result setResponseHeaders:operation.response.allHeaderFields];
    
    //status code from meta
    if (code) {
        [result setCode:[code integerValue]];
    }else if (errorRaw) {
        [result setCode:META_CODE_UNEXPECTED];
    }
    
    if (errorRaw) {
        [result parseError:nil errorRaw:errorRaw responseRaw:nil];
        TLOG(@"errorRaw -> %@", errorRaw);
    }
    
    
    [self processResult:result];
}



- (void)operation:(AFHTTPRequestOperation *)operation failedWithError:(NSError *)error{
//    TLOG(@"operation.responseString -> %@",operation.responseObject);
//    TLOG(@"error -> %@", error);
//    TLOG(@"before assemble error");
//    AGRemoterResult *result = [self assembleResultForError:error responseData:operation.responseObject];
//    DSRequestInfo *request = (DSRequestInfo *)operation.request;
    
    AGRemoterResult *result = [AGRemoterResult instance];
    [result parseError:error errorRaw:nil responseRaw:operation.responseObject];
    
    if (operation.isCancelled) {
        [result setCode:META_CODE_CANCELED];
    }else{
        [result setCode: operation.response.statusCode ];
    }

    if (![result isError]) { //filter invalid strings
        NSString *responseString = operation.responseString;
        responseString = [responseString stringByReplacingOccurrencesOfString:@"NaN" withString:@"null"];
//        TLOG(@"responseString -> %@", responseString);
        @try {
            NSData *responseBinaryData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            id responseJSON = [NSJSONSerialization JSONObjectWithData:responseBinaryData options:NSJSONReadingAllowFragments error:nil];
            //        TLOG(@"responseJSON -> %@", responseJSON);
            [result setResponseData: [responseJSON objectForKey:@"response"] ];
        } @catch (NSException *exception) {
            [result setCode:META_CODE_ERROR_PARSING];
        } 
        
        
        
    }else{
//        TLOG(@"request headers -> %@", result.errorParsed.headers);
    }
    
    [result setResponseHeaders:operation.response.allHeaderFields];
    [result setRequest:(DSRequestInfo *)[operation request] ];
    [self processResult:result];
}



- (void)processResult:(AGRemoterResult *)result{
    DSRequestInfo *request = (DSRequestInfo *)result.request;
    
    
    
//    TLOG(@"result isError -> %d", result.isError);
    if ( [result isError]){
        TLOG(@"[Response Error(%@)] %@ %@ %@", @(result.code), [request method], [request URL], result.errorParsed.recoverySuggestion);
        [self dispatchRemoterErrorOccured:result];
    }else{
        TLOG(@"[Response %@(%@)] %@ %@ ", result.type.uppercaseString , @(result.code),[request method], [request URL]);
        [self dispatchRemoterResultReceived:result];
    }
    
//    [APP_MONITOR logRemoterResult:result];
    
}

#pragma mark - dispatchers

- (void)dispatchRemoterResultReceived:(AGRemoterResult *)result{
    id responseData = result.responseData;
    DSRequestInfo *request = (DSRequestInfo *)result.request;
    NSString *requestType = request.requestType;
    
    @try {
//        if (delegate&&[delegate respondsToSelector:@selector(remoterDataReceived:withRequestData:)]) {
//            [delegate remoterDataReceived:responseData withRequestData:request];
//        }
        
        if (delegate && [delegate respondsToSelector:@selector(remoterDataReceived:requestType:)]) {
            [delegate remoterDataReceived:responseData requestType:requestType];
        }
        
        if (delegate && [delegate respondsToSelector:@selector(remoterResultReceived:requestType:)]) {
            [delegate remoterResultReceived:result requestType:requestType];
        }
        
    }@catch (NSException *exception) {
//        [AGFlurryMonitor logClientException:exception forRequest:request fnName:CURRENT_FUNCTION_NAME];
    }
    
    //universal data handler
    @try{
        if ([AGNetworkDefine singleton].dataReceivedBlock) {
            [AGNetworkDefine singleton].dataReceivedBlock(responseData, request);
        }
    }@catch (NSException *exception) {
//        [AGFlurryMonitor logClientException:exception forRequest:request fnName:CURRENT_FUNCTION_NAME];
    }
}

- (void)dispatchRemoterErrorOccured:(AGRemoterResult *)result{
    TLOG(@"");
    @try {
//        if ([delegate respondsToSelector:@selector(remoterErrorOccured:)]) {
//            [delegate remoterErrorOccured:result];
//        }
        
        if ([delegate respondsToSelector:@selector(remoterErrorOccured:requestType:)]) {
            [delegate remoterErrorOccured:result requestType:result.request.requestType];
        }
        
    }@catch (NSException *exception) {
//        DSRequest *request = (DSRequest *)result.request;
//        [AGFlurryMonitor logClientException:exception forRequest:request fnName:CURRENT_FUNCTION_NAME];
    }
    
    //universal error handler
    @try {
        if ([AGNetworkDefine singleton].errorOccuredBlock) {
            [AGNetworkDefine singleton].errorOccuredBlock(result);
        }
    }@catch (NSException *exception) {
//        [AGFlurryMonitor logClientException:exception forRequest:result.request fnName:CURRENT_FUNCTION_NAME];
    }
    
    //Monitor actions
    if([result isInvalidAuthentication]){
//        if ([DSReachabilityManager singleton].isInternetReachable) {
//            
//            if ([DSReachabilityManager singleton].isHostReachable) {
////                [AGFlurryMonitor passCheckpoint:CHECKPOINT_SERVER_IS_OOPS];
//            }else if (![DSReachabilityManager singleton].isHostReachable) {
////                [AGFlurryMonitor passCheckpoint:CHECKPOINT_SERVER_IS_DOWN];
//            }
//            
////            [AGFlurryMonitor logServerExceptionWithResult:result];
//
//        }
    }
    
    if (![result isInvalidAuthentication]
        && ![result isInvalidConnection]
        && ![result isCanceled]) {
//        [AGFlurryMonitor logServerExceptionWithResult:result];

    }
}


#pragma mark - error msg assemblers

- (NSString *)assembleErrorDetailForErrorCode:(int)errorCode errorMsg:(NSString *)errorMsg requestUrl:(NSString *)requestUrl{

    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (errorCode!=0) {
        [result appendFormat:@"ErrorCode = %d", errorCode];
    }
    
    if (errorMsg) {
        [result appendFormat:@"\nErrorMessage = %@", errorMsg];
    }
    
    return result;

}

#pragma mark -


- (void)REQUEST:(NSString *)requestType method:(NSString *)method requestBody:(id)requestBody randomRequestId:(BOOL)randomRequestId protocolVersion:(NSString *)protocolVersion{
    DSRequestInfo *req = [DSRequestInfo instance];
    [req setRequestType:requestType];
    [req setRequestBody:requestBody];
    [req setMethod:method];
    [req setProtocolVersion:protocolVersion];
    [req setRandomRequestId:randomRequestId];
    [self send:req];
}



@end
