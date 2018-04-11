//
//  YT_GuidePageViewController.m
//  YT_GuidePageVC
//
//  Created by 付宝网络 on 2018/4/11.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import "YT_GuidePageViewController.h"

@interface YT_GuidePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray * enterBtnArray;
@end

@implementation YT_GuidePageViewController
- (instancetype)initWithImageNameArray:(NSArray *)images{
    if (self = [super init]) {
        self.enterBtnArray = [[NSMutableArray alloc] initWithCapacity:0];
        UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        gui.delegate = self;
        gui.pagingEnabled = YES;
        // 隐藏滑动条
        gui.showsHorizontalScrollIndicator = NO;
        gui.showsVerticalScrollIndicator = NO;
        // 取消反弹
        gui.bounces = NO;
        for (NSInteger i = 0; i < images.count; i ++) {
            [gui addSubview:({
                self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
                self.btnEnter.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                [self.btnEnter setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];;
                self.btnEnter;
            })];
            
            [self.btnEnter addSubview:({
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"跳过" forState:UIControlStateNormal];
                if (i == images.count - 1) {
                    [btn setTitle:@"点击进入" forState:UIControlStateNormal];
                    btn.hidden = NO;
                }else{
                    btn.hidden = YES;
                }
                btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, [UIScreen mainScreen].bounds.size.height - 50, 100, 30);
                btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 60);
                btn.layer.cornerRadius = 4;
                btn.clipsToBounds = YES;
                btn.backgroundColor = [UIColor lightGrayColor];
                [btn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
                [self.enterBtnArray addObject:btn];
                btn;
                
            })];
            
            
            
        }
        gui.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * images.count, 0);
        [self.view addSubview:gui];
        
        // pageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 30)];
        self.pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 95);
        [self.view addSubview:self.pageControl];
        self.pageControl.numberOfPages = images.count;
    }
    return self;
}
#pragma mark - 设置pageControle的颜色
- (void)setPageControlNomalAndSelecteColorArray:(NSArray *)pageControlNomalAndSelecteColorArray{
    if (pageControlNomalAndSelecteColorArray.count >= 2) {
        self.pageControl.pageIndicatorTintColor = pageControlNomalAndSelecteColorArray[0];
        self.pageControl.currentPageIndicatorTintColor = pageControlNomalAndSelecteColorArray[1];
    }
    
}
#pragma mark - 设置除了最后一页的跳过按钮是否显示
- (void)setEveryPageShowEnterBtn:(BOOL)everyPageShowEnterBtn{
    [self.enterBtnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (everyPageShowEnterBtn == YES) {
            obj.hidden = NO;
        }else{
            if (idx == self.enterBtnArray.count- 1) {
                obj.hidden = NO;
            }else{
                obj.hidden = YES;
            }
        }
    }];
}
- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(enterViewController)]) {
        [self.delegate enterViewController];
    }
}
+ (BOOL)isFirstShow{
    NSString *isFirstShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstShow"];
    if (!isFirstShow) {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isFirstShow"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
    
}
#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
