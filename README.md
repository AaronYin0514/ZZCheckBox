# ZZCheckBox
## 简介
一个简单的单选框和复选框

## 使用
### 单选框
```obj-c
_singleCheckBox = [[ZZCheckBox alloc] initWithCheckBoxType:CheckBoxTypeSingleCheckBox];
_singleCheckBox.tag = 1;
_singleCheckBox.delegate = self;
_singleCheckBox.dataSource = self;
```
### 复选框
```obj-c
_mutableCheckBox = [[ZZCheckBox alloc] initWithCheckBoxType:CheckBoxTypeMutableCheckBox];
_mutableCheckBox.tag = 2;
_mutableCheckBox.delegate = self;
_mutableCheckBox.dataSource = self;
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