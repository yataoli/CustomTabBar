//
//  SingleCollectionViewCell.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/21.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "SingleCollectionViewCell.h"
#import <Masonry.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface SingleCollectionViewCell ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *goodsPriceLabel;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation SingleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self layout];
    }
    return self;
}
- (void)createUI{
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    //商品图片
    self.goodsImgeView = [[UIImageView alloc]init];
    self.goodsImgeView.image = [UIImage imageNamed:@"floor3"];
    [self.bgView addSubview:self.goodsImgeView];
    
    //商品描述
    self.goodsNameLabel = [[UILabel alloc]init];
    self.goodsNameLabel.numberOfLines = 2;
    self.goodsNameLabel.textColor = RGB(68, 68, 68);
    self.goodsNameLabel.font = [UIFont systemFontOfSize:14.0];
    self.goodsNameLabel.backgroundColor = [UIColor whiteColor];
    self.goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.goodsNameLabel.text=@"澳洲熏香抱枕";
    [self.bgView addSubview:self.goodsNameLabel];
    
    //商品价格
    self.goodsPriceLabel = [[UILabel alloc]init];
    self.goodsPriceLabel.textColor =  RGB(255, 16, 16);
    self.goodsPriceLabel.font = [UIFont systemFontOfSize:16.0];
    self.goodsPriceLabel.backgroundColor = [UIColor whiteColor];
    [self.goodsPriceLabel sizeToFit];
    self.goodsPriceLabel.text=@"$200.00";
    [self.bgView addSubview:self.goodsPriceLabel];
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = RGB(218, 218, 218);
    [self.bgView addSubview:self.bottomView];
    
}
-(void)layout{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    [_goodsImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.center.y).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(14);
        make.size.mas_equalTo(CGSizeMake(91, 91));
    }];
    
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(21);
        make.left.mas_equalTo(self.goodsImgeView.mas_right).offset(35);
        make.right.mas_equalTo(self.mas_right).offset(-14);
    }];
    
    [_goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImgeView.mas_right).offset(35);
        make.right.mas_equalTo(self.goodsNameLabel.mas_right).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-26);
        make.height.mas_equalTo(@(15));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
}
@end
