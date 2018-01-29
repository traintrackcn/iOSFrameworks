//
//  AGQuantityPicker.m
//  AboveGEM
//
//  Created by traintrackcn on 18/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGQuantitySelector.h"
#import "AGQuantityPickerView.h"
//#import "CODialog.h"


@interface AGQuantitySelector (){
//    CODialog *diag;
//    AGQuantityPickerView *picker;
}
@end

//static AGQuantitySelector *___instanceAGQuantityPicker;

@implementation AGQuantitySelector

//}

- (id)init{
    self = [super init];
    if (self) {
        [self addButtonWithTitle:@"Cancel" target:self selector:@selector(didTapCancel:)];
//        [self addButtonWithTitle:@"Remove" target:self selector:@selector(didTapRemove:)];
        [self addButtonWithTitle:@"Confirm" target:self selector:@selector(didTapConfirm:)];
    }
    return self;
}


#pragma mark - content views

- (UIView *)contentViewWithValue:(NSInteger)value minValue:(NSInteger)minValue{
    return [AGQuantityPickerView instanceWithValue:value minValue:minValue];
}

- (UIView *)contentViewWithValue:(NSInteger)value maxValue:(NSInteger)maxValue{
   return [AGQuantityPickerView instanceWithValue:value maxValue:maxValue];
}



#pragma mark - tap actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapRemove:(id)sender{
    [self setValueForAssociatedIndexPath:[NSNumber numberWithInteger:0]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapConfirm:(id)sender{
    AGQuantityPickerView *view  = (AGQuantityPickerView *)self.contentView;    
    [self setValueForAssociatedIndexPath:[NSNumber numberWithInteger:view.value]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
