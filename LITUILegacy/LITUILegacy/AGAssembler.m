//
//  AGAssembler.m
//  AboveGEM
//
//  Created by traintrackcn on 11/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGAssembler.h"
#import "AGQuantitySelector.h"
#import "AGButton.h"

//#import "DSValueUtil.h"

@implementation AGAssembler


+ (UITableView *)assembleTableViewStyleDefaultWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate paddingTop:(CGFloat)paddingTop paddingBottom:(CGFloat)paddingBottom{
    UITableView *v = [[UITableView alloc] initWithFrame:CGRectZero];
    [v setDelegate:delegate];
    [v setDataSource:delegate];
    
    //assemble header
    UIView *tvHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,paddingTop)];
    [v setTableHeaderView:tvHeader];
    
    //assemble footer
    UIView *tvFooter = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,paddingBottom)];
    [v setTableFooterView:tvFooter];
    
    
    return v;
}

+ (UITableView *)assembleTableViewStyleDefaultForViewController:(UIViewController<UITableViewDelegate, UITableViewDataSource> *)vc paddingTop:(CGFloat)paddingTop paddingBottom:(CGFloat)paddingBottom{
    UITableView *v = [[UITableView alloc] initWithFrame:CGRectZero];
    [v setDelegate:vc];
    [v setDataSource:vc];
    
    [vc setView:v];
    
    //assemble header
    UIView *tvHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,paddingTop)];
    [v setTableHeaderView:tvHeader];
    
    //assemble footer
    UIView *tvFooter = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,paddingBottom)];
    [v setTableFooterView:tvFooter];
    
    
    return v;
}


+ (UILabel *)assembleLabelForPickerView{
    UILabel *l = [[UILabel alloc] init];
    [l setFrame:CGRectMake(0, 0, 100, 40)];
    [l setFont:FONT_WITH_SIZE(16)];
    [l setTextAlignment:NSTextAlignmentCenter];
//    [l setTextColor:[UIColor lightGrayColor]];
//    [AGDebugUtil makeBorderForView:l];
    return l;
}

#pragma mark - buttons

+ (UIButton *)assembleButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    AGButton *btn = [[AGButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}





@end
