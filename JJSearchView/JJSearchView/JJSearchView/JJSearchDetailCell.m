//
//  JJSearchDetailCell.m
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "JJSearchDetailCell.h"

@implementation JJSearchDetailCell
{
    UILabel *titleLab;
    UILabel *numLab;
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
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-120, 30)];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLab];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-110, 10, 100, 30)];
    numLab.font = [UIFont systemFontOfSize:12];
    numLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    numLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:numLab];
    
    UIView *cut = [[UIView alloc] initWithFrame:CGRectMake(10, 49, [UIScreen mainScreen].bounds.size.width-10, 1)];
    cut.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:cut];
}

- (void)setUpTitle:(NSString *)title num:(NSString *)num
{
    titleLab.attributedText = [self setupAttributeString:title highlightText:_keyword];
    numLab.text = num;
}
// 部分字体变色
- (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText {
    
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:225/255.0 green:51/255.0 blue:52/255.0 alpha:1]
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0f] range:hightlightTextRange];
    }
    return attributeStr;
}
@end
