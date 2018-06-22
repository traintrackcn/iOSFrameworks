//
//  LITJSONLoader.h
//  testLITNetwork
//
//  Created by traintrackcn on 2018/6/16.
//  Copyright © 2018 traintrackcn. All rights reserved.
//

#import "DANetworkLoader.h"
#import "LITJSONLoaderResponse.h"
#import "NSObject+LITJSONLoader.h"

@interface LITJSONLoader : DANetworkLoader

- (NSString *)key;

#pragma mark - main ops
- (void)requestWithCompletion:(void (^)(LITJSONLoaderResponse *res))completion;

#pragma mark - properties
- (NSString *)method;
- (NSString *)requestType;
- (NSTimeInterval)timeoutInterval;
- (BOOL)indicator; 
- (id)requestBody;
- (id)cache;
- (id)apiVersion;
- (id)headers;
- (id)serverUrl;

#pragma mark - parsers
- (id)parseRawData:(id)raw;
- (id)parseRawError:(id)raw;

#pragma mark -
- (BOOL)loading;

#pragma mark - utils
- (id)decodeJSONString:(id)data;

@end
