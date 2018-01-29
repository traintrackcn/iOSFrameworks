//
//  DACSVUtil.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/21/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "NSString+CSVUtils.h"

@implementation NSString (CSVUtils)

+ (NSString *)removeQuoteForField:(NSString *)field{
    if (field.length<3) return field;
    NSInteger len = field.length;
    NSString *firstChar = [field substringWithRange:NSMakeRange(0, 1)];
    NSString *lastChar = [field substringWithRange:NSMakeRange(len-1, 1)];
    if ([firstChar isEqualToString:@"\""] && [lastChar isEqualToString:@"\""]) {
        return [field substringWithRange:NSMakeRange(1, len-2)];
    }
    return field;
}

@end
