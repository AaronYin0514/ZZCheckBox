//
//  ZZSingleCheckBox.m
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ZZSingleCheckBox.h"
#import "ZZCheckBoxButton.h"

@implementation ZZSingleCheckBox

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    ZZCheckBoxButton *button = object;
    if (button.selected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(checkBox: didSelectedAtIndex:)]) {
            [self.delegate checkBox:self didSelectedAtIndex:button.tag];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(checkBox: didDeselectedAtIndex:)]) {
            [self.delegate checkBox:self didDeselectedAtIndex:button.tag];
        }
    }
}

#pragma mark - 自定义
-(void)changeCheckButtonSelectedStatusWithNowIndex:(NSInteger)index {
    if (self.checkBoxButtonArray) {
        [self.checkBoxButtonArray enumerateObjectsUsingBlock:^(ZZCheckBoxButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            if (index != idx && button.selected) {
                button.selected = NO;
                *stop = YES;
            }
        }];
    }
}

#pragma mark - Actions
-(void)buttonDidTouchUpInside:(ZZCheckBoxButton *)button {
    if (button.selected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(canCancleCheckSingleCheckBox:)]) {
            if (![self.delegate canCancleCheckSingleCheckBox:self]) {
                return;
            }
        } else {
            return;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkBox:willSelectedAtIndex:)]) {
        if ([self.delegate checkBox:self willSelectedAtIndex:button.tag]) {
            [self changeCheckButtonSelectedStatusWithNowIndex:button.tag];
            button.selected = !button.selected;
        }
    } else {
        [self changeCheckButtonSelectedStatusWithNowIndex:button.tag];
        button.selected = !button.selected;
    }
}

@end
