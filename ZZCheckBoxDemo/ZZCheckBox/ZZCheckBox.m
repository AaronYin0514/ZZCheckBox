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
#import "ZZMutableCheckBox.h"

@implementation ZZCheckBox

#pragma mark - Life Cycle
-(instancetype)initWithCheckBoxType:(CheckBoxType)type {
    if (type == CheckBoxTypeSingleCheckBox) {
        self = [[ZZSingleCheckBox alloc] init];
        return self;
    }
    if (type == CheckBoxTypeMutableCheckBox) {
        self = [[ZZMutableCheckBox alloc] init];
        return self;
    }
    _type = type;
    return nil;
}

-(void)dealloc {
    for (ZZCheckBoxButton *boxButton in _checkBoxButtonArray) {
        [boxButton removeObserver:self forKeyPath:@"selected"];
    }
}

#pragma mark - Set & Get
-(void)setDataSource:(id<ZZCheckBoxDataSource>)dataSource {
    if (!dataSource || _dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    NSAssert([_dataSource respondsToSelector:@selector(numberOfRowsInCheckBox:)], @"必须实现numberOfRowsInCheckBox:方法");
    NSInteger count = [_dataSource numberOfRowsInCheckBox:self];
    
    NSUInteger defaultSelectedIndex = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(defaultSelectedIndexInCheckBox:)]) {
        defaultSelectedIndex = [_delegate defaultSelectedIndexInCheckBox:self];
    }
    
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:count];
    NSAssert([_dataSource respondsToSelector:@selector(checkBox:frameAtIndex:)], @"必须实现checkBox:frameAtIndex:方法");
    NSAssert([_dataSource respondsToSelector:@selector(checkBox:supperViewAtIndex:)], @"必须实现checkBoxSupperView方法");
    for (NSInteger i = 0; i < count; i++) {
        CGRect frame = [_dataSource checkBox:self frameAtIndex:i];
        ZZCheckBoxButton *button = [[ZZCheckBoxButton alloc] initWithFrame:frame atIndex:i];
        [self addCheckBoxButton:button selectedStatus:(i == defaultSelectedIndex)];
        [tempMutableArray addObject:button];
        UIView *superView = [_dataSource checkBox:self supperViewAtIndex:i];
        [superView addSubview:button];
    }
    _checkBoxButtonArray = [NSArray arrayWithArray:tempMutableArray];
}

#pragma mark - 私有方法
/**
 *  向box中添加button
 *
 *  @param button 添加的button
 */
-(void)addCheckBoxButton:(ZZCheckBoxButton *)button selectedStatus:(BOOL)selected {
    button.selected = selected;
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

#pragma mark - Actions
-(void)buttonDidTouchUpInside:(ZZCheckBoxButton *)button {
    if ([self isKindOfClass:[ZZSingleCheckBox class]] && button.selected) {
        return;
    }
    if (!button.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(checkBox:willSelectedAtIndex:)]) {
            if ([_delegate checkBox:self willSelectedAtIndex:button.tag]) {
                button.selected = !button.selected;
            }
        } else {
            button.selected = !button.selected;
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(checkBox:willDeselectedAtIndex:)]) {
            if ([_delegate checkBox:self willDeselectedAtIndex:button.tag]) {
                button.selected = !button.selected;
            }
        } else {
            button.selected = !button.selected;
        }
    }
}

@end
