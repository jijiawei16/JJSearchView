//
//  JJSearchHistoryCell.m
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "JJSearchHistoryCell.h"

@implementation JJSearchHistoryCell
{
    UIImageView *historyImg;
    UILabel *historyLab;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    historyImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    historyImg.image = [UIImage imageNamed:@"历史记录"];
    [self addSubview:historyImg];
    
    historyLab = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, self.frame.size.width-55, 30)];
    historyLab.font = [UIFont systemFontOfSize:14];
    historyLab.textColor = [UIColor blackColor];
    historyLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:historyLab];
    
    UIView *cut = [[UIView alloc] initWithFrame:CGRectMake(10, 49, [UIScreen mainScreen].bounds.size.width-10, 1)];
    cut.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:cut];
}

- (void)setUpHistory:(NSString *)history
{
    historyLab.text = [NSString stringWithFormat:@"%@",history];
}
@end
