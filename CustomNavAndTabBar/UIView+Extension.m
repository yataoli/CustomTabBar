//
//  UIView+Extension.m
//  
//
//  Created by Fire on 15/7/27.
//  Copyright (c) 2015年 Fire. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}
- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

-(CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGSize)size{
    return self.frame.size;
}
/**圆角*/
- (void)conerWithType:(CornerType)type andRadius:(CGFloat)Radius{
    CGSize cornerSize = CGSizeMake(Radius, Radius);
    UIRectCorner corner;
    switch (type) {
        case CornerTypeTopLeft:
            corner = UIRectCornerTopLeft;
            break;
        case CornerTypeTopRight:
            corner = UIRectCornerTopRight;
            break;
        case CornerTypeBottomLeft:
            corner = UIRectCornerBottomLeft;
            break;
        case CornerTypeBottomRight:
            corner = UIRectCornerBottomRight;
            break;
        case CornerTypeAll:
            corner = UIRectCornerAllCorners;
            break;

    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:cornerSize];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    layer.frame = self.bounds;
    self.layer.mask = layer;

}
@end
