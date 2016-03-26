//
//  ViewController.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/3.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "ViewController.h"
#import "PullScrollView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int sum;
}
@property(nonatomic,strong)UITableView* tabview;
@property(nonatomic,strong)PullScrollView* pullScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XYPanicBuyView* v= [[XYPanicBuyView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    [self.view addSubview:v];
//    _tabview = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    _tabview.delegate = self;
//    _tabview.dataSource = self;
//    [self.view addSubview:_tabview];
//    
//    //WithFrame:CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight)
//    _pullScrollView = [[PullScrollView alloc] init];
//    _pullScrollView.scrollView = _tabview;
//    [_pullScrollView header];
//    WEAKSELF
//    _pullScrollView.refreshBlock = ^(){
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(2);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//        sum = 5;
//         [weakSelf.pullScrollView endRefresh];
//        [weakSelf.tabview reloadData];
//        });
//        });
//    };
//    [_pullScrollView beginRefresh];
    //[_tabview addSubview:_pullScrollView];
//    XYHomeTopView* v= [[XYHomeTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    [v imageStrArray];
//    [self.view addSubview:v];
//    XYGridView* v1 = [[XYGridView alloc] initWithFrame:CGRectMake(0, v.frame.size.height, kScreenWidth, 200)];
//    [self.view addSubview:v1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return sum;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-----cell",indexPath.row+1];
    return cell;
}
@end
