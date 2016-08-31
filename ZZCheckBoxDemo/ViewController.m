//
//  ViewController.m
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ViewController.h"
#import "ZZCheckBox.h"

@interface ViewController ()<ZZCheckBoxDelegate, ZZCheckBoxDataSource, ZZCheckBoxStoryboardDataSource>
{
    ZZCheckBox *_singleCheckBox;
    ZZCheckBox *_mutableCheckBox;
    ZZCheckBox *_storyboardCheckBox;
}

@property (strong, nonatomic) IBOutletCollection(ZZCheckBoxButton) NSArray *checkBoxButtonArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _singleCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _singleCheckBox.tag = 1;
    _singleCheckBox.delegate = self;
    _singleCheckBox.dataSource = self;
    
    _mutableCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeMutableCheckBox];
    _mutableCheckBox.tag = 2;
    _mutableCheckBox.delegate = self;
    _mutableCheckBox.dataSource = self;
    
    _storyboardCheckBox = [ZZCheckBox checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
    _storyboardCheckBox.tag = 3;
    _storyboardCheckBox.delegate = self;
    _storyboardCheckBox.storyboardDataSource = self;
    
    ZZCheckBox *checkBox = [[ZZCheckBox alloc] init];
    NSLog(@"%@", checkBox ? @"YES" : @"NO");
    
}

#pragma mark - ZZCheckBoxDataSource
-(NSInteger)numberOfRowsInCheckBox:(ZZCheckBox *)checkBox {
    return 2;
}

-(UIView *)checkBox:(ZZCheckBox *)checkBox supperViewAtIndex:(NSInteger)index {
    return self.view;
}

-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        return CGRectMake(100, 50 + 40 * index, 120, 30);
    } else {
        return CGRectMake(100, 250 + 40 * index, 30, 30);
    }
}

-(NSString *)checkBox:(ZZCheckBox *)checkBox titleForCheckBoxAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        if (index == 0) {
            return @"测试一";
        } else {
            return @"测试测试二";
        }
    }
    return nil;
}

-(UIFont *)checkBox:(ZZCheckBox *)checkBox titleFontForCheckBoxAtIndex:(NSInteger)index {
    return [UIFont systemFontOfSize:15];
}

-(UIColor *)checkBox:(ZZCheckBox *)checkBox titleColorForCheckBoxAtIndex:(NSInteger)index {
    return [UIColor blueColor];
}

-(UIImage *)checkBox:(ZZCheckBox *)checkBox imageForCheckBoxAtIndex:(NSInteger)index forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        UIImage *image = [UIImage imageNamed:@""];
        return image;
    } else if (state == UIControlStateSelected) {
        UIImage *image = [UIImage imageNamed:@""];
        return image;
    }
    return nil;
}

#pragma mark - ZZCheckBoxDelegate
-(NSArray<NSNumber *> *)defaultSelectedIndexInCheckBox:(ZZCheckBox *)checkBox {
    return @[@1];
}

-(void)checkBox:(ZZCheckBox *)checkBox didDeselectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        NSLog(@"ZZSingleCheckBox Deselected %ld Button", index);
    } else {
        NSLog(@"ZZMutableCheckBox Deselected %ld Button", index);
    }
    
}

-(BOOL)canCancleCheckSingleCheckBox:(ZZCheckBox *)checkBox {
    if (checkBox.tag == 1) {
        return YES;
    }
    return NO;
}

-(void)checkBox:(ZZCheckBox *)checkBox didSelectedAtIndex:(NSInteger)index {
    if (checkBox.tag == 1) {
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    } else {
        NSLog(@"ZZSingleCheckBox Selected %ld Button", index);
    }
}

#pragma mark - ZZCheckBoxStoryboardDataSource
-(NSInteger)numberOfStoryboardRowsInCheckBox:(ZZCheckBox *)checkBox {
    return self.checkBoxButtonArray.count;
}

-(ZZCheckBoxButton *)checkBox:(ZZCheckBox *)checkBox buttonAtIndex:(NSInteger)index {
    if (index < self.checkBoxButtonArray.count) {
        return self.checkBoxButtonArray[index];
    }
    return nil;
}



@end
