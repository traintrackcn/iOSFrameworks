//
//  AGCollectionViewCellViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 10/12/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGCollectionViewCellViewController.h"
#import "AGViewController.h"
#import "AGCollectionViewCellValue.h"

@interface AGCollectionViewCellViewController(){
//    Class vcCls;
//    AGViewController *vc;
    AGCollectionViewCellValue *value;
}



@end

@implementation AGCollectionViewCellViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    TLOG(@"frame -> %@", NSStringFromCGRect(self.frame));
    if (self) {
        [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleVC{
    if ([DSValueUtil isAvailable:self.viewController]) return;
    self.viewController = [[value.viewControllerCls alloc] init];
    [self.associatedViewController addChildViewController:self.viewController];
    [self.viewController setUserInfo:value.userInfo];
    //refine vc's frame
    CGRect frame = self.frame;
    frame.origin = CGPointZero;
    [self.viewController.view setFrame:frame];
    [self.viewController viewWillAppear:NO];
    [self.contentView addSubview:self.viewController.view];
    [self.viewController viewDidAppear:NO];
    
    TLOG(@"self.associatedViewController -> %@ self.viewController -> %@", self.associatedViewController, self.viewController);
    
    
    
}

#pragma mark - 

- (void)clearVC{
    if ([DSValueUtil isNotAvailable:self.viewController]) return;
    [self.viewController viewWillDisappear:YES];
    [self.viewController.view removeFromSuperview];
    [self.viewController viewDidDisappear:YES];
    self.viewController = nil;
}


#pragma mark -

- (void)setValue:(id)aValue{
    
    if (value){
        if ([value isEqual:aValue]) return;
    }
    
    value = (AGCollectionViewCellValue *)aValue;
    [self clearVC];
    [self assembleVC];
}

@end
