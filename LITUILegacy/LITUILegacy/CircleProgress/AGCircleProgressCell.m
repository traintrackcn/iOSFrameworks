//
//  AGCircleProgressCell.m
//  AboveGEM
//
//  Created by traintrackcn on 28/12/14.
//
//

@import LITCommon;

#import "AGCircleProgressCell.h"
#import "AGCircleProgressView.h"
//#import "GlobalDefine.h"
//#import "DSDeviceUtil.h"
//#import "DSValueUtil.h"

@interface AGCircleProgressCell(){
    AGCircleProgressView *progressView;
}

@end

@implementation AGCircleProgressCell

+ (CGFloat)height{
    return 180;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self assembleProgressView];
    }
    return self;
}

- (void)applySelectedStyle{
    
}

#pragma mark - asssemblers

- (void)assembleProgressView{
//    if ([])
    //    CGFloat paddingTB = 20
    CGFloat w = self.height;
    CGFloat h = w;
    CGFloat x = ([DSDeviceUtil bounds].size.width - w)/2.0;
    CGFloat y = 0;
    
    progressView = [[AGCircleProgressView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    [progressView setStatusText:@"COMPLETED"];
    [self.contentView addSubview:progressView];
    [progressView assemble];
//    [progressView setProgress:.1];
}

#pragma mark - setter

- (void)setValue:(id)value{
    if ([DSValueUtil isNotAvailable:value]) return;
    if ([value isKindOfClass:[NSNumber class]]) {
        TLOG(@"value -> %@", value);
        [progressView setProgress:[(NSNumber *)value doubleValue]*100];
    }
}

@end
