//
//  LITCollectionLoader.h
//  AboveGEM
//
//  Created by Tao Yunfei on 22/08/2017.
//
//

@import LITCommon;

#import "AGRemoteUnit.h"

@protocol LITLoaderDelegate <NSObject>

@required
- (void)parse:(id)data;
- (NSString *)requestType;

@optional
- (AGRemoteUnitMethod)method;
- (NSString *)apiVersion;
- (id)requestBody;
//- (id)requestForm;
- (id)cache;
- (id)headers;
- (id)serverUrl;

@end

@interface LITLoader : AGModel

- (void)requestWithCompletion:(void (^)(id parsedData, id error))completion;
- (void)completion:(id)data error:(id)error;
- (BOOL)debug;
- (BOOL)loading;
- (id)responseMetaData;
- (id)responseHeaders;
- (void)cancel;

#pragma mark - utils
- (id)decodeJSONString:(id)data;

@property (nonatomic, weak) id<LITLoaderDelegate> delegate;

@end
