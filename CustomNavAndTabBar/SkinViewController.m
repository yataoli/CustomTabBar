//
//  SkinViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/7.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "SkinViewController.h"
#import "SkinManager.h"
@interface SkinViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_skinsArray;
    NSInteger _selectedRow;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _skinsArray = [[NSMutableArray alloc] initWithObjects:@"1098", @"1108", @"1110", @"1111", @"1114", nil];
    _selectedRow = [_skinsArray indexOfObject:[SkinManager shareSkinManager].currentSkin];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _skinsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _skinsArray[indexPath.row];
    if (_selectedRow == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name = _skinsArray[indexPath.row];
    
    [SkinManager shareSkinManager].currentSkin = name;
    
    [[NSUserDefaults standardUserDefaults] setObject:[SkinManager shareSkinManager].currentSkin forKey:@"currentSkin"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //取消上个的选中。
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedRow inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //选中当前这个。
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //    NSLog(@"%@",NSHomeDirectory());
    _selectedRow = indexPath.row;
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
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
