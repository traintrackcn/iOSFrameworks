//
//  LITJsonLoaderResult.m
//  testLITNetwork
//
//  Created by traintrackcn on 2018/6/16.
//  Copyright © 2018 traintrackcn. All rights reserved.
//

#import "LITJSONLoaderResponse.h"
#import "AFHTTPRequestOperation.h"
#import "LITJSONLoader.h"

@implementation LITJSONLoaderResponse

- (void)parse:(AFHTTPRequestOperation *)operation{
    
    NSHTTPURLResponse *response = operation.response;
    [self setCode:[NSString stringWithFormat:@"%@", @(response.statusCode)]];
    [self setHeaders:response.allHeaderFields];

    if (operation.isCancelled) [self setCode:@"Cancelled"];
}

- (NSString *)key{
    return self.loader.key;
}

@end
