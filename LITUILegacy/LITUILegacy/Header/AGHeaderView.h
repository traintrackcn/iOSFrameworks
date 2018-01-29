//
//  AGHeader.h
//  AboveGEM
//
//  Created by traintrackcn on 21/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HeaderAndCell.h"

@class AGObjectPool;

@interface AGHeaderView : UIView{

}

- (void)_setValue:(id)value;
- (void)didTap:(id)sender __attribute__((deprecated(("Use [self didTapAny:] instead"))));
- (NSIndexPath *)indexPath;
+ (CGFloat)height;

@property (nonatomic, strong) AGObjectPool *objPool;
@property (nonatomic, weak) id associatedViewController;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id title;
@property (nonatomic, assign) CGFloat height;

@end
