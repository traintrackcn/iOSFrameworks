//
//  AGSearchCell.m
//  AboveGEM
//
//  Created by traintrackcn on 28/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGSearchCell.h"
#import "DSAlertUtil.h"


@interface AGSearchCell(){
    
}

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation AGSearchCell

+ (CGFloat)height{
    return 40;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.searchBar];
    }
    return self;
}

#pragma mark - assemblers


- (UISearchBar *)searchBar{
    if (!_searchBar){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, [self.class height])];
        [_searchBar setPlaceholder:@"Name or Description"];
        //  [searchBar setShowsCancelButton:YES];
        [_searchBar setDelegate:self];
        
        //    [searchBar setTintColor:[UIColor redColor]];
        
        //
        //    [searchBar setSearchFieldBackgroundImage:[DSImage rectangleWithSize:CGSizeMake(1,[self.class height]-12) fillColor:[AGStyleCoordinator colorForKey:@"search-bar-input-field-background"]] forState:UIControlStateNormal];
        
        
        //    [searchBar setTintColor:[AGStyleCoordinator colorForKey:@"search-bar-button-title"]];
        //    [searchBar setTintColor:[UIColor redColor]];
        //    [searchBar setShowsScopeBar:YES];
        //    [searchBar setScopeButtonTitles:@[@"title1", @"title2", @"title3"]];
        //    [searchBar setBackgroundImage:[DSImage rectangleWithSize:CGSizeMake(10, 10) fillColor:[UIColor redColor]]];
        //    [searchBar setScopeBarButtonBackgroundImage:[DSImage rectangleWithSize:CGSizeMake(10, 10) fillColor:[UIColor redColor]] forState:UIControlStateNormal];
        
        //    UIView *v = [self headerAtSection:SectionProduct];
        //    TLOG(@"v -> %@", v);
        //    [v addSubview:searchBar];
    }
    return _searchBar;
}

#pragma mark - layout ops

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutSearchBar];
}

- (void)layoutSearchBar{
    CGFloat w = self.searchBar.frame.size.width;
    CGFloat h = self.searchBar.frame.size.height;
    [self.searchBar setBackgroundImage:[DSImage rectangleWithSize:CGSizeMake(w, h) fillColor:RGBA(245, 245, 245, 1)]];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    TLOG(@"");
    [searchBar setShowsCancelButton:YES animated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    keyword = searchText;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    TLOG(@"");
    
    
//    NSString *myText = @"       foo    ";
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSLog(@"old = [%@], trimmed = [%@]", myText, trimmedText);
    TLOG(@"keyword -> %@", keyword);
    
    
    if (keyword.length <3) {
        [DSAlertUtil showSVPErrorForCustomText:@"keyword is too short"];
        return;
    }
    
    if (keyword.length > 50) {
        [DSAlertUtil showSVPErrorForCustomText:@"keyword is too long"];
        return;
    }
    
    [self endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:NO];
    [searchBar setText:@""];
    
    [self willBeginSearch];
}

#pragma mark - 

- (void)willBeginSearch{
    
}

@end
