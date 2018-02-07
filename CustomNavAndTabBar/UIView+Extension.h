//
//  UIView+Extension.h
//
//
//  Created by Fire on 15/7/27.
//  Copyright (c) 2015年 Fire. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CornerType){
    CornerTypeTopLeft  = 0,
    CornerTypeTopRight,
    CornerTypeBottomLeft,
    CornerTypeBottomRight,
    CornerTypeAll
};


@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic,assign,readonly) CGFloat maxY;
@property (nonatomic,assign,readonly) CGFloat minY;
@property (nonatomic,assign,readonly) CGFloat maxX;
@property (nonatomic,assign,readonly) CGFloat minX;

/**圆角*/
- (void)conerWithType:(CornerType)type andRadius:(CGFloat)Radius;


@end
