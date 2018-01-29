//
//  AGCircleProgressView.m
//  AboveGEM
//
//  Created by traintrackcn on 28/12/14.
//
//

@import LITCommon;
@import LITUICommon;
@import MDRadialProgress;

#import "AGCircleProgressView.h"

@interface AGCircleProgressView(){
    MDRadialProgressView *outerView;
    MDRadialProgressView *innerView;
    UILabel *textLabel;
    UILabel *statusLabel;
    CGFloat targetProgress;
}

//@property (nonatomic, assign) CGFloat accurateProgress;

@end

@implementation AGCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTextLabelH:30];
        [self setStatusLabelH:15];
        [self setOuterThickness:70/2];
        [self setInnerThickness:20/2];
        
        [self setInnerCompletedColor:RGBA(112, 21, 29, 1)];
        [self setInnerIncompletedColor:RGBA(229, 171, 51, 1)];
//        [self assemble];
        
        [self setOuterCompletedColor:RGBA(144, 38, 45, 1)];
        [self setOuterIncompletedColor:RGBA(243, 200, 96, 1)];
        
        [self setTextFont:[UIFont boldSystemFontOfSize:36]];
        [self setTextColor:RGBA(117, 13, 35, 1)];
        
        [self setStatus:@"Achieved"];
    }
    return self;
}


#pragma mark - assemblers

- (void)assemble{
    [self assembleOuterView];
    [self assembleInnerView];
    [self assembleTextLabel];
    [self assembleStatusLabel];
}

- (void)assembleOuterView{
    CGRect frame = CGRectMake(0,0,self.frame.size.width, self.frame.size.height);
    outerView = [[MDRadialProgressView alloc] initWithFrame:frame andTheme:self.outerTheme];
    [self addSubview:outerView];
    outerView.progressTotal = 100;
    outerView.progressCounter = 0;
//    [AGDebugUtil makeBorderForView:outerView];
    
//    [outerView setHidden:YES];
}

- (void)assembleInnerView{
    CGFloat x = self.outerThickness - self.innerThickness;
    CGFloat y = x;
    CGFloat w = outerView.frame.size.width - x*2;
    CGFloat h = w;
    innerView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(x, y, w, h) andTheme:self.innerTheme];
    innerView.progressTotal = 100;
    innerView.progressCounter = 0;
    [innerView.label setHidden:YES];
    [self addSubview:innerView];
    
//    [AGDebugUtil makeBorderForView:innerView];
    
//    [innerView setHidden:YES];
}

- (void)assembleTextLabel{
    CGFloat x = self.innerThickness/2.0;
    CGFloat w = innerView.frame.size.width - x*2;
//    CGFloat h = 30;
    CGFloat y = (innerView.frame.size.height - self.textLabelH)/2.0;
    
    
    if ([self isStatusAvailable]) {
        y = (innerView.frame.size.height - self.textLabelH - self.statusLabelH)/2.0;
    }
    
    
    textLabel= [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, self.textLabelH)];
    [innerView addSubview:textLabel];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setTextColor:self.textColor];
    [textLabel setFont:self.textFont];
    [textLabel setNumberOfLines:0];
//    [textLabel setAdjustsFontSizeToFitWidth:YES];
    [textLabel setText:@"0%"];
    
//    [AGDebugUtil makeBorderForView:textLabel];
}

- (void)assembleStatusLabel{
    CGFloat x = self.innerThickness/2.0;
    CGFloat w = innerView.frame.size.width - x*2;
//    CGFloat h = 15;
    CGFloat y = textLabel.frame.origin.y + textLabel.frame.size.height;
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, self.statusLabelH)];
    [innerView addSubview:statusLabel];
    [statusLabel setTextAlignment:NSTextAlignmentCenter];
    [statusLabel setFont:[UIFont systemFontOfSize:11]];
    [statusLabel setText:[self.status uppercaseString]];
    [statusLabel setAdjustsFontSizeToFitWidth:YES];
//    [AGDebugUtil makeBorderForView:statusLabel];
}

#pragma mark - properties

- (BOOL)isStatusAvailable{
    if (!self.status) return NO;
    if ([self.status isEqualToString:@""]) return NO;
    return YES;
}

- (MDRadialProgressTheme *)outerTheme{
    MDRadialProgressTheme *t = [[MDRadialProgressTheme alloc] init];
    t.completedColor = self.outerCompletedColor;
    t.incompletedColor = self.outerIncompletedColor;
    //	newTheme.centerColor = [UIColor whiteColor];
    t.centerColor = [UIColor whiteColor];
    t.sliceDividerHidden = YES;
    t.labelColor = [UIColor blackColor];
    t.labelShadowColor = [UIColor whiteColor];
    [t setDrawIncompleteArcIfNoProgress:YES];
    [t setThickness:self.outerThickness*2];
//    [t setThickness:10];
    return t;
}

- (MDRadialProgressTheme *)innerTheme{
    MDRadialProgressTheme *t = [[MDRadialProgressTheme alloc] init];
    t.completedColor = self.innerCompletedColor;
    t.incompletedColor = self.innerIncompletedColor;
    //	newTheme.centerColor = [UIColor whiteColor];
//    t.centerColor = RGBA(253, 245, 226, 1);
    [t setDrawIncompleteArcIfNoProgress:YES];
    t.centerColor = [UIColor whiteColor];
    t.sliceDividerHidden = YES;
    t.labelColor = [UIColor blackColor];
    t.labelShadowColor = [UIColor whiteColor];
    [t setThickness:self.innerThickness*2];
//    [t setThickness:10];
    return t;
}

- (CGFloat)progress{
    return outerView.progressCounter;
}



#pragma mark -

//- (NSString *)textAccuratePercent{
//    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//    //    [f setPositiveFormat:@"0.##"];
//    [f setNumberStyle:NSNumberFormatterPercentStyle];
//    [f setMaximumFractionDigits:1];
//    NSString *result = [f stringFromNumber:[NSNumber numberWithFloat:self.accurateProgress/100.0]];
//    if (!result) result = @"0%";
//    return result;
//}

- (void)updateTextLabel{
    [textLabel setText:[NSString stringWithFormat:@"%.0f%%", self.progress]];
}

//- (void)updateTextLabelForAccuratePercent{
//    [textLabel setText:self.textAccuratePercent];
//}

- (void)setImmediatelyProgress:(CGFloat)progress{
//    [self setAccurateProgress:progress];
    [outerView setProgressCounter:roundf(progress)];
    [innerView setProgressCounter:roundf(progress)];
    [self updateTextLabel];
}

- (void)setProgress:(CGFloat)progress{
    targetProgress = round(progress);
    
    TLOG(@"targetProgress -> %f %f", targetProgress, self.progress);

    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    if (targetProgress > self.progress) {
        [self animatePlusProgress];
    }else{
        [self animateMinusProgress];
    }
}

- (void)plusOne{
    [outerView setProgressCounter:outerView.progressCounter+1];
    [innerView setProgressCounter:innerView.progressCounter + 1];
    [self updateTextLabel];
}

- (void)minusOne{
    [outerView setProgressCounter:outerView.progressCounter-1];
    [innerView setProgressCounter:innerView.progressCounter-1];
    [self updateTextLabel];
}


#pragma mark - animation

- (void)animatePlusProgress{
    if ( self.progress + 1 > targetProgress) {
//        [self dispatchProgressAnimationDidComplete];
        return;
    }
    
    [self plusOne];
    [self performSelector:@selector(animatePlusProgress) withObject:nil afterDelay:0.02];
}

- (void)animateMinusProgress{
    if (self.progress -1 < targetProgress) {
//        [self dispatchProgressAnimationDidComplete];
        return;
    }
    
    [self minusOne];
    [self performSelector:@selector(animateMinusProgress) withObject:nil afterDelay:0.02];
}



@end
