//
//  JJSearchView.h
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSearchView;

@protocol JJSearchViewDelegate<NSObject>

/**
 * 搜索内容
 * @param searchView 搜索视图
 * @param keyword 要搜索的内容
 */
- (void)JJSearchView:(JJSearchView *)searchView didSearchKeyword:(NSString *)keyword;

/**
 * 设置tableView的cell样式
 * @param tableView 搜索展示视图
 * @param indexPath 坐标
 * @param keyword 搜索关键字
 */
- (UITableViewCell *)JJSearchView:(UITableView *)tableView
            cellForRowAtIndexPath:(NSIndexPath *)indexPath
                          keyword:(NSString *)keyword;

/**
 * 清空历史记录
 */
- (void)JJSearchViewCleanHistorys;
@end
@interface JJSearchView : UIView

/// 代理
@property (nonatomic , weak) id<JJSearchViewDelegate>delegate;
/// 数据源
@property (nonatomic , strong) NSArray *items;

/**
 * 初始化控件
 * @param delegate 设置代理对象
 */
+ (void)showHistirys:(NSArray *)historys noDateView:(UIView *)nodateView delegate:(id<JJSearchViewDelegate>)delegate;
@end
