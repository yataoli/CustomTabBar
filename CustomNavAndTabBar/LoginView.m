//
//  LoginView.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _accountTextField = [UITextField createTextFieldWithLeftViewWidth:5.0];
        [self addSubview:_accountTextField];
        _accountTextField.placeholder = @"请输入账号";
        [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
            make.top.equalTo(self).with.offset(80);
            make.height.mas_equalTo(44);
        }];
        
        _passwordTextField = [UITextField createTextFieldWithLeftViewWidth:5.0];
        [self addSubview:_passwordTextField];
        _passwordTextField.placeholder = @"请输入密码";
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
            make.top.equalTo(_accountTextField).with.offset(60);
            make.height.mas_equalTo(44);
        }];

        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _loginButton.backgroundColor = [UIColor greenColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self addSubview:_loginButton];
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(100);
            make.right.equalTo(self).with.offset(-100);
            make.top.equalTo(_passwordTextField).offset(60);
            make.height.mas_equalTo(49);
            
        }];
        
        
    }
    return self;
}
- (void)viewDidLayoutSubviews{
    NSLog(@"**********");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
