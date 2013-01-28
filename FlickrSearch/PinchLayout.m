//
//  PinchLayout.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "PinchLayout.h"

@implementation PinchLayout

- (void)setPinchScale:(CGFloat)pinchScale {
    _pinchScale = pinchScale;
    [self invalidateLayout];
}
- (void)setPinchCenter:(CGPoint)pinchCenter {
    _pinchCenter = pinchCenter;
    [self invalidateLayout];
}

- (UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self applySettingsToAttributes:attributes];
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    [layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop){
        [self applySettingsToAttributes:attributes];
    }];
    return layoutAttributes;
}


- (void)applySettingsToAttributes: (UICollectionViewLayoutAttributes*)attributes{
    NSIndexPath *indexPath = attributes.indexPath;
    attributes.zIndex = -indexPath.item;
    CGFloat deltaX = self.pinchCenter.x - attributes.center.x;
    CGFloat deltaY = self.pinchCenter.y - attributes.center.y;
    CGFloat scale = 1.0f - self.pinchScale;
    CATransform3D transform = CATransform3DMakeTranslation(deltaX * scale,
                                                           deltaY * scale,
                                                           0.0f);
    attributes.transform3D = transform;
}


@end
