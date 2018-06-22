//
//  AGLineProgressCell.m
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGLineProgressCell.h"
#import "AGLineProgressView.h"
#import "AGProgressViewCellValue.h"


//#import "DSValueUtil.h"

@interface AGLineProgressCell(){
//    AGLineProgressView *progressView;
//    UILabel *titleLabel;
//    UILabel *subtitleLabel;
//    CGFloat paddingLR;
//    CGFloat spacing;
//    CGFloat titleH;
//    CGFloat subtitleH;
    
}

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subtitleView;
@property (nonatomic, strong) AGLineProgressView *progressView;

@end

@implementation AGLineProgressCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        progressH = 24.0;
        [self assemble];
    }
    return self;
}

- (void)applySelectedStyle{
    
}

#pragma mark - asssemblers

- (void)assemble{
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.subtitleView];
    [self.contentView addSubview:self.progressView];
}

- (UILabel *)titleView{
    if (!_titleView) {
        CGFloat x = self.paddingLR*2;
        CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
        //    CGFloat h = 20;
        CGFloat y = ([self.class height] - self.titleH - self.subtitleH - self.progressH - self.spacing*2)/2;
        
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, self.titleH)];
        [_titleView setFont:FONT_WITH_SIZE(16)];
        [_titleView setAdjustsFontSizeToFitWidth:YES];
        
        
        [_titleView setTextColor:COLOR(UI.LINE_PROGRESS_TITLE)];
    }
    return _titleView;
}


- (UILabel *)subtitleView{
    if (!_subtitleView) {
        CGFloat x = self.paddingLR*2;
        CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
        //    CGFloat h = 16;
        CGFloat y = self.titleView.frame.origin.y + self.titleView.frame.size.height + self.spacing;
        
        _subtitleView = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, self.subtitleH)];
        [_subtitleView setFont:[UIFont systemFontOfSize:11]];
        [_subtitleView setAdjustsFontSizeToFitWidth:YES];
        [_subtitleView setTextColor:COLOR(UI.LINE_PROGRESS_SUBTITLE)];
    }
    
    
    return _subtitleView;
//    [AGDebugUtil makeBorderForView:subtitleLabel];
}

- (AGLineProgressView *)progressView{
    if (!_progressView) {
        CGFloat x = self.paddingLR*2;
        CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
        //    CGFloat h = 24;
        
        CGFloat y = self.subtitleView.frame.origin.y+ self.subtitleView.frame.size.height + self.spacing;
        
        _progressView = [[AGLineProgressView alloc] initWithFrame:CGRectMake(x, y, w, self.progressH)];
        
        [_progressView assemble];
//        [AGDebugUtil makeBorderForView:_progressView];
    }
    return _progressView;
}

#pragma mark - 

- (void)setValue:(id)value{
    [super setValue:value];
    AGProgressViewCellValue *item = (AGProgressViewCellValue *)value;
    [self.progressView setProgress:item.percent];
    [self.titleView setText:[DSValueUtil toString:item.title]];
    [self.subtitleView setText:[DSValueUtil toString:item.subtitle]];
}

#pragma mark - styles

- (CGFloat)progressH{
    return 24.0;
}


+ (CGFloat)height{
    return 80;
}

- (CGFloat)paddingLR{
    return 8;
}

- (CGFloat)spacing{
    return 3.0;
}

- (CGFloat)titleH{
    return 16;
}

- (CGFloat)subtitleH {
    return 13;
}

@end
