//
//  LITFileUploader.m
//  AboveGEM
//
//  Created by Tao Yunfei on 05/09/2017.
//
//

@import LITCommon;

#import "LITFileUploader.h"
#import "LITRequestForm.h"
#import "LITRequestFormField.h"
#import "LITAsset.h"
#import "AGRemoteUnit.h"

@interface LITFileUploader()<LITLoaderDelegate>

@end

@implementation LITFileUploader

- (void)parse:(id)data{
    TLOG(@"data -> %@", data);
    LITAsset *asset = [[LITAsset alloc] initWithRaw:data];
    [self completion:asset error:nil];
}

- (NSString *)requestType{
    return RT_FILES;
}

- (AGRemoteUnitMethod)method{
    return AGRemoteUnitMethodPOST;
}

- (id)cache{
    return nil;
}

- (id)requestBody{
    LITRequestForm *form = [LITRequestForm instance];
    LITRequestFormField *field;
    
    field = [LITRequestFormField instance];
    [field setName:@"file"];
    [field setFileName:@"file.jpg"];
    [field setValue:self.data];
    
    [form appendField:field];
    
    field = [LITRequestFormField instance];
    [field setName:@"type"];
    [field setValue:self.type];
    [form appendField:field];
    
    return form;
}

@end
