//
//  AGSingleTextfieldEditor.m
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextfieldEditor.h"
#import "AGButtonCell.h"
#import "AGTextfieldCellStyleNoTitle.h"
#import "AGButtonItem.h"
#import "AGVCConfiguration.h"

enum{
//    SectionHeader,
    SectionTextfield,
    SectionButton,
    SectionCount
};

enum{
    SectionTextfieldCell,
    SectionTextfieldCellCount
};

enum{
    SectionHeaderCell,
    SectionHeaderCellCount
};

@interface AGTextfieldEditor ()

@end

@implementation AGTextfieldEditor

- (id)init{
    self = [super init];
    if (self) {
        [self.config setCellCls:[AGTextfieldCellStyleNoTitle class] inSection:SectionTextfield];
        [self.config setCellCls:[AGButtonCell class] inSection:SectionButton];
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self performSelector:@selector(focusTextfield) withObject:nil afterDelay:.5];
}

- (void)focusTextfield{
    AGTextfieldCellStyleNoTitle *tfCell = (AGTextfieldCellStyleNoTitle *)[self cellAtIndexPath:[NSIndexPath indexPathForRow:SectionTextfieldCell inSection:SectionTextfield]];
    UITextField *input = tfCell.inputField;
    [input becomeFirstResponder];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}

#pragma mark - remote actions

- (BOOL)validate{
    return YES;
}

#pragma mark - getter setter

- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    id value;
    
//    if (section == SectionHeader) {
//        value = self.title;
//    }
    
    if (section == SectionTextfield) {
        value = self.value;
    }
    
    if (section == SectionButton) {
        value = @[
//                  [AGButtonItem instanceWithTitle:@"Cancel" target:self action:@selector(didTapCancel:)],
                  [AGButtonItem instanceWithTitle:@"Confirm" target:self action:@selector(didTapConfirm:)]
                  ];
    }
    
    return value;
}

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;

    if (section == SectionTextfield) {
        self.value = value;
    }
    
}

#pragma mark - data source

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
//    if (section == SectionHeader) return SectionHeaderCellCount;
    if (section == SectionTextfield) return SectionTextfieldCellCount;
    if (section == SectionButton) return 1;
    return 0;
}

- (NSInteger)numberOfSections{
    return SectionCount;
}

#pragma mark - timing ops


#pragma mark - interactive actions

- (void)didTapConfirm:(id)sender{
    [self.view endEditing:YES];
    if([self validate]){
        [self doConfirm];
    }
}

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 

- (void)doConfirm{
    [self.navigationController popViewControllerAnimated:YES];
    [self setValueForAssociatedIndexPath:self.value];
}

@end
