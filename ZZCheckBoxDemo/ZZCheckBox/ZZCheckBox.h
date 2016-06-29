//
//  ZZCheckBox.h
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CheckBoxType) {
    CheckBoxTypeSingleCheckBox = 100,
    CheckBoxTypeMutableCheckBox
};

@protocol ZZCheckBoxDelegate;
@protocol ZZCheckBoxDataSource;

@class ZZCheckBoxButton;

@interface ZZCheckBox : NSObject
/**
 *  代理，当选中和取消选择时回调
 */
@property (weak, nonatomic) id <ZZCheckBoxDelegate> delegate;
/**
 *  数据源代理
 */
@property (weak, nonatomic) id <ZZCheckBoxDataSource> dataSource;
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
 *  初始化
 *
 *  @param type 选择框类型
 *
 *  @return
 */
-(instancetype)initWithCheckBoxType:(CheckBoxType)type;

@end

@protocol ZZCheckBoxDelegate <NSObject>

@optional
/**
 *  默认选中的索引
 *
 *  @param checkBox checkBox
 *
 *  @return 返回默认选中的索引
 */
-(NSUInteger)defaultSelectedIndexInCheckBox:(ZZCheckBox *)checkBox;
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

@end

@protocol ZZCheckBoxDataSource <NSObject>

@required

-(NSInteger)numberOfRowsInCheckBox:(ZZCheckBox *)checkBox;

-(UIView *)checkBox:(ZZCheckBox *)checkBox supperViewAtIndex:(NSInteger)index;

@optional

-(CGRect)checkBox:(ZZCheckBox *)checkBox frameAtIndex:(NSInteger)index;

-(NSString *)checkBox:(ZZCheckBox *)checkBox titleForCheckBoxAtIndex:(NSInteger)index;

-(UIColor *)checkBox:(ZZCheckBox *)checkBox titleColorForCheckBoxAtIndex:(NSInteger)index;

-(UIFont *)checkBox:(ZZCheckBox *)checkBox titleFontForCheckBoxAtIndex:(NSInteger)index;

@end
