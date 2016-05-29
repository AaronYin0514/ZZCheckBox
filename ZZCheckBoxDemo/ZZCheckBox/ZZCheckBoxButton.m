//
//  ZZCheckBoxButton.m
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
//

#import "ZZCheckBoxButton.h"

@implementation ZZCheckBoxButton

-(instancetype)initWithFrame:(CGRect)frame atIndex:(NSInteger)index {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
        _index = index;
        [self setImage:[UIImage imageNamed:@"but_select_nor"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"but_select_press"] forState:UIControlStateSelected];
    }
    return self;
}

@end
