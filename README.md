# ZZCheckBox
## 简介
一个简单的单选框和复选框

## 使用
### 单选框
```obj-c
_singleCheckBox = [[ZZSingleCheckBox alloc] init];
_singleCheckBox.tag = 1;
_singleCheckBox.delegate = self;
ZZCheckBoxButton *button1 = [[ZZCheckBoxButton alloc] initWithFrame:CGRectMake(100, 50, 30, 30) atIndex:0];
ZZCheckBoxButton *button2 = [[ZZCheckBoxButton alloc] initWithFrame:CGRectMake(100, 90, 30, 30) atIndex:1];
[_singleCheckBox addCheckBoxButton:button1];
[_singleCheckBox addCheckBoxButton:button2];
[self.view addSubview:button1];
[self.view addSubview:button2];
```
### 复选框
```obj-c
_mutableCheckBox = [[ZZMutableCheckBox alloc] init];
_mutableCheckBox.tag = 2;
_mutableCheckBox.delegate = self;
ZZCheckBoxButton *button3 = [[ZZCheckBoxButton alloc] initWithFrame:CGRectMake(100, 250, 30, 30) atIndex:0];
ZZCheckBoxButton *button4 = [[ZZCheckBoxButton alloc] initWithFrame:CGRectMake(100, 290, 30, 30) atIndex:1];
[_mutableCheckBox addCheckBoxButton:button3];
[_mutableCheckBox addCheckBoxButton:button4];
[self.view addSubview:button3];
[self.view addSubview:button4];
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