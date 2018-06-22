//
//  LITJsonLoaderResult.h
//  testLITNetwork
//
//  Created by traintrackcn on 2018/6/16.
//  Copyright © 2018 traintrackcn. All rights reserved.
//

#import <LITCommon/LITCommon.h>

@class AFHTTPRequestOperation;
@class LITJSONLoader;

@interface LITJSONLoaderResponse : AGModel

- (NSString *)key;

- (void)parse:(AFHTTPRequestOperation *)operation;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, weak) id metaData;
@property (nonatomic, copy) id headers;
@property (nonatomic, weak) id parsedData;
@property (nonatomic, weak) id parsedError;
@property (nonatomic, weak) LITJSONLoader *loader;

@end
