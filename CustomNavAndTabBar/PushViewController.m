//
//  PushViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()
@property (nonatomic,strong) UIView *smallView;
@property (nonatomic,strong) UIButton *dismissButton;
@end

@implementation PushViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.27 animations:^{
        _smallView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.35 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _dismissButton.transform = CGAffineTransformMakeRotation(M_PI_4);

    } completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:127 green:127 blue:127 alpha:0.2];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self createUI];
    
    
}
- (void)createUI{
    _smallView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    _smallView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_smallView];
    
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.frame = CGRectMake((_smallView.frame.size.width - 44)/2.0, _smallView.frame.size.height - 44 - 10, 44, 44);
    [_dismissButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    [_dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_smallView addSubview:_dismissButton];
    
}
- (void)dismissButtonClick:(UIButton *)button{
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.27 animations:^{
        button.transform = CGAffineTransformMakeRotation(- M_PI_4);
        _smallView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
    } completion:^(BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        
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
