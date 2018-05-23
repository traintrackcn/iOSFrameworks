//
//  LITCollectionViewCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 17/09/2017.
//
//

#import "LITCollectionCell.h"
#import "LITVC.h"

@implementation LITCollectionCell



- (void)_setTitle:(id)title{
    _title = title;
}

- (void)_setValue:(id)value{
    _value = value;
}

#pragma mark - 

- (UITapGestureRecognizer *)tapGestureRecognizer{
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAny:)];
    }
    return _tapGestureRecognizer;
}

#pragma mark -

- (void)didTapAny:(id)sender{
    
}

#pragma mark - properties

- (UITableView *)tableView{
    return [self.associatedViewController tableView];
}

//- (BOOL)tableViewScrolledToBottom{
//    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.frame.size.height)) {
//        // Start the animation
//        return YES;
//    }
//    return NO;
//}

- (void)sendActionRequestToViewController:(id)action{
    [(LITVC *)self.associatedVC action:action atIndexPath:self.associatedIndexPath];
}

@end
