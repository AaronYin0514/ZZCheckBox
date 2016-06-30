//
//  ZZCheckBoxButton.m
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ZZCheckBoxButton.h"
#import "ZZCheckBoxHeader.h"

@implementation ZZCheckBoxButton

-(instancetype)initWithFrame:(CGRect)frame atIndex:(NSInteger)index {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.tag = index;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self setImage:[UIImage imageNamed:ButtonImageNameNormal] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:ButtonImageNamePress] forState:UIControlStateSelected];
    }
    return self;
}

@end
