//
//  AGMultipleViewControllersCell.m
//  AboveGEM
//
//  Created by traintrackcn on 10/12/14.
//
//

@import LITCommon;

#import "AGHorizontalViewControllersCell.h"
#import "AGCollectionViewCellViewController.h"
#import "AGCollectionViewLayout.h"
#import "AGCollectionViewLayoutHorizontalPages.h"
#import "AGViewController.h"
//#import "GlobalDefine.h"
#import "AGVCConfiguration.h"

NSString *AGHorizontalViewControllersCellDidChange = @"AGHorizontalViewControllersCellDidChange";

@interface AGHorizontalViewControllersCell() <UICollectionViewDelegate>{
}

@end

@implementation AGHorizontalViewControllersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.layer.borderWidth = 1;
    }
    return self;
}

#pragma mark - properties

- (Class)collectionViewCellCls{
    return [AGCollectionViewCellViewController class];
}

- (void)didSelectItem:(id)item{
    TLOG(@"item -> %@", item);
    NSDictionary *action = @{@"type":AGHorizontalViewControllersCellDidChange,@"value":item};
    [self sendActionRequestToViewController:action];
    
}


- (void)didDisplayCell:(id)cell{
    AGCollectionViewCellViewController *vcCell = (AGCollectionViewCellViewController *)cell;
    AGViewController *vc = vcCell.viewController;
    if (vc) {
        [vc viewWillAppear:NO];
    }
}


#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    AGCollectionViewCellViewController *vcCell = (AGCollectionViewCellViewController *)cell;
//    AGViewController *vc = vcCell.viewController;
//    TLOG(@"vc -> %@ cell->%@ ", vc, vcCell);
//    if (vc) {
//        [vc viewWillAppear:NO];
//    }
//}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    AGCollectionViewCellViewController *vcCell = (AGCollectionViewCellViewController *)cell;
    AGViewController *vc = vcCell.viewController;
//    TLOG(@"vc -> %@ cell->%@ ", vc, vcCell);
    if (vc) {
        [vc viewDidDisappear:NO];
    }
}


@end
