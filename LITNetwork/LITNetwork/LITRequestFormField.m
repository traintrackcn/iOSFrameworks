//
//  LITRequestFormField.m
//  AGNetwork
//
//  Created by Tao Yunfei on 05/09/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import "LITRequestFormField.h"

@interface LITRequestFormField(){

}

@property (nonatomic, strong) NSString *mimeType;

@end

@implementation LITRequestFormField

@synthesize fileName = _fileName;

#pragma mark - setters



- (NSString *)mimeType{
    
    if ([self.fileName rangeOfString:@".jpg"].location != NSNotFound){
        return MIME_TYPE_IMAGE_JPEG;
    }
    
    if ([self.fileName rangeOfString:@".jpeg"].location != NSNotFound){
        return MIME_TYPE_IMAGE_JPEG;
    }
    
    if ([self.fileName rangeOfString:@".png"].location != NSNotFound){
        return MIME_TYPE_IMAGE_PNG;
    }
    
    return MIME_TYPE_APPLICATION_OCTET_STREAM;
    
}

#pragma mark - properties

- (NSData *)body{
    NSMutableData *d = [NSMutableData data];
    
    [d appendData:self.contentDisposition];
    
    if (self.fileName && [self.value isKindOfClass:[NSData class]]) {
        [d appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [d appendData:self.contentType];
        [d appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [d appendData:self.value];
    }else if([self.value isKindOfClass:[NSString class]]){
        [d appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [d appendData:[self.value dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [d appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return d;
}

- (NSData *)contentDisposition{
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", self.name]];
    if (self.fileName) [str appendFormat:@"; filename=\"%@\"",self.fileName]; 
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)contentType{
    if (!self.fileName) return nil;
    return [[NSString stringWithFormat:@"Content-Type: %@", self.mimeType] dataUsingEncoding:NSUTF8StringEncoding];
}

@end
