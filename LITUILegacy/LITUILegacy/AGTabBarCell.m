//
//  AGHorizontalTabsCell.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

@import LITUICommon;

#import "AGTabBarCell.h"
#import "AGCollectionViewCellTab.h"

NSString *AGTabBarCellDidChange = @"AGTabBarCellDidChange";

@implementation AGTabBarCell


+ (CGFloat)height{
    return 44.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self assembleBottomBorder];
//        [collectionV setBackgroundColor:self.backgroundColorValue];
        [self.contentView insertSubview:self.borderBottomViewStyleSolid belowSubview:self.collectionView];
//        [self.collectionView setBackgroundColor:COLOR(AGUIDEFINE.RGB_BACKGROUND_TAB_BAR)];
        [self.contentView setBackgroundColor:COLOR(AG_UI_DEFINE.RGB_TAB_BAR_BACKGROUND)];
    }
    return self;
}

- (Class)collectionViewCellCls{
    return [AGCollectionViewCellTab class];
}

- (void)didSelectItem:(id)item{
    NSDictionary *action = @{@"type":AGTabBarCellDidChange,@"value":item};
    [self sendActionRequestToViewController:action];
    
}

- (void)setValue:(id)value{
    [self setItems:value];
}

#pragma mark - styles

- (UIColor *)borderColor{
    return COLOR(AG_UI_DEFINE.RGB_BORDER_DARKER);
}

@end
