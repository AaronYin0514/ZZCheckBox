//
//  ZZCheckBox.h
//  ZZCheckBoxDemo
//
//  Created by 尹中正(外包) on 15/12/18.
//  Copyright © 2015年 尹中正(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
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
 *  button的数组
 */
@property (strong, nonatomic) NSMutableArray *checkBoxButtonArray;
/**
 *  向box中添加button
 *
 *  @param button 添加的button
 */
-(void)addCheckBoxButton:(ZZCheckBoxButton *)button;
/**
 *  判断Button是否已经在Box中了
 *
 *  @param button 需要验证的Button
 *
 *  @return YES存在  NO不存在
 */
-(BOOL)judgeCheckBoxButtonAllreadyInBox:(ZZCheckBoxButton *)button;

/**
 *  初始化方法
 *
 *  @param dataSource 数据源代理
 *  @param delegate   代理
 *
 *  @return 
 */
//-(instancetype)initWithDataSource:(id)dataSource andDelegate:(id)delegate;

@end

@protocol ZZCheckBoxDelegate <NSObject>

@optional
/**
 *  选中时的回调方法
 *
 *  @param checkBox checkBox
 *  @param index    button的index
 */
-(void)checkBox:(ZZCheckBox *)checkBox didSelectedAtIndex:(NSInteger)index;
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

@end
