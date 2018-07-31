//
//  ViewController.m
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "ViewController.h"
#import "JJSearchView.h"
#import "JJSearchDetailCell.h"

@interface ViewController ()<JJSearchViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView *noDate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
    noDate.backgroundColor = [UIColor clearColor];
    UIImageView *noDateImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 100, 100)];
    noDateImg.image = [UIImage imageNamed:@"暂无历史搜索"];
    [noDate addSubview:noDateImg];
    UILabel *noDateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 180, 20)];
    noDateLab.text = @"您还没有相关的历史搜索";
    noDateLab.textAlignment = NSTextAlignmentCenter;
    noDateLab.font = [UIFont systemFontOfSize:16];
    noDateLab.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    [noDate addSubview:noDateLab];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.11 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [JJSearchView showHistirys:@[@"hahah"] noDateView:noDate delegate:self];
    });
}
- (void)JJSearchView:(JJSearchView *)searchView didSearchKeyword:(NSString *)keyword
{
    searchView.items = @[@"",@"",@"",@""];
}
- (UITableViewCell *)JJSearchView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath keyword:(NSString *)keyword
{
    JJSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search"];
    if (cell == nil) {
        cell = [[JJSearchDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"search"];
    }
    cell.keyword = keyword;
    [cell setUpTitle:@"as'd'f'g'h" num:@"1111"];
    return cell;
}
- (void)JJSearchViewCleanHistorys
{
    NSLog(@"清理了历史记录");
}
@end
