//
//  AGOperationResult.m
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGRemoterResult.h"
#import "AGRemoterError.h"

@implementation AGRemoterResult

#pragma mark -

- (NSString *)type{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)self.code];
    
    if ([self isCanceled]) {
        str = @"CANCELED";
    }else if([self isTimeout]){
        str = @"TIMEOUT";
    }else if ([self isNotModified]){
        str = @"Not Modified";
    }else if ([self isInvalidConnection]){
        str = @"Invalid Connection";
    }else if ([self isInvalidAuthentication]){
        str = @"Invalid Authentication";
    }
    
    return str;
}

- (BOOL)isTimeout{
    if (self.code==504) return YES;
    return NO;
}

- (BOOL)isNotModified{
    if (self.code == 304) return YES;
    return NO;
}

- (BOOL)isInvalidAuthentication{
    if (self.code == 401) return YES;
    return NO;
}

- (BOOL)isCanceled{
    if (self.code == 1) return YES;
    return NO;
}

- (BOOL)isInvalidConnection{
    if (self.code == 0) return YES;
    return NO;
}

//defines error when get invalid content or content not modified
- (BOOL)isError{
    if (self.code == 200) return NO;
    if (self.code == 201) return NO;
    if (self.code == 204) return NO;
    if (self.code == 304) return NO; //content not modified
    return YES;
}


#pragma mark - 

- (void)parseError:(NSError *)error errorRaw:(id)errorRaw responseRaw:(id)responseRaw{
//    TLOG(@"error -> %@ errorRaw -> %@ responseRaw -> %@", error, errorRaw, responseRaw);
    if(!error && !errorRaw && !responseRaw ) return;
    
    AGRemoterError *errorParsed = [AGRemoterError instance];
    if (error) [errorParsed parseError:error];
    if (errorRaw) [errorParsed parseErrorRaw:errorRaw];
    if (responseRaw) [errorParsed parseResponseRaw:responseRaw];
    
    [errorParsed setResult:self];
    [self setErrorParsed:errorParsed];
    [self setErrorOriginal:error];
}

@end
