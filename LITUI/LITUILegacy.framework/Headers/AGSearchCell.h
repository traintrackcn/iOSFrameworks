//
//  AGSearchCell.h
//  AboveGEM
//
//  Created by traintrackcn on 28/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"

@interface AGSearchCell : AGCell <UISearchBarDelegate>{
    NSString *keyword;
}

- (UISearchBar *)searchBar;


- (void)willBeginSearch;

@end
