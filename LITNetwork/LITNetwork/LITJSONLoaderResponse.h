//
//  LITJsonLoaderResult.h
//  testLITNetwork
//
//  Created by traintrackcn on 2018/6/16.
//  Copyright © 2018 traintrackcn. All rights reserved.
//

#import <LITCommon/LITCommon.h>

@class AFHTTPRequestOperation;
@interface LITJSONLoaderResponse : AGModel

- (void)parse:(AFHTTPRequestOperation *)operation;


@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) id metaData;
@property (nonatomic, copy) id headers;
@property (nonatomic, strong) id parsedData;
@property (nonatomic, strong) id parsedError;

@end
