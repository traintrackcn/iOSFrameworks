//
//  AGHtmlCell.m
//  AboveGEM
//
//  Created by traintrackcn on 16/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGHtmlCell.h"
#import "AGViewController.h"
#import "AGVCConfiguration.h"

@interface AGHtmlCell(){
    CGFloat htmlViewRealH;
    BOOL isErrorOccurred;
    NSString *htmlLoaded;
    NSMutableDictionary *requestDic;
}

@end

@implementation AGHtmlCell

+ (CGFloat)height{
    return 0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        requestDic = [NSMutableDictionary dictionary];
        [self assembleHtmlView];
    }
    return self;
}

- (void)dealloc{
    TLOG(@"%@",self.class);
    [htmlView stopLoading];
    [htmlView loadHTMLString:@"" baseURL:nil];
    [htmlView setDelegate:nil];
    
    htmlView = nil;
}



#pragma mark - assemblers

- (void)assembleHtmlView{
    htmlView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, 155)];
    [htmlView setDelegate:self];
    [htmlView.scrollView setScrollEnabled:NO];
//    [htmlView setScalesPageToFit:YES];
    [self.contentView addSubview:htmlView];
}

#pragma mark - properties

- (UIWebView *)htmlView{
    return htmlView;
}

#pragma mark - cell

- (void)setValue:(id)value{
    [self setHtml:value];
}

- (void)setHtml:(NSString *)html{
    
    
    //auto word-brake
    html = [NSString stringWithFormat:@"%@%@%@", @"<div style=\"width:100%;word-wrap: break-word;word-break: normal;\">", html, @"</div>"];
    
//    TLOG(@"[htmlLoaded isEqualToString:html] -> %d", [htmlLoaded isEqualToString:html]);
    
    if ([htmlLoaded isEqualToString:html]) {
        // do reload to avoid memory leakage
        [htmlView reload];
        return;
    }
//    TLOG(@"%@ -> %@",[self class], html);
    
    [htmlView loadHTMLString:html baseURL:nil];
    htmlLoaded = html;
}

//    [[(AGDescriptionCell *)cell htmlView] setFrame:descriptionHtmlViewFrame];


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    isErrorOccurred = NO;
    
    [requestDic setValue:request forKey:request.URL.absoluteString];
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        return YES;
    }
    //    TLOG(@"request -> %@ navigationType -> %ld", request, (long)navigationType);
    [[ UIApplication sharedApplication ] openURL:request.URL];
    return NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    TLOG(@"error -> %@", error);
//    NSURL *url = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];
//    AGRemoterResult *result = [[AGRemoter singleton] assembleResultForError:error];
//    DSRequest *req = [requestDic objectForKey:url.absoluteString];
//    [result setRequest:req];
//    [result setCode:AGResultCodeUnknown];
    
    
    isErrorOccurred = YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    [webView setFrame:frame];
    frame.size = [webView sizeThatFits:CGSizeZero];
    [webView setFrame:frame];
    
    CGFloat targetH = frame.size.height;
    
//    if (isErrorOccurred) {
//        targetH = 0;
//    }
    
//    TLOG(@"===== htmlViewRealH -> %f targetH -> %f", htmlViewRealH, targetH);
    
    
    if (targetH != htmlViewRealH) {
        htmlViewRealH = targetH;
        [[(AGViewController *)self.associatedViewController config] setCellHeight:htmlViewRealH atIndexPath:self.indexPath];
        [self.associatedViewController reloadIndexPath:self.indexPath animated:NO];
//        [self.associatedViewController reloadVisibleIndexPathsInSection:self.indexPath.section animated:NO];
    }
    
//    TLOG(@"");
}



@end
