//
//  DARequestUniversal.m
//  AGNetwork
//
//  Created by Tao Yunfei on 4/28/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;


#import "DARequestUniversal.h"
#import "AGRemoteUnit.h"


@interface DARequestUniversal(){
    AGRemoteUnitMethod _method;
    
    NSString *_requestType;
}

@end

@implementation DARequestUniversal

-(void)dealloc{
    TLOG(@"%@", _requestType);
}

#pragma mark - full function request

- (void)requestWithCompletion:(void (^)(id, id))completion method:(NSInteger)method requestType:(id)requestType requestBody:(id)requestBody protocolVersion:(id)protocolVersion headers:(id)headers{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //    @{
    //      @"request-type":requestType,
    if (requestType) [userInfo setValue:requestType forKey:@"request-type"];
    if (requestBody) [userInfo setValue:requestBody forKey:@"request-body"];
    if (protocolVersion) [userInfo setValue:protocolVersion forKey:@"protocol-version"];
    if (headers) [userInfo setValue:headers forKey:@"headers"];
    
    _requestType = requestType;
    
    _method = method;
    
    //    TLOG(@"requestType -> %@ requestBody -> %@ method -> %d", requestType, requestBody, method);
    
    [self requestWithCompletion:completion userInfo:userInfo];
}

#pragma mark -

- (void)requestWithCompletion:(void (^)(id, id))completion method:(NSInteger)method requestType:(id)requestType requestBody:(id)requestBody{
    [self requestWithCompletion:completion method:method requestType:requestType requestBody:requestBody protocolVersion:nil headers:nil];
}

- (void)requestWithRandomRequestIdWithCompletion:(void (^)(id, id))completion method:(NSInteger)method requestType:(id)requestType requestBody:(id)requestBody{
    [self setRandomRequestId:YES];
    [self requestWithCompletion:completion method:method requestType:requestType requestBody:requestBody];
    [self setRandomRequestId:NO];
}

- (void)requestSuccessfulWithCompletion:(void (^)(id, id))completion data:(id)data userInfo:(id)userInfo{
//    TLOG(@"data -> %@", data);
    completion(data, nil);
}

- (NSInteger)method{
//    TLOG(@"_method -> %d", _method);
    return _method;
}

- (id)requestType:(id)userInfo{
    return [userInfo objectForKey:@"request-type"];
}

- (id)requestBody:(id)userInfo{
    return [userInfo objectForKey:@"request-body"];
}

- (id)protocolVersion:(id)userInfo{
    return [userInfo objectForKey:@"protocol-version"];
}

- (id)headers:(id)userInfo{
    return [userInfo objectForKey:@"headers"];
}

@end
