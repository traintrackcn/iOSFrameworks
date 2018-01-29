//
//  LITRequestForm.h
//  AGNetwork
//
//  Created by Tao Yunfei on 05/09/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

@import LITCommon;

@class LITRequestFormField;
@interface LITRequestForm : AGModel

- (void)appendField:(LITRequestFormField *)field;

- (NSData *)boundary;
- (NSData *)boundaryEnd;
- (NSString *)boundarySymbol;
- (NSMutableArray *)fields;


@end
