//
//  DAFileUtil.m
//  AGUIKit
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DAFileUtil.h"
#import "NSString+DAUtils.h"
#import "GlobalDefine.h"
@import UIKit;

@interface DAFileUtil(){
    
}

@property (nonatomic, strong) NSString *tmpDirectory;

@end

@implementation DAFileUtil

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createTmpDirectory];
    }
    return self;
}

#pragma mark - utils

- (void)clearTmpDirectory{
    NSError *error;
    NSString *dirPath = self.tmpDirectory;
    NSArray *files = [self.fm contentsOfDirectoryAtPath:dirPath error:&error];
    //    TLOG(@"files -> %@", files);
    for (NSString *fileName in files) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", dirPath, fileName];
        BOOL success = [self.fm removeItemAtPath:filePath error:&error];
        if (!success || error) {
            // it failed.
        }else{
            TLOG(@"tmp file %@ deleted", fileName);
        }
    }
}

- (BOOL)isExistLocalURL:(NSURL *)localURL{
    if(!localURL) return NO;
//    NSString *fileName = [self fileNameFromLocalURL:localURL];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@", self.tmpDirectory, fileName];
    NSString *path = localURL.path;
    NSError *error;
    NSDictionary *fileAttributes = [self.fm attributesOfItemAtPath:path error:&error];
    NSInteger fileSize = [fileAttributes fileSize];
//    TLOG(@"fileSize -> %ld", (long)fileSize);
    if (fileSize > 0) return YES;
    return NO;
}

- (void)createTmpDirectory{
    TLOG(@"");
    NSError *error;
    NSString *path = self.tmpDirectory;
    if (![self.fm fileExistsAtPath:path]){
        [self.fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            TLOG(@"error -> %@", error);
        }
    }
}

- (NSFileManager *)fm{
    return [NSFileManager defaultManager];
}


//------------------------------------------------------------------------------\

- (NSURL *)localURLForFileName:(NSString *)fileName{
    NSString *fileStr = [NSString stringWithFormat:@"%@/%@", self.tmpDirectory, fileName];
//        TLOG(@"fileStr -> %@", fileStr);
    return [NSURL URLWithString:fileStr];
}

- (NSURL *)localURLWithDownloadURL:(NSURL *)url{
    NSString *fileName = [self fileNameFromDownloadURL:url];
    NSString *fileStr = [NSString stringWithFormat:@"%@/%@", self.tmpDirectory, fileName];
    //    TLOG(@"fileStr -> %@", fileStr);
    return [NSURL URLWithString:fileStr];
}

- (NSString *)randomFileNameWithExtension:(NSString *)extension{
    NSString *fileName = [NSString randomStringWithLength:10];
    return [NSString stringWithFormat:@"%@.%@", fileName, extension];
}

- (NSString *)fileNameFromDownloadURL:(NSURL *)url{
    if (!url) return nil;
    
    NSString *str = url.absoluteString;
    NSArray *arr = [str componentsSeparatedByString:@"?"];
    str = arr.firstObject;
    arr = [str componentsSeparatedByString:@"/"];
    return arr.lastObject;
    
}

//- (NSString *)fileNameFromLocalURL:(NSURL *)url{
//    NSString *str = url.absoluteString;
//    NSArray *arr = [str componentsSeparatedByString:@"/"];
//    return arr.lastObject;
//}

#pragma mark -

- (BOOL)writeImage:(UIImage *)image toLocalURL:(NSURL *)localURL{
    NSString *path = localURL.absoluteString;
    return [UIImageJPEGRepresentation(image,.8) writeToFile:path atomically:YES];
}

#pragma mark - properties

- (NSString *)tmpDirectory{
    if (!_tmpDirectory) {
        _tmpDirectory = [NSString stringWithFormat:@"%@/tmp", self.applicationDocumentsDirectory];
    }
    return _tmpDirectory;
}

- (NSString *)applicationDocumentsDirectory{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = (docPaths.count > 0) ? docPaths.firstObject : nil;
    return docPath;
}

@end
