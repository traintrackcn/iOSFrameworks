//
//  AGMultiValueView.h
//  AboveGEM
//
//  Created by traintrackcn on 5/1/15.
//
//

#import <UIKit/UIKit.h>

@protocol AGMultiValueViewDelegate <NSObject>

- (void)multiValueViewContentOffsetDidChange:(CGPoint)contentOffset;

@end

@interface AGMultiValueView : UIView{
    CGFloat paddingLR;
}

- (void)reloadData;
- (void)setContentOffset:(CGPoint)offset;
- (Class)collectionViewCellCls;

@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<AGMultiValueViewDelegate> delegate;
//@property (nonatomic, strong) Class collectionViewCellCls;


@end
