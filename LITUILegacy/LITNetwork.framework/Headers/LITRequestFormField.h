//
//  LITRequestFormField.h
//  AGNetwork
//
//  Created by Tao Yunfei on 05/09/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

//#import "AGModel.h"
@import LITCommon;

#define MIME_TYPE_IMAGE_JPEG @"image/jpeg"
#define MIME_TYPE_IMAGE_PNG @"image/png"
#define MIME_TYPE_APPLICATION_OCTET_STREAM @"application/octet-stream"

@interface LITRequestFormField : AGModel

- (NSData *)body;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) id value;


@end
