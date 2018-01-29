//
//  LITFileUploader.h
//  AboveGEM
//
//  Created by Tao Yunfei on 05/09/2017.
//
//

#import "LITLoader.h"

#define RT_FILES @"files"
#define FILE_TYPE_AVATAR @"Avatar"

@interface LITFileUploader : LITLoader

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSData *data;

@end
