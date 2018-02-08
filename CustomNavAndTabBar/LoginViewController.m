//
//  LoginViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"
@interface LoginViewController ()
@property (nonatomic,strong) LoginView *loginView;
@property (nonatomic,strong) LoginViewModel *viewModel;
@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _viewModel = [[LoginViewModel alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
     _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_loginView];
    [_loginView.accountTextField addTarget:self action:@selector(accountValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_loginView.passwordTextField addTarget:self action:@selector(passwordValueChanged:) forControlEvents:UIControlEventEditingChanged];

    [_loginView.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)accountValueChanged:(UITextField *)textField{
    self.viewModel.phoneString = textField.text;
}
- (void)passwordValueChanged:(UITextField *)textField{
    self.viewModel.passwordString = textField.text;
}

- (void)loginButtonClick:(UIButton *)button{
    if (_loginView.accountTextField.text.length <= 0 || _loginView.passwordTextField.text.length <= 0) {
        [YTInfoView showInfo:@"账号或者密码不能为空" onView:self];
        return;
    }
    [MBProgressHUD shouHUDWithStr:nil atView:self.view];
    [self.viewModel loginSuccess:^(id json) {
//        NSLog(@"登录数据===%@",json);
        [MBProgressHUD hiddenHUD];
        [YTInfoView showInfo:@"登录成功" onView:self];
        NSLog(@"----%@",@(_viewModel.dataSource.count));
    } fail:^(NSError *error) {
        NSLog(@"error===%@",error);
        [MBProgressHUD hiddenHUD];
    }];
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
