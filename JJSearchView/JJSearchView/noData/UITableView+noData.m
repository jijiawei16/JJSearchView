//
//  UITableView+noData.m
//  collection无数据
//
//  Created by 16 on 2018/6/6.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "UITableView+noData.h"
#import <objc/runtime.h>

@implementation UITableView (noData)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method1 = class_getInstanceMethod(self, @selector(reloadData));
        Method method2 = class_getInstanceMethod(self, @selector(jj_tableViewReloadData));
        method_exchangeImplementations(method1, method2);
    });
}
- (void)jj_tableViewReloadData{
    
    [self jj_tableViewReloadData];
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger rows = 0;
    if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        rows = [dataSource tableView:self numberOfRowsInSection:0];
    }
    [self.noDataView removeFromSuperview];
    if (rows <= 0) {

        self.noDataView.frame = CGRectMake((self.frame.size.width-self.noDataView.frame.size.width)/2, (self.frame.size.height-self.noDataView.frame.size.height)/2, self.noDataView.frame.size.width, self.noDataView.frame.size.height);
        [self addSubview:self.noDataView];
    }
}

#pragma mark 利用runtime添加属性
- (void)setNoDataView:(UIView *)noDataView
{
    objc_setAssociatedObject(self, @selector(noDataView), noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)noDataView
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
