//
//  HomeViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomColletionView.h"
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
@interface HomeViewController ()
@property (nonatomic,assign) GoodsListType showType;
@property (nonatomic,strong) CustomColletionView *collectionView;
@property (nonatomic,strong) UIButton *moveBtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self createUI];
}
- (void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[CustomColletionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.showType = self.showType;
    
    
    //更换展示商品列表的按钮
    _moveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moveBtn.frame = CGRectMake(ScreenWidth - 30 - 10, 64 + 10, 30, 30);
    [_moveBtn addTarget:self action:@selector(changeShowTypeHome:) forControlEvents:UIControlEventTouchUpInside];
    [_moveBtn setBackgroundImage:[UIImage imageNamed:@"商品列表样式2"] forState:UIControlStateNormal];
    [_moveBtn setBackgroundImage:[UIImage imageNamed:@"商品列表样式1"] forState:UIControlStateSelected];
    [self.view addSubview:_moveBtn];
    
    

}
#pragma mark - 更改展示样式
-(void)changeShowTypeHome:(UIButton *)btn{
    
    [YTInfoView showInfo:@"切换成功" onView:self];
    
    if (btn.isSelected) {
        btn.selected = NO;
        self.collectionView.showType =singleLineShowOneGoods;
        
    } else {
        btn.selected = YES;
        self.collectionView.showType =singleLinShowDouleGoods;
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
