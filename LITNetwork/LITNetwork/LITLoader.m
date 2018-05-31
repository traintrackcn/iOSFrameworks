//
//  LITCollectionLoader.m
//  AboveGEM
//
//  Created by Tao Yunfei on 22/08/2017.
//
//

@import LITCommon;

#import "LITLoader.h"
#import "DARequestUniversal.h"

@interface LITLoader(){
    DARequestUniversal *_l;
}

@property (nonatomic, strong) void(^completion)(id data, id error);
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) id responseMetaData;
@property (nonatomic, strong) id responseHeaders;



@end

@implementation LITLoader


- (void)cancel{
    [_l cancel];
}

#pragma mark -

- (void)dealloc{
    
    TLOG(@"%@", NSStringFromClass(self.class));
}

- (void)requestWithCompletion:(void (^)(id, id))completion{
    [self setCompletion:completion];
    
    
    id requestBody = self.requestBody;
    
//    @try {
//        requestBody = self.requestBody;
//    } @catch (NSException *exception) {
//        TLOG(@"[%@] exception -> %@", NSStringFromClass(self.class), exception);
//        [self completion:nil error:exception];
//        return;
//    } 
    
    if (self.debug){
        TLOG(@"[%@] %@ %@", self.textMethod, self.requestType, requestBody);
        [self setCompletion:nil];
        return;
    }
    
    if (self.cache) {
        [self completion:self.cache error:nil];
        return;
    }
    
    [self setLoading:YES];
    _l = [DARequestUniversal instance];
    [_l requestWithCompletion:^(id data, id error) {
        [self requestCallback:data error:error responseMeta:_l.responseMetaData responseHeaders:_l.responseHeaders];
    } method:self.method requestType:self.requestType requestBody:requestBody apiVersion:self.apiVersion headers:self.headers serverUrl:self.serverUrl];
    
}

- (void)requestCallback:(id)data error:(id)error responseMeta:(id)meta responseHeaders:(id)headers{
    
    [self setResponseMetaData:meta];
    [self setResponseHeaders:headers];
    
    if (error) {
        [self completion:data error:error];
        return;
    }
    
    [self parse:data];
}

- (void)completion:(id)parsedData error:(id)error{
//    TLOG(@"self.completion -> %@", self.completion);
//    TLOG(@"parsedData -> %@ completion -> %@", parsedData, self.completion);
    if(self.completion) self.completion(parsedData, error);
    [self setCompletion:nil];
    
    [self setLoading:NO];
    
    _l = nil;
}

- (void)parse:(id)data{
    if (_delegate && [_delegate respondsToSelector:@selector(parse:)]){
        [_delegate parse:data];
    }
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

- (NSString *)requestType{
    if (_delegate && [_delegate respondsToSelector:@selector(requestType)]){
        return [_delegate requestType];
    }
    return nil;
}

- (AGRemoteUnitMethod)method{
    if (_delegate && [_delegate respondsToSelector:@selector(method)]){
        return [_delegate method];
    }
    return AGRemoteUnitMethodGET;
}

- (id)requestBody{
    if (_delegate && [_delegate respondsToSelector:@selector(requestBody)]){
        return [_delegate requestBody];
    }
    return nil;
}

- (id)cache{
    if (_delegate && [_delegate respondsToSelector:@selector(cache)]){
        return [_delegate cache];
    }
    return nil;
}

- (id)apiVersion{
    if (_delegate && [_delegate respondsToSelector:@selector(apiVersion)]){
        return [_delegate apiVersion];
    }
    return nil;
}

- (id)headers{
    if (_delegate && [_delegate respondsToSelector:@selector(headers)]){
        return [_delegate headers];
    }
    return nil;
}

- (id)serverUrl{
    if (_delegate && [_delegate respondsToSelector:@selector(serverUrl)]){
        return [_delegate serverUrl];
    }
    return nil;
}

//- (id)requestForm{
//    if (_delegate && [_delegate respondsToSelector:@selector(requestForm)]){
//        return [_delegate requestForm];
//    }
//    return nil;
//}

- (BOOL)debug{
    return NO;
}

#pragma mark -

- (NSString *)textMethod{
    if (self.method == AGRemoteUnitMethodDELETE) return @"DELETE";
    if (self.method == AGRemoteUnitMethodPOST) return @"POST";
    if (self.method == AGRemoteUnitMethodPUT) return @"PUT";
    if (self.method == AGRemoteUnitMethodHEAD) return @"HEAD";
    return @"GET";
}

@end
