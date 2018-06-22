//
//  LITJSONLoader.m
//  testLITNetwork
//
//  Created by traintrackcn on 2018/6/16.
//  Copyright © 2018 traintrackcn. All rights reserved.
//

#import "LITJSONLoader.h"
#import "DSRequestInfo.h"
#import "AFHTTPRequestOperation.h"
#import "AGNetworkDefine.h"

@interface LITJSONLoader()

@property (nonatomic, strong) void(^completion)(id res);
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) LITJSONLoaderResponse *response;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@end

@implementation LITJSONLoader



- (void)requestWithCompletion:(void (^)(LITJSONLoaderResponse *res))completion{
    
    NSAssert(!self.loading, @"Please create multiple loaders for concurrent requests");
    TLOG(@"%@", self.debugDescription);
    if (self.requestBody){
        TLOG(@"%@", self.requestBody);
    }
    [self setLoading:YES];
    [self setCompletion:completion];
    
    if (self.cache) {
        [self.response setCode:@"Cached"];
        [self.response setParsedData:self.cache];
        [self complete];
        return;
    }
    [self enqueue:self.operation hideActivityIndicator:!self.indicator];
//    TLOG(@"");
}

- (void)dealloc{
    TLOG(@"%@",self.debugDescription);
}


#pragma mark - operation ops

- (void)operationSuccessfulWithResponse:(id)rawData{
    [self.response parse:self.operation];
    id parsedData = [self parseRawData:rawData];
    [self.response setParsedData:parsedData];
    [self complete];
}

- (void)operationFailedWithError:(id)rawError{
    [self.response parse:self.operation];
    id parsedError = [self parseRawError:rawError];
    [self.response setParsedError:parsedError];
    [self complete];
}

- (void)complete{
    TLOG(@"response code -> %@", self.response.code);
    [self.response setLoader:self];
    self.completion(self.response);
    [self reset];
}

- (void)reset{
    if (_operation) {
        [self dequeue:_operation];
        _operation = nil;
    }
    
    _completion = nil;
    _response = nil;
    
    [self setLoading:NO];
}

#pragma mark - parsers

- (id)parseRawData:(id)raw{
    return raw;
}

- (id)parseRawError:(id)raw{
    return raw;
}

#pragma mark - utils

- (id)decodeJSONString:(id)data{
    if ([data isKindOfClass:[NSString class]]){
        NSString * jsonString = data;
        NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error=nil;
        NSDictionary * jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        return jsonObj;
        //        TLOG(@"data -> %@ jsonObj -> %@", data, jsonObj);
    }
    return data;
}

#pragma mark - properties

- (NSString *)key{
    return [NSString stringWithFormat:@"%@", self];
}

- (NSString *)debugDescription{
    NSMutableString *str = [NSMutableString stringWithFormat:@"[%@] %@", self.method, self.serverUrl];
    
    if (![self.apiVersion isEqualToString:BLANK_API_VERSION]){
        [str appendFormat:@"/%@", self.apiVersion];
    }
    
    [str appendFormat:@"/%@", self.requestType];
    return str;
}

- (LITJSONLoaderResponse *)response{
    if (!_response) {
        _response = [LITJSONLoaderResponse instance];
    }
    return _response;
}

- (NSString *)requestType{
    return nil;
}

- (NSString *)method{
    return REQUEST_METHOD_GET;
}

- (id)requestBody{
    return nil;
}

- (AFHTTPRequestOperation *)operation{
    if (!_operation){
        _operation = [[AFHTTPRequestOperation alloc] initWithRequest:self.request];
        _operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        __weak LITJSONLoader *ws = self;
        [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ws operationSuccessfulWithResponse:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //        TLOG(@"before failure callback");
            [ws operationFailedWithError:error];
        }];
    }
    return _operation;
}

- (DSRequestInfo *)request{
    DSRequestInfo *r = [DSRequestInfo instance];
    [r setMethod:self.method];
    [r setRequestType:self.requestType];
    [r setRequestBody:self.requestBody];
    [r setApiVersion:self.apiVersion];
    [r setHeaders:self.headers];
    [r setServerUrl:self.serverUrl];
    [r setTimeoutInterval:self.timeoutInterval];
    [r assemble];
    return r;
}

- (id)cache{
    return nil;
}

- (id)apiVersion{
    return nil;
}

- (id)headers{
    return nil;
}

- (id)serverUrl{
    return nil;
}

- (BOOL)indicator{
    return YES;
}

- (NSTimeInterval)timeoutInterval{
    return 60;
}

@end
