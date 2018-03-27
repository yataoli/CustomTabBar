//
//  YT_PagingView.m
//  YTPageingView
//
//  Created by 付宝网络 on 2018/3/27.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import "YT_PagingView.h"
#define YTPageTitleViewWidth self.frame.size.width
#define YTPageTitleViewHeight self.frame.size.height


@interface YT_PagingView ()
// 保存外界传递过来的标题数组
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIScrollView *scrollView;

/// 记录所有子控件的宽度
@property (nonatomic, assign) CGFloat allBtnHeight;

/// 存储标题按钮的数组
@property (nonatomic, strong) NSMutableArray *btnMArr;
/// tempBtn
@property (nonatomic, strong) UIButton *tempBtn;
/// 标记按钮下标
@property (nonatomic, assign) NSInteger signBtnIndex;

/** 标题文字缩放比，默认为 0.1f，取值范围 0 ～ 0.3f */
@property (nonatomic, assign) CGFloat titleTextScaling;

@end


@implementation YT_PagingView
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames{
    if (self = [super initWithFrame:frame]){
        if (titleNames == nil) {
            @throw [NSException exceptionWithName:@"标题数组" reason:@"标题数组必须设置" userInfo:nil];
        }
        self.titleTextScaling = 0.2;
        self.titleArr = titleNames;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    // 1、添加 UIScrollView
    [self addSubview:self.scrollView];
    // 2、添加标题按钮
    [self setupTitleButtons];
}
#pragma mark - 添加标题按钮
- (void)setupTitleButtons {
    NSInteger titleCount = self.titleArr.count;

        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = YTPageTitleViewWidth;
        CGFloat btnH = 44;
    self.allBtnHeight = btnH * titleCount;
    self.allBtnHeight = ceilf(self.allBtnHeight);
        for (NSInteger index = 0; index < titleCount; index++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(btnX, btnY + btnH * index, btnW, btnH);
            btn.tag = index;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:self.titleArr[index] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(P_btn_action:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnMArr addObject:btn];
            [self.scrollView addSubview:btn];

        }
        self.scrollView.contentSize = CGSizeMake(0, btnH *titleCount);
    
}
#pragma mark - 标题按钮的点击事件
- (void)P_btn_action:(UIButton *)button {
    // 1、改变按钮的选择状态
    [self P_changeSelectedButton:button];
    // 2、滚动标题选中按钮居中
    if (self.allBtnHeight > YTPageTitleViewHeight) {
        [self P_selectedBtnCenter:button];
    }
    // 5、标记按钮下标
    self.signBtnIndex = button.tag;
    
    if ([self.delegate respondsToSelector:@selector(pageTitleSelecteIndex:andTitle:)]){
        [self.delegate pageTitleSelecteIndex:self.signBtnIndex andTitle:button.titleLabel.text];
    }
}
#pragma mark - 改变按钮的选择状态
- (void)P_changeSelectedButton:(UIButton *)button {
    if (self.tempBtn == nil) {
        button.selected = YES;
        self.tempBtn = button;
    } else if (self.tempBtn != nil && self.tempBtn == button){
        button.selected = YES;
    } else if (self.tempBtn != button && self.tempBtn != nil){
        self.tempBtn.selected = NO;
        button.selected = YES;
        self.tempBtn = button;
    }
    
    // 标题文字缩放属性
    [self.btnMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        btn.transform = CGAffineTransformMakeScale(1, 1);
    }];
    button.transform = CGAffineTransformMakeScale(1 + self.titleTextScaling, 1 + self.titleTextScaling);

}
#pragma mark - 滚动标题选中按钮居中
- (void)P_selectedBtnCenter:(UIButton *)centerBtn {
    // 计算偏移量
    CGFloat offsetY = centerBtn.center.y - YTPageTitleViewHeight * 0.5;
    if (offsetY < 0) offsetY = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetY = self.scrollView.contentSize.height - YTPageTitleViewHeight;
    if (offsetY > maxOffsetY) offsetY = maxOffsetY;
    // 滚动标题滚动条
    [self.scrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.frame = CGRectMake(0, 0, YTPageTitleViewWidth, YTPageTitleViewHeight);
    }
    return _scrollView;
}
- (NSMutableArray *)btnMArr {
    if (!_btnMArr) {
        _btnMArr = [NSMutableArray array];
    }
    return _btnMArr;
}
#pragma mark - 计算字符串宽度
- (CGFloat)SG_widthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
#pragma mark - 计算字符串高度
- (CGFloat)SG_heightWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
}

@end
