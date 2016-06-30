# ZZCheckBox
## 简介
一个简单的单选框和复选框
## 使用
### 单选框
```obj-c
_singleCheckBox = [ZZCheckBoxGenerator checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
_singleCheckBox.tag = 1;
_singleCheckBox.delegate = self;
_singleCheckBox.dataSource = self;
```
### 复选框
```obj-c
_mutableCheckBox = [ZZCheckBoxGenerator checkBoxWithCheckBoxType:CheckBoxTypeMutableCheckBox];
_mutableCheckBox.tag = 2;
_mutableCheckBox.delegate = self;
_mutableCheckBox.dataSource = self;
```
### 使用storyboard创建时
```obj-c
_storyboardCheckBox = [ZZCheckBoxGenerator checkBoxWithCheckBoxType:CheckBoxTypeSingleCheckBox];
_storyboardCheckBox.tag = 3;
_storyboardCheckBox.delegate = self;
_storyboardCheckBox.storyboardDataSource = self;
```
### 数据源
```obj-c
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
```
### 使用storyboard时的数据源代理
```obj-c
-(NSInteger)numberOfStoryboardRowsInCheckBox:(ZZCheckBox *)checkBox {
    return self.checkBoxButtonArray.count;
}
-(ZZCheckBoxButton *)checkBox:(ZZCheckBox *)checkBox buttonAtIndex:(NSInteger)index {
    if (index < self.checkBoxButtonArray.count) {
        return self.checkBoxButtonArray[index];
    }
    return nil;
}
```
### 代理
```obj-c
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
```