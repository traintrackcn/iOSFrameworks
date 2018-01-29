//
//  NSString+AGUtils.m
//  AboveGEM
//
//  Created by traintrackcn on 29/10/14.
//
//

#import "NSString+AGUtils.h"
#import "NSString+HTML.h"

@implementation NSString (AGUtils)

-(NSString *) stringByStrippingHTML {
    NSString *s = [self copy];
//    return [s stringByDecodingHTMLEntities];
    return [s stringByConvertingHTMLToPlainText];
}

- (NSString *)stringByReplacingBackslashN{
    NSString *s = [self copy];
    NSString *key = @"\\n";
    s = [s stringByReplacingOccurrencesOfString:key withString:@"\n"];
    return s;
}



@end
