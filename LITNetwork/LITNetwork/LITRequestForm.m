//
//  LITRequestForm.m
//  AGNetwork
//
//  Created by Tao Yunfei on 05/09/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import "LITRequestForm.h"
#import "LITRequestFormField.h"

@interface LITRequestForm(){

}

@property (nonatomic, strong) NSMutableArray *fields;
@property (nonatomic, strong) NSData *boundary;
@property (nonatomic, strong) NSData *boundaryEnd;
@property (nonatomic, strong) NSString *boundarySymbol;

@end

@implementation LITRequestForm

- (void)appendField:(LITRequestFormField *)field{
    [self.fields addObject:field];
}

#pragma mark - properties

- (NSMutableArray *)fields{
    if (!_fields){
        _fields = [NSMutableArray array];
    }
    return _fields;
}

- (NSData *)boundary{
    if (!_boundary){
        _boundary = [[NSString stringWithFormat:@"--%@\r\n", self.boundarySymbol] dataUsingEncoding:NSUTF8StringEncoding];
    }
    return _boundary;
}

- (NSData *)boundaryEnd{
    if (!_boundaryEnd){
        _boundaryEnd = [[NSString stringWithFormat:@"--%@--\r\n", self.boundarySymbol] dataUsingEncoding:NSUTF8StringEncoding];
    }
    return _boundaryEnd;
}

- (NSString *)boundarySymbol{
    if (!_boundarySymbol){
        _boundarySymbol= [NSString stringWithFormat:@"%06X", (arc4random() % 16777216)];
    }
    return _boundarySymbol;
}

@end
