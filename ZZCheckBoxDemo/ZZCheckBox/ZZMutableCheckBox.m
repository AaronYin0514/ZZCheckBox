//
//  ZZMutableCheckBox.m
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ZZMutableCheckBox.h"
#import "ZZCheckBoxButton.h"
@implementation ZZMutableCheckBox

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

@end
