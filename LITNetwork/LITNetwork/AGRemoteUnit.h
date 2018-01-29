//
//  AGRemoteDataCoordinator.h
//  AboveGEM
//
//  Created by traintrackcn on 20/1/15.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AGRemoteUnitMethod) {
    AGRemoteUnitMethodGET,
    AGRemoteUnitMethodPOST,
    AGRemoteUnitMethodPUT,
    AGRemoteUnitMethodDELETE,
    AGRemoteUnitMethodHEAD
};

@interface AGRemoteUnit : NSObject

+ (instancetype)instance;

//- (id)processResponseData:(id)responseData;
- (id)didGetResponseData:(id)responseData;
- (id)didGetResponseHeaders:(id)responseHeaders;

- (void)requestWithCompletion:(void(^)(id data, id error))completion;
- (void)reset;
- (void)cancel;

- (BOOL)isRequesting;
//- (BOOL)isDataCached;

- (id)responseData;
- (id)responseHeaders;
- (id)responseError;
- (id)responseMetaData;

@property (nonatomic, assign) AGRemoteUnitMethod method;
@property (nonatomic, strong) NSString *requestType;
@property (nonatomic, strong) id requestBody;
@property (nonatomic, strong) NSString *protocolVersion;

@property (nonatomic, strong) NSURL *thirdPartyUrl;
@property (nonatomic, strong) id thirdPartyHeaders;
@property (nonatomic, strong) id headers;
@property (nonatomic, strong) id userInfo;

@property (nonatomic, assign) BOOL randomRequestId;
@property (nonatomic, assign) BOOL hideActivityIndicator;
@property (nonatomic, assign) BOOL cacheEnabled;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@end
