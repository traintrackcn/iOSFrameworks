//
//  AGCollectionViewCellTabBar.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGCollectionViewCellTab.h"
#import "AGCollectionViewCellValue.h"

@interface AGCollectionViewCellTab(){
    
}

@property (nonatomic, strong) UIImageView *pointIconView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AGCollectionViewCellTab


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.pointIconView];
//        [self setBackgroundColor:COLOR(AGUIDEFINE.RGB_BACKGROUND_TAB_BAR)];
    }
    return self;
}


#pragma mark - assemblers

- (UILabel *)titleLabel{
    if (!_titleLabel){
        CGFloat spacing = 0;
        CGFloat x = spacing;
        CGFloat y = spacing;
        CGFloat w = self.frame.size.width - spacing*2;
        CGFloat h = self.frame.size.height - spacing *2 - 1;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
//        _titleLabel.layer.borderWidth = 1;
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [_titleLabel setBackgroundColor:COLOR(AGUIDEFINE.RGB_BACKGROUND_TAB_BAR)];
    }
    
    return _titleLabel;
}

- (UIImageView *)pointIconView{
    if (!_pointIconView) {
        CGFloat h = 10;
        CGFloat w = 16;
        CGFloat y = self.frame.size.height - h;
        CGFloat x = (self.frame.size.width - w)/2.0;
        _pointIconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        UIImage *img = [DSImage triangleWithSize:CGSizeMake(w, h) fillColor:COLOR(RGB_WHITE) borderColor:COLOR(AGUI.RGB_BORDER_DARKER)];
        [_pointIconView setImage:img];
//        [AGDebugUtil makeBorderForView:_pointIconView];
    }
    return _pointIconView;
}

#pragma mark -

- (void)setSelected:(BOOL)selected{
    if (selected) {
        [self.titleLabel setFont:FONT_WITH_SIZE(13.0)];
        [self.titleLabel setTextColor:COLOR(AG_UI_DEFINE.RGB_THEME)];
        [self.pointIconView setHidden:NO];
    }else{
        [self.titleLabel setFont:FONT_WITH_SIZE(13.0)];
        [self.titleLabel setTextColor:COLOR(AG_UI_DEFINE.RGB_TAB_BAR_NORMAL)];
        [self.pointIconView setHidden:YES];
    }
}



#pragma mark -

- (void)setValue:(id)aValue{
    [super setValue:aValue];
//    TLOG(@"value -> %@", self.value);
    [self.titleLabel setText:[DSValueUtil toString:[(AGCollectionViewCellValue *)self.value value]].uppercaseString];
//    [self.titleLabel sizeToFit];
//    [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width,10000)];
}


@end
