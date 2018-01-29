//
//  AGHorizontalViewControllerCellValue.h
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AGCollectionViewCellValue : NSObject

+ (instancetype)instance;

@property (nonatomic, strong) Class viewControllerCls;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSTextAlignment textAlignment;
//@property (nonatomic, weak) id parentViewController;

@end
