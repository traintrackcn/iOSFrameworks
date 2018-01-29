//
//  AGManyItemsViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 29/10/14.
//
//

@import LITCommon;
@import LITNetwork;

#import "AGManyCellsViewController.h"
#import "AGMeta.h"
#import "AGLoadingTipCell.h"
#import "AGVCConfiguration.h"

@interface AGManyCellsViewController ()

@property (nonatomic, strong) AGRemoteUnit *rUnitForData;

@end

@implementation AGManyCellsViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        items = [NSMutableArray array];
        meta = [AGMeta instance];
        NSInteger limit = ceil([DSDeviceUtil bounds].size.height/[self heightOfItemCell]);
        [meta setLimit:limit];
        
        
        [self.config setCellCls:[AGLoadingTipCell class] inSection:self.SectionItemExtra];
    }
    return self;
}


#pragma mark - events

- (void)didLoadData:(id)data{
    //
}


#pragma mark - remote actions

- (void)requestItems{
    
    if ([self rUnitIsNotReady]) return;
    
    if (isLoadingMoreItems) return;
    
//    __weak AGManyCellsViewController *ws = self;
    [self.rUnitForData requestWithCompletion:^(id data, id error) {
        [self.ws requestItemsCallback:data error:error];
    }];
}

- (void)requestItemsCallback:(id)responseData error:(id)error{
    isLoadingMoreItems = NO;
    
    if (error) {
        [self setMessagesForError:error];
        [meta previous];
        return;
    }
    
    //if response contains no meta, if response is array, re-assemble it
    if ([responseData isKindOfClass:[NSArray class]]) {
        NSArray *reponseArr = (NSArray *)responseData;
        responseData = @{
                         @"meta":@{
                                 @"offset":[NSNumber numberWithInteger:0],
                                 @"limit":[NSNumber numberWithInteger:reponseArr.count],
                                 @"count":[NSNumber numberWithInteger:reponseArr.count]
                                 },
                         @"data":responseData
                         };
    }
    
    @try {
        id metaRaw = [responseData objectForKey:@"meta"];
        meta = [[AGMeta alloc] initWithRaw:metaRaw];
    }@catch (NSException *exception) {
//        [AGMonitor logClientException:exception fnName:CURRENT_FUNCTION_NAME];
    }
    
    
    [self didLoadData:responseData];
}

- (NSArray *)itemsRawOfResponseData:(id)responseData{
    if ([DSValueUtil isAvailable:[responseData objectForKey:@"data"]]) {
        return [responseData objectForKey:@"data"];
    }
    return [responseData objectForKey:@"rows"];
}


#pragma mark - table setting

- (NSInteger)SectionItem{
    return 0;
}

- (NSInteger)SectionItemExtra{
    return 0;
}

- (BOOL)isSectionItem:(NSInteger)section{
    if (section == self.SectionItem) {
        return YES;
    }
    return NO;
}

- (BOOL)isSectionItemExtra:(NSInteger)section{
    if (section == self.SectionItemExtra) {
        return YES;
    }
    return NO;
}

- (CGFloat )heightOfItemCell{
    return 44.0;
}


- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    id value;
    
    if (section == self.SectionItem) {
        value = [items objectAtIndex:idx];
    }
    
    if (section == self.SectionItemExtra) {
        value = [self valueOfSectionItemExtraAtIndex:idx];
    }
    
    return value;
}


- (id)valueOfSectionItemExtraAtIndex:(NSInteger)index{
    id value;
    if (![meta next]){
        value = @"All are loaded .";
    }else{
        value = @"Loading More ...";
//        [self requestItems];
    }
    return value;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if ([self isSectionItem:section]) return items?items.count:0;
    if ([self isSectionItemExtra:section]) return 1;
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"indexPath -> %@", indexPath);
    NSInteger section = indexPath.section;
    if (section == self.SectionItemExtra){
        if ([meta next]) {
            [self requestItems];
        }
    }
}

#pragma mark - paging ops

- (void)reset{
    TLOG(@"");
    [meta reset];
    items = [NSMutableArray array];
    [_rUnitForData cancel];
    isLoadingMoreItems = NO;
}

#pragma mark - assemblers

- (AGRemoteUnit *)assembleRUnitForData{
    return nil;
}

#pragma mark - properties

- (AGRemoteUnit *)rUnitForData{
    _rUnitForData = [self assembleRUnitForData];
    return _rUnitForData;
}

- (BOOL)rUnitIsNotReady{
    if (!self.rUnitForData) {
        return YES;
    }
    return NO;
}

@end
