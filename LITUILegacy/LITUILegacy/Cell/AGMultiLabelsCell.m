//
//  AGMultiLableCell.m
//  AboveGEM
//
//  Created by traintrackcn on 17/11/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGMultiLabelsCell.h"

@interface AGMultiLabelsCell(){
    
}

@end

@implementation AGMultiLabelsCell

+ (CGFloat)height{
    return 70;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        separatorH = 10.0;
//        padding = 4.0;
//        paddingLR = 8.0;
//        accessoryW = 24.0;
        
        
//        labelW = [DSDeviceUtil bounds].size.width - self.paddingLR*2 - accessoryW;
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    }
    return self;
}

- (CGFloat)paddingLR{
    return 8.0;
}

- (CGFloat)separatorH{
    return 10.0;
}

- (CGFloat)padding{
    return 4.0;
}

- (CGFloat)accessoryW{
    return 24.0;
}

- (CGFloat)labelH{
    if (_labelH == 0) {
        _labelH = (([self.class height] - self.separatorH) - self.padding*3)/2;
    }
    return _labelH;
}

- (CGFloat)labelW{
    if (_labelW == 0) {
        _labelW = [DSDeviceUtil bounds].size.width - self.paddingLR*2 - self.accessoryW;
    }
    return _labelW;
}

- (void)assemble{
    
    [self assembleGC];
    [self.contentView addSubview:self.borderBottomViewStylePaddingL];
    
    [self assembleLineView];
    [self assembleSeparatorView];
}


- (void)assembleSeparatorView{
    CGFloat h = self.separatorH;
    CGFloat y = [self.class height] - h;
    CGFloat w = [DSDeviceUtil bounds].size.width;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, y, w, h)];
    [self.contentView addSubview:v];
    [v setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}

- (void)assembleLineView{
    CGFloat h = 1;
    CGFloat y = self.padding + self.labelH + self.padding/2;
    CGFloat w = self.labelW ;
    CGFloat x = self.paddingLR;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentView addSubview:v];
    [v setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}




@end
