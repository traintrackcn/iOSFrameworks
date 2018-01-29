//
//  AGAttributedStringCell.m
//  AboveGEM
//
//  Created by traintrackcn on 12/11/14.
//
//

#import "AGAttributedStringCell.h"

@interface AGAttributedStringCell(){
    NSString *htmlLoaded;
    UITextView *textV;
}

@end

@implementation AGAttributedStringCell

+ (CGFloat)height{
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self assembleTextView];
    }
    return self;
}

- (void)assembleTextView{
    CGFloat w = self.frame.size.width;
    CGFloat h = [self.class height];
    textV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [textV setEditable:NO];
    [self.contentView addSubview:textV];
    
//    NSAttributedString *attrStr = [[NSAttributedString alloc]
//                                   initWithFileURL:html
//                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
//                                   documentAttributes:nil error:nil];
    
    
}

- (void)setHtml:(NSString *)html{
    
    
    if ([htmlLoaded isEqualToString:html]) return;
    
    htmlLoaded = html;
    
    NSAttributedString *attrStr = [[NSAttributedString alloc]
                                   initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                   documentAttributes:nil error:nil];
    
//    CGFloat w = self.frame.size.width;
//    CGFloat h = CGFLOAT_MAX;
//    CGRect frame = [attrStr boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    
//    TLOG(@"frame -> %@", NSStringFromCGRect(frame));
    
    [textV setAttributedText:attrStr];
    
}

- (void)setValue:(id)value{
    [self setHtml:(NSString *)value];
}

@end
