//
//  JJSearchDetailCell.h
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSearchDetailCell : UITableViewCell

/// 搜索关键字
@property (nonatomic , strong) NSString *keyword;

/// 设置cell属性
- (void)setUpTitle:(NSString *)title num:(NSString *)num;
@end
