//
//  AGVCSuccessMessagesView.m
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGVCSuccessMessagesView.h"

@interface AGVCSuccessMessagesView(){
    UILabel *contentLabel;
}

@end

@implementation AGVCSuccessMessagesView

- (id)init{
    self = [super init];
    if (self) {
        [self setBackgroundColor:COLOR(RGB_AVC_SUCCESS_MESSAGE_BACKGROUND)];
        [self assembleLabel];
    }
    return self;
}

#pragma mark - assemblers

- (void)assembleLabel{
    UIColor *c = COLOR(RGB_AVC_SUCCESS_MESSAGE_TITLE);
    contentLabel = [[UILabel alloc] init];
    [contentLabel setTextColor:c];
    //    [contentLabel setBackgroundColor:RGBA(254, 207, 208, 1)];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:FONT_WITH_SIZE(16)];
    [self addSubview:contentLabel];
    
}

#pragma mark - layout

- (void)layoutContentLabel{
    //    CGRect frame;
    CGRect bounds = [DSDeviceUtil bounds];
    CGFloat paddingLR = 8.0;
    CGFloat paddingTB = 8.0;
    CGRect frame;
    CGFloat w = bounds.size.width- paddingLR*2;
    
    if ([DSDeviceUtil iOS7AndAbove]) {
        NSDictionary *attributes = @{  NSFontAttributeName: contentLabel.font};
        frame = [contentLabel.text boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil];
    }else{
//        frame.size = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(w, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        frame.size = [contentLabel.text sizeWithAttributes:
                      @{NSFontAttributeName:contentLabel.font}];
    }
    
    
    
    frame.origin = CGPointMake(paddingLR, paddingTB);
    [contentLabel setFrame:frame];
    
    [self setFrame:CGRectMake(0, 0, 0, frame.size.height + paddingTB*2)];
}

#pragma mark - update views

- (void)updateMessages:(NSArray *)messages{
    NSString *text = [self formatMessages:messages];
    [contentLabel setText:text];
    [self layoutContentLabel];
}

- (NSString *)formatMessages:(NSArray *)messages{
    NSMutableArray *msgs = [NSMutableArray array];
    for (int i=0; i<[messages count]; i++) {
        NSDictionary *msg = [messages objectAtIndex:i];
        [msgs addObject:[NSString stringWithFormat:@"* %@", msg]];
    }
    
    return [msgs componentsJoinedByString:@"\n"];
}


@end
