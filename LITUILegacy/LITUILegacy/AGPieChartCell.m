//
//  AGPieChartCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 6/4/15.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGPieChartCell.h"


@interface AGPieChartCell()<XYPieChartDelegate, XYPieChartDataSource>{

}

@property (strong, nonatomic) XYPieChart *pieChart;
@property (nonatomic, strong) NSArray *percentages;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation AGPieChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self assemble];
    }
    return self;
}

- (void)assemble{
    [self.contentView addSubview:self.pieChart];
}

#pragma mark - setter

- (void)setValue:(id)value{
    [super setValue:value];
    
    if (![value isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSArray *arr = (NSArray *)value;
    
    [self setColors:[arr objectAtIndex:0]];
    [self setPercentages:[arr objectAtIndex:1]];
    [self setTitles:[arr objectAtIndex:2]];
    
    [self.pieChart reloadData];
    
    [self setHeight:self.height];
}


#pragma mark - components

- (XYPieChart *)pieChart{
    if (!_pieChart) {
        CGFloat x = self.paddingLR;
        CGFloat w = self.height;
        CGFloat h = w;
        CGFloat y = 0;
        
        UIColor *bgColor = RGBA(233, 233, 233, 1);
        
        _pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_pieChart setDataSource:self];
        [_pieChart setStartPieAngle:M_PI_2*3];
        [_pieChart setAnimationSpeed:1.0];
        [_pieChart setLabelFont:[UIFont systemFontOfSize:14]];
        [_pieChart setLabelRadius:w/3];
        [_pieChart setShowPercentage:NO];
        [_pieChart setShowLabel:YES];
        [_pieChart setPieBackgroundColor:bgColor];
        [_pieChart setPieCenter:CGPointMake(w/2, h/2)];
        [_pieChart setUserInteractionEnabled:NO];
        //        [_pieChart setLabelShadowColor:[UIColor blackColor]];
//        [AGDebugUtil makeBorderForView:_pieChart];
        
        UIImage *circleBg = [DSImage circleWithSize:_pieChart.frame.size fillColor:bgColor];
        UIImageView *circleBgView = [[UIImageView alloc] initWithImage:circleBg];
        [_pieChart addSubview:circleBgView];
        [_pieChart sendSubviewToBack:circleBgView];
    }
    return _pieChart;
}


#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.percentages.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.percentages objectAtIndex:index] floatValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    //    if(pieChart == self.pieChartRight) return nil;
    return [self.colors objectAtIndex:index];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index{
    return [self.titles objectAtIndex:index];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index{
    //    NSLog(@"will select slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index{
    //    NSLog(@"will deselect slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index{
    //    NSLog(@"did deselect slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index{
    //    NSLog(@"did select slice at index %d",index);
    //    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}

#pragma mark - styles

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (CGFloat)height{
    return [DSDeviceUtil bounds].size.width - self.paddingLR*2;
}

- (CGFloat)paddingLR{
    return 18.0;
}

- (NSArray *)colors{
    if (!_colors) {
        _colors = @[
                         RGBA(238, 195, 78, 1),
                         RGBA(54, 154, 236, 1),
                         RGBA(68, 175, 88, 1)
                         
                         ];
    }
    return _colors;
}

- (NSArray *)percentages{
    if (!_percentages) {
        _percentages = @[
                    [NSNumber numberWithFloat:60],
                    [NSNumber numberWithFloat:17],
                    [NSNumber numberWithFloat:23]
                    
                    ];
    }
    return _percentages;
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[
                    @"a", @"b", @"c", @"other"
                    ];
        
    }
    return _titles;
}

@end
