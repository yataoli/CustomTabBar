//
//  CustomColletionView.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/21.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "CustomColletionView.h"
#import "SingleCollectionViewCell.h"
#import "DoubleCollectionViewCell.h"
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
@implementation CustomColletionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = RGB(242, 242, 242);
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[SingleCollectionViewCell class] forCellWithReuseIdentifier:@"SingleCollectionViewCell"];
        [self registerClass:[DoubleCollectionViewCell class] forCellWithReuseIdentifier:@"DoubleCollectionViewCell"];
    }
    return self;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showType == singleLineShowOneGoods) {
        SingleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        DoubleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DoubleCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showType == singleLineShowOneGoods) {
        return CGSizeMake(ScreenWidth, 117);
    }else{
        CGFloat height = ScreenWidth * 228/375.0f;
        return CGSizeMake(ScreenWidth/2.0-0.5, height);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.001f;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.001f;
}
#pragma mark - set方法
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
- (void)setShowType:(GoodsListType)showType{
    _showType = showType;
    [self reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
