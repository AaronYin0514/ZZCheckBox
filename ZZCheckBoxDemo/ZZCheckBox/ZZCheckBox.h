//
//  ZZCheckBox.h
//  ZZCheckBoxDemo
//
//  Created by Aaron on 15/12/18.
//  Copyright © Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZZCheckBoxButton.h"

typedef NS_ENUM(NSUInteger, CheckBoxType) {
    CheckBoxTypeSingleCheckBox = 100,
    CheckBoxTypeMutableCheckBox
};

@protocol ZZCheckBoxDelegate;
@protocol ZZCheckBoxDataSource;
@protocol ZZCheckBoxStoryboardDataSource;

@interface ZZCheckBox : NSObject
/**
 *  初始化
 *
 *  @param type 选择框类型
 *
 *  @return
 */
+(ZZCheckBox *)checkBoxWithCheckBoxType:(CheckBoxType)type;

+(instancetype)new UNAVAILABLE_ATTRIBUTE;
/**
 *  代理，当选中和取消选择时回调
 */
@property (weak, nonatomic) id <ZZCheckBoxDelegate> delegate;
/**
 *  使用代码创建CheckBoxButton时设置的数据源代理，此代理不能与storyboardDataSource一起设置
 */
@property (weak, nonatomic) id <ZZCheckBoxDataSource> dataSource;
/**
 *  使用storyboard创建CheckBoxButton时设置的数据源代理，此代理不能与dataSource一起设置
 */
@property (weak, nonatomic) id <ZZCheckBoxStoryboardDataSource> storyboardDataSource;
/**
 *  标记
 */
@property (assign, nonatomic) NSInteger tag;
/**
 *  选择框类型
 */
@property (assign, nonatomic, readonly) CheckBoxType type;
/**
 *  选中的索引
 */
@property (assign, nonatomic, readonly) NSUInteger selectedIndex;
/**
 *  button的数组
 */
@property (strong, nonatomic, readonly) NSArray *checkBoxButtonArray;
/**
 *  判断Button是否已经在Box中了
 *
 *  @param button 需要验证的Button
 *
 *  @return YES存在  NO不存在
 */
-(BOOL)judgeCheckBoxButtonAllreadyInBox:(ZZCheckBoxButton *)button;
/**
 *  手动设置选中某项
 *
 *  @param index 需要设置的项的索引
 */
-(BOOL)selectItemAtIndex:(NSInteger)index;
/**
 *  手动设置取消选中某项
 *
 *  @param index 需要设置的项的索引
 */
-(BOOL)deselectItemAtIndex:(NSInteger)index;
/**
 *  手动设置选中某项，如果是单选框，则数组最后一个元素起作用
 *
 *  @param items 需要设置的项的索引数组
 */
-(void)selectItemWithIndexArray:(NSArray<NSNumber *> *)items;
/**
 *  手动设置取消选中某项，如果是单选框，则数组最后一个元素起作用
 *
 *  @param items 需要设置的项的索引数组
 */
-(void)deselectItemWithIndexArray:(NSArray<NSNumber *> *)items;
/**
 *  清空选择
 */
-(void)clear;

@end

@protocol ZZCheckBoxDelegate <NSObject>

@optional
/**
 *  默认选中的索引,注意创建时不会走选中和去除选中状态的回调，需自行设置选中数据
 *
 *  @param checkBox checkBox
 *
 *  @return 返回默认选中的索引数组
 */
-(NSArray<NSNumber *> *)defaultSelectedIndexInCheckBox:(ZZCheckBox *)checkBox;
/**
 *  将要选中时的回调
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 是否选中，返回NO不能选中，YES可以选中
 */
-(BOOL)checkBox:(ZZCheckBox *)checkBox willSelectedAtIndex:(NSInteger)index;
/**
 *  选中时的回调方法
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 */
-(void)checkBox:(ZZCheckBox *)checkBox didSelectedAtIndex:(NSInteger)index;
/**
 *  将要取消选中时的回调
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 是否取消选中，返回NO不能选中，YES可以选中
 */
-(BOOL)checkBox:(ZZCheckBox *)checkBox willDeselectedAtIndex:(NSInteger)index;
/**
 *  取消选中时的回调方法
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 */
-(void)checkBox:(ZZCheckBox *)checkBox didDeselectedAtIndex:(NSInteger)index;
/**
 *  只对单选起作用，返回yes表示可以取消单选，默认为no
 *
 *  @param checkBox checkBox
 */
-(BOOL)canCancleCheckSingleCheckBox:(ZZCheckBox *)checkBox;

@end

@protocol ZZCheckBoxDataSource <NSObject>

@required
/**
 *  checkBox包含多少项
 *
 *  @param checkBox checkBox
 *
 *  @return 返回checkBox包含多少项
 */
-(NSInteger)numberOfRowsInCheckBox:(ZZCheckBox *)checkBox;
/**
 *  checkBox的父视图
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回checkBox的父视图
 */
-(UIView *)checkBox:(ZZCheckBox *)checkBox supperViewAtIndex:(NSInteger)index;

@optional
/**
 *  返回第index个button的frame
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回第index个button的frame
 */
-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index;
/**
 *  返回第index个button的标题
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回第index个button的标题
 */
-(NSString *)checkBox:(ZZCheckBox *)checkBox titleForCheckBoxAtIndex:(NSInteger)index;
/**
 *  返回第index个button的标题颜色
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回第index个button的标题颜色
 */
-(UIColor *)checkBox:(ZZCheckBox *)checkBox titleColorForCheckBoxAtIndex:(NSInteger)index;
/**
 *  返回第index个button的标题字体
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回第index个button的标题字体
 */
-(UIFont *)checkBox:(ZZCheckBox *)checkBox titleFontForCheckBoxAtIndex:(NSInteger)index;
/**
 *  checkBox图片
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *  @param state    状态
 *
 *  @return checkBox图片
 */
-(UIImage *)checkBox:(ZZCheckBox *)checkBox imageForCheckBoxAtIndex:(NSInteger)index forState:(UIControlState)state;
/**
 *  checkBox背景图片
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *  @param state    状态
 *
 *  @return checkBox背景图片
 */
-(UIImage *)checkBox:(ZZCheckBox *)checkBox backgroundImageForCheckBoxAtIndex:(NSInteger)index forState:(UIControlState)state;

@end

@protocol ZZCheckBoxStoryboardDataSource <NSObject>

@required
/**
 *  checkBox包含多少项
 *
 *  @param checkBox checkBox
 *
 *  @return 返回checkBox包含多少项
 */
-(NSInteger)numberOfStoryboardRowsInCheckBox:(ZZCheckBox *)checkBox;
/**
 *  返回第index位置的按钮
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 *
 *  @return 返回第index位置的按钮
 */
-(ZZCheckBoxButton *)checkBox:(ZZCheckBox *)checkBox buttonAtIndex:(NSInteger)index;

@end
