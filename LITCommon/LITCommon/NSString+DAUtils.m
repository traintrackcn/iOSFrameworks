//
//  NSString+DAUtils.m
//  Distributors
//
//  Created by Tao Yunfei on 4/27/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "NSString+DAUtils.h"

@implementation NSString (DAUtils)

- (NSNumber *)numberValue{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:self];
}

+ (NSString *)randomStringWithLength: (NSInteger)len{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i=0; i<len; i++) {
        NSInteger idx = arc4random()%letters.length;
        [randomString appendFormat: @"%C", [letters characterAtIndex: idx]];
    }

    return randomString;
    
}

@end
