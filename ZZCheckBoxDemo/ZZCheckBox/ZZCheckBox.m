//
//  ZZCheckBox.m
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
//

#import "ZZCheckBox.h"
#import "ZZCheckBoxButton.h"
#import "ZZSingleCheckBox.h"

@implementation ZZCheckBox

-(instancetype)init {
//    return [self initWithDataSource:nil andDelegate:nil];
    if (self = [super init]) {
        _checkBoxButtonArray = [NSMutableArray array];
    }
    return self;
}

//-(instancetype)initWithDataSource:(id)dataSource andDelegate:(id)delegate {
//    if (self = [super init]) {
//        _checkBoxButtonArray = [NSMutableArray array];
//        _delegate = delegate;
//        _dataSource = dataSource;
//        if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowsInCheckBox:)]) {
//            NSInteger number = [_dataSource numberOfRowsInCheckBox:self];
//            
//        }
//    }
//    return self;
//}

#pragma mark - Founction
-(void)addCheckBoxButton:(ZZCheckBoxButton *)button {
    NSLog(@"%s", __func__);
    [_checkBoxButtonArray addObject:button];
    [button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(BOOL)judgeCheckBoxButtonAllreadyInBox:(ZZCheckBoxButton *)button {
    BOOL __block isAllreadyIn;
    [_checkBoxButtonArray enumerateObjectsUsingBlock:^(ZZCheckBoxButton *boxButton, NSUInteger idx, BOOL * _Nonnull stop) {
        if (button == boxButton) {
            isAllreadyIn = YES;
        }
    }];
    return isAllreadyIn;
}

#pragma mark - 私有方法
//-(void)createCheckBoxButton:(NSInteger)number{
//    for (NSInteger i = 0; i < number; i++) {
//        ZZCheckBoxButton *button = [[ZZCheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30) atIndex:0];
//        
//    }
//}

#pragma mark - Actions
-(void)buttonDidTouchUpInside:(ZZCheckBoxButton *)button {
    if ([self isKindOfClass:[ZZSingleCheckBox class]] && button.selected) {
        return;
    }
    button.selected = !button.selected;
}

-(void)dealloc {
    for (ZZCheckBoxButton *boxButton in _checkBoxButtonArray) {
        [boxButton removeObserver:self forKeyPath:@"selected"];
    }
}

@end
