//
//  JJSearchHistoryCell.h
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSearchHistoryCell : UITableViewCell

/**
 * 设置历史记录
 * @param history 历史记录信息
 */
- (void)setUpHistory:(NSString *)history;
@end
