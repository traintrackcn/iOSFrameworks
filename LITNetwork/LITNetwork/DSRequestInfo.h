//
//  DSRequestData.h
//  DirectSale
//
//  Created by Sean Guo on 7/16/12.
//  Copyright (c) 2012 Voxeo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REQUEST_METHOD_GET @"GET"
#define REQUEST_METHOD_POST @"POST"
#define REQUEST_METHOD_PUT @"PUT"
#define REQUEST_METHOD_DELETE @"DELETE"
#define REQUEST_METHOD_HEAD @"HEAD"

@interface DSRequestInfo : NSMutableURLRequest

+ (instancetype)instance;

- (NSString *)key;
- (void)assemble;


@property (nonatomic, strong) NSString *serverUrl;
@property (nonatomic, strong) NSURL *thirdPartyUrl;
@property (nonatomic, strong) NSDictionary *thirdPartyHeaders;
@property (nonatomic, strong) NSDictionary *headers;

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *apiVersion;
@property (nonatomic, retain) NSString *requestType;
@property (nonatomic, strong) id requestBody;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, assign) BOOL randomRequestId;
@property (nonatomic, assign) BOOL hideActivityIndicator;



@end
