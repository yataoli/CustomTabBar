//
//  GeRenMessageViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/1.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//
#define XGHeaderImageH 300

#import "GeRenMessageViewController.h"
#import <Masonry.h>
@interface GeRenMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIImageView *headImageView;
@end

@implementation GeRenMessageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 15; i ++) {
        NSString *tempString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"---第%@行---",@(i)]];
        [_dataSource addObject:tempString];
    }
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
//    _tableView.tableHeaderView = imageView;
    
    
    [self settingHeaderView];
    [self settingHeaderBackgroundView];
    
        [MBProgressHUD shouHUDWithString:nil];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hiddenHUD];
    });
    
    /*
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor greenColor];
    [_customNavigation addSubview:backButton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_customNavigation).with.offset(5);
        make.centerY.equalTo(_customNavigation).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    */


}
#pragma mark - 设置backgroundView
- (void)settingHeaderBackgroundView{
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, XGHeaderImageH)];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.image = [UIImage imageNamed:@"hahaha.png"];
    self.headImageView = headImageView;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backGroundView.backgroundColor = [UIColor redColor];
    [backGroundView addSubview:headImageView];
    
    self.tableView.backgroundView = backGroundView;
}
#pragma mark - 设置头部
- (void)settingHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, XGHeaderImageH - 64)];
//    headerView.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
//    NSLog(@"%@" ,@(offset.y));
    if (offset.y > 20) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if (offset.y < -20){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    CGRect tempFrame = self.headImageView.frame;
    // 如果offsetY大于0，说明是向上滚动，缩小
    if (offset.y > 0) {
        tempFrame.origin.y = -offset.y;
        self.headImageView.frame = tempFrame;
    }else{
        // 如果offsetY小于0，让headImageView的Y值等于0，headImageView的高度要放大
        tempFrame.size.height = XGHeaderImageH - offset.y;
        tempFrame.origin.y = 0;
        self.headImageView.frame = tempFrame;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
