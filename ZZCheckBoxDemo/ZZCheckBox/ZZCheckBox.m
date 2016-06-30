//
//  ZZCheckBox.m
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ZZCheckBox.h"
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

//-(instancetype)init {
//    return [self initWithCheckBoxType:CheckBoxTypeSingleCheckBox];
//}

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
    NSAssert(!_storyboardDataSource, @"此代理不能与storyboardDataSource一起设置");
    NSAssert([_dataSource respondsToSelector:@selector(numberOfRowsInCheckBox:)], @"必须实现numberOfRowsInCheckBox:方法");
    NSInteger count = [_dataSource numberOfRowsInCheckBox:self];
    
    NSUInteger defaultSelectedIndex = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(defaultSelectedIndexInCheckBox:)]) {
        defaultSelectedIndex = [_delegate defaultSelectedIndexInCheckBox:self];
    }
    
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:count];
    NSAssert([_dataSource respondsToSelector:@selector(checkBox:supperViewAtIndex:)], @"必须实现checkBoxSupperView方法");
    for (NSInteger i = 0; i < count; i++) {
        CGRect frame = CGRectZero;
        if ([_dataSource respondsToSelector:@selector(checkBox:frameAtIndex:)]) {
            frame = [_dataSource checkBox:self frameAtIndex:i];
        }
        ZZCheckBoxButton *button = [[ZZCheckBoxButton alloc] initWithFrame:frame atIndex:i];
        if ([_dataSource respondsToSelector:@selector(checkBox:titleForCheckBoxAtIndex:)]) {
            NSString *titleString = [_dataSource checkBox:self titleForCheckBoxAtIndex:i];
            if (titleString.length) {
                [button setTitle:titleString forState:UIControlStateNormal];
                [button setTitle:titleString forState:UIControlStateSelected];
                [button setTitle:titleString forState:UIControlStateHighlighted];
            }
        }
        if ([_dataSource respondsToSelector:@selector(checkBox:titleColorForCheckBoxAtIndex:)]) {
            UIColor *titleColor = [_dataSource checkBox:self titleColorForCheckBoxAtIndex:i];
            if (titleColor) {
                [button setTitleColor:titleColor forState:UIControlStateNormal];
                [button setTitleColor:titleColor forState:UIControlStateSelected];
                [button setTitleColor:titleColor forState:UIControlStateHighlighted];
            }
        }
        if ([_dataSource respondsToSelector:@selector(checkBox:titleFontForCheckBoxAtIndex:)]) {
            UIFont *font = [_dataSource checkBox:self titleFontForCheckBoxAtIndex:i];
            if (font) {
                button.titleLabel.font = font;
            }
        }
        [self addCheckBoxButton:button selectedStatus:(i == defaultSelectedIndex)];
        [tempMutableArray addObject:button];
        UIView *superView = [_dataSource checkBox:self supperViewAtIndex:i];
        [superView addSubview:button];
    }
    _checkBoxButtonArray = [NSArray arrayWithArray:tempMutableArray];
}

-(void)setStoryboardDataSource:(id<ZZCheckBoxStoryboardDataSource>)storyboardDataSource {
    if (!storyboardDataSource || _storyboardDataSource == storyboardDataSource) {
        return;
    }
    _storyboardDataSource = storyboardDataSource;
    NSAssert(!_dataSource, @"此代理不能与dataSource一起设置");
    NSAssert([_storyboardDataSource respondsToSelector:@selector(numberOfStoryboardRowsInCheckBox:)], @"必须实现numberOfStoryboardRowsInCheckBox:方法");
    NSInteger count = [_storyboardDataSource numberOfStoryboardRowsInCheckBox:self];
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:count];
    if ([self isKindOfClass:[ZZSingleCheckBox class]]) {
        BOOL hasOneSetSelected = NO;
        for (NSInteger i = 0; i < count; i++) {
            NSAssert([_storyboardDataSource respondsToSelector:@selector(checkBox:buttonAtIndex:)], @"必须实现checkBox:buttonAtIndex:方法");
            ZZCheckBoxButton *button = [_storyboardDataSource checkBox:self buttonAtIndex:i];
            button.tag = i;
            if (hasOneSetSelected) {
                button.selected = NO;
            } else {
                hasOneSetSelected = button.selected;
            }
        }
        if (!hasOneSetSelected) {
            ZZCheckBoxButton *button = [_storyboardDataSource checkBox:self buttonAtIndex:0];
            button.selected = YES;
        }
    }
    
    for (NSInteger i = 0; i < count; i++) {
        NSAssert([_storyboardDataSource respondsToSelector:@selector(checkBox:buttonAtIndex:)], @"必须实现checkBox:buttonAtIndex:方法");
        ZZCheckBoxButton *button = [_storyboardDataSource checkBox:self buttonAtIndex:i];
        if (button) {
            [self addCheckBoxButton:button selectedStatus:button.selected];
            [tempMutableArray addObject:button];
        }
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
    [button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    button.selected = selected;
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
