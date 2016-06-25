//
//  ZZSingleCheckBox.m
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
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
            [self changeCheckButtonSelectedStatusWithNowIndex:button.tag];
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
            }
        }];
    }
}

@end
