//
//  JJSearchView.m
//  JJSearchView
//
//  Created by 16 on 2018/7/31.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "JJSearchView.h"
#import "UIButton+JJType.h"
#import "JJSearchHistoryCell.h"
#import "UITableView+noData.h"

#define IPHONEX ([UIScreen mainScreen].bounds.size.height == 812.0f)?YES:NO
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define nav_h (IPHONEX==YES)?88:64
#define bottom_h (IPHONEX==YES)?34:0
@interface JJSearchView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITextField *search;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *historys;
@property (nonatomic , strong) UIButton *cleanHistory;
@property (nonatomic , strong) UIView *noDateView;
@end
@implementation JJSearchView

static JJSearchView *search;
+ (void)showHistirys:(NSArray *)historys noDateView:(UIView *)nodateView delegate:(id<JJSearchViewDelegate>)delegate
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:[[self alloc] initWithHistorys:historys noDateView:nodateView delegate:delegate]];
}
- (instancetype)initWithHistorys:(NSArray *)historys noDateView:(UIView *)nodateView delegate:(id<JJSearchViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(0, window.frame.size.height, window.frame.size.width, window.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = window.bounds;
        }];
        self.noDateView = nodateView;
        self.delegate = delegate;
        self.historys = [NSMutableArray arrayWithArray:historys];
        self.backgroundColor = RGBA(250, 249, 249, 1);
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    CGFloat status_h = (IPHONEX)?44:20;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44+status_h)];
    header.backgroundColor = [UIColor clearColor];
    [self addSubview:header];
    
    self.search = [[UITextField alloc] initWithFrame:CGRectMake(10, 6+status_h, self.frame.size.width-80, 30)];
    _search.placeholder = @"请输入小区名字";
    _search.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _search.delegate = self;
    _search.leftViewMode = UITextFieldViewModeAlways;
    _search.backgroundColor = RGBA(230, 230, 230, 1);
    _search.layer.cornerRadius = 3;
    _search.layer.masksToBounds = YES;
    _search.clearsOnBeginEditing = NO;
    _search.clearButtonMode = UITextFieldViewModeWhileEditing;
    [header addSubview:_search];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(header.frame.size.width-60, 6+status_h, 50, 30)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:RGBA(89, 89, 89, 1) forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:cancel];
    
    CGFloat nav = nav_h;
    CGFloat bottom = bottom_h;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, nav_h, self.frame.size.width, self.frame.size.height-nav-bottom)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.noDataView = _noDateView;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    self.cleanHistory = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 55)];
    _cleanHistory.backgroundColor = [UIColor whiteColor];
    [_cleanHistory addTarget:self action:@selector(cleanHistoryClick) forControlEvents:UIControlEventTouchUpInside];
    [_cleanHistory setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [_cleanHistory setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [_cleanHistory setTitleColor:RGBA(89, 89, 89, 1) forState:UIControlStateNormal];
    _cleanHistory.titleLabel.font = [UIFont systemFontOfSize:12];
    [_cleanHistory layoutButtonWithEdgeInsetsStyle:JJButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    if (_historys.count) _tableView.tableFooterView = _cleanHistory;
}
- (void)cancelSearch
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark 监听textfield输入完成
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        _tableView.tableFooterView = _cleanHistory;
        self.items = nil;
        return;
    }
    if ([self.delegate respondsToSelector:@selector(JJSearchView:didSearchKeyword:)]) {
        [self.delegate JJSearchView:self didSearchKeyword:textField.text];
    }
    _tableView.tableFooterView = [UIView new];
    [self.historys addObject:textField.text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 更新搜索数据和历史数据
- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.tableView reloadData];
}
- (void)cleanHistoryClick
{
    _historys = [NSMutableArray array];
    [_tableView reloadData];
    _tableView.tableFooterView = [UIView new];
    if ([self.delegate respondsToSelector:@selector(JJSearchViewCleanHistorys)]) {
        [self.delegate JJSearchViewCleanHistorys];
    }
}
#pragma mark 展示视图代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _search.text.length?self.items.count:self.historys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_search.text.length) {
        JJSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history"];
        if (cell == nil) {
            cell = [[JJSearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"history"];
        }
        [cell setUpHistory:_historys[indexPath.row]];
        return cell;
    }else {
        // 自定义设置搜索展示cell
        return [self.delegate JJSearchView:tableView cellForRowAtIndexPath:indexPath keyword:_search.text];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
