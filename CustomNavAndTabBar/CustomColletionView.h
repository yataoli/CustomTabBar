//
//  CustomColletionView.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/21.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,GoodsListType) {
    singleLineShowOneGoods,//一行展示单个商品
    singleLinShowDouleGoods,//一行展示两个商品
};


@interface CustomColletionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataArray;

/**商品展示类型*/
@property (nonatomic) GoodsListType showType;
@end
