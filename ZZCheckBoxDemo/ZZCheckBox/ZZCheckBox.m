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

+(ZZCheckBox *)checkBoxWithCheckBoxType:(CheckBoxType)type {
    ZZCheckBox *checkBox = nil;
    switch (type) {
        case CheckBoxTypeSingleCheckBox: {
            checkBox = [[ZZSingleCheckBox alloc] init];
            break;
        }
        case CheckBoxTypeMutableCheckBox: {
            checkBox = [[ZZMutableCheckBox alloc] init];
            break;
        }
        default:
            break;
    }
    return checkBox;
}

-(instancetype)init {
    if (![self isKindOfClass:[ZZSingleCheckBox class]] && ![self isKindOfClass:[ZZMutableCheckBox class]]) {
        return nil;
    }
    if (self = [super init]) {
        
    }
    return self;
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
        if ([_delegate respondsToSelector:@selector(checkBox:imageForCheckBoxAtIndex:forState:)]) {
            UIImage *image = [_dataSource checkBox:self imageForCheckBoxAtIndex:i forState:UIControlStateNormal];
            if (image) {
                [button setImage:image forState:UIControlStateNormal];
                [button setImage:image forState:UIControlStateHighlighted];
            }
            UIImage *selectedImage = [_dataSource checkBox:self imageForCheckBoxAtIndex:i forState:UIControlStateSelected];
            if (selectedImage) {
                [button setImage:selectedImage forState:UIControlStateSelected];
            }
        }
        if ([_delegate respondsToSelector:@selector(checkBox:backgroundImageForCheckBoxAtIndex:forState:)]) {
            UIImage *image = [_dataSource checkBox:self backgroundImageForCheckBoxAtIndex:i forState:UIControlStateNormal];
            if (image) {
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [button setBackgroundImage:image forState:UIControlStateHighlighted];
            }
            UIImage *selectedImage = [_dataSource checkBox:self backgroundImageForCheckBoxAtIndex:i forState:UIControlStateSelected];
            if (selectedImage) {
                [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
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

-(BOOL)selectItemAtIndex:(NSInteger)index {
    if (index >= _checkBoxButtonArray.count) {
        return NO;
    }
    ZZCheckBoxButton *button = _checkBoxButtonArray[index];
    if (button.selected) {
        return NO;
    }
    [self buttonDidTouchUpInside:button];
    return YES;
}

-(BOOL)deselectItemAtIndex:(NSInteger)index {
    if (index >= _checkBoxButtonArray.count) {
        return NO;
    }
    ZZCheckBoxButton *button = _checkBoxButtonArray[index];
    if (!button.selected) {
        return NO;
    }
    [self buttonDidTouchUpInside:button];
    return YES;
}

-(void)selectItemWithIndexArray:(NSArray<NSNumber *> *)items {
    for (NSNumber *indexNumber in items) {
        NSInteger index = [indexNumber integerValue];
        [self selectItemAtIndex:index];
    }
}

-(void)deselectItemWithIndexArray:(NSArray<NSNumber *> *)items {
    for (NSNumber *indexNumber in items) {
        NSInteger index = [indexNumber integerValue];
        [self deselectItemAtIndex:index];
    }
}

-(void)clear {
    for (NSInteger index = 0; index < _checkBoxButtonArray.count; index++) {
        [self deselectItemAtIndex:index];
    }
}

#pragma mark - Actions
-(void)buttonDidTouchUpInside:(ZZCheckBoxButton *)button {
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
