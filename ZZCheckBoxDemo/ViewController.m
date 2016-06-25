//
//  ViewController.m
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
//

#import "ViewController.h"
#import "ZZCheckBox.h"

@interface ViewController ()<ZZCheckBoxDelegate, ZZCheckBoxDataSource> 
{
    ZZCheckBox *_singleCheckBox;
    ZZCheckBox *_mutableCheckBox;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _singleCheckBox = [[ZZCheckBox alloc] initWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _singleCheckBox.tag = 1;
    _singleCheckBox.delegate = self;
    _singleCheckBox.dataSource = self;
    
    _mutableCheckBox = [[ZZCheckBox alloc] initWithCheckBoxType:CheckBoxTypeMutableCheckBox];
    _mutableCheckBox.tag = 2;
    _mutableCheckBox.delegate = self;
    _mutableCheckBox.dataSource = self;
    
}

#pragma mark - ZZCheckBoxDataSource
-(NSInteger)numberOfRowsInCheckBox:(ZZCheckBox *)checkBox {
    return 2;
}

-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        return CGRectMake(100, 50 + 40 * index, 30, 30);
    } else {
        return CGRectMake(100, 250 + 40 * index, 30, 30);
    }
}

-(UIView *)checkBox:(ZZCheckBox *)checkBox supperViewAtIndex:(NSInteger)index {
    return self.view;
}

#pragma mark - ZZCheckBoxDelegate
-(NSUInteger)defaultSelectedIndexInCheckBox:(ZZCheckBox *)checkBox {
    return 1;
}

-(void)checkBox:(ZZCheckBox *)checkBox didDeselectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        NSLog(@"ZZSingleCheckBox Deselected %ld Button", index);
    } else {
        NSLog(@"ZZMutableCheckBox Deselected %ld Button", index);
    }
    
}

-(void)checkBox:(ZZCheckBox *)checkBox didSelectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    } else {
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    }
}

@end
