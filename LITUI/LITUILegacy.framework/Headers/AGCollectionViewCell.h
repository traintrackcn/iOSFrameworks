//
//  AGCollectionViewCell.h
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGViewController;
@class AGObjectPool;

@interface AGCollectionViewCell : UICollectionViewCell{
}

@property (nonatomic, strong) id value;
@property (nonatomic, weak) AGViewController *associatedViewController;
@property (nonatomic, strong) AGObjectPool *objPool;

@end
