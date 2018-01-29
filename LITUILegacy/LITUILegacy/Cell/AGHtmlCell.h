//
//  AGHtmlCell.h
//  AboveGEM
//
//  Created by traintrackcn on 16/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"

@interface AGHtmlCell : AGCell <UIWebViewDelegate>{
    UIWebView *htmlView;
}

- (UIWebView *)htmlView;
- (void)setHtml:(NSString *)html;

@end
