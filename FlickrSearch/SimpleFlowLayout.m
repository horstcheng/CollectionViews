//
//  SimpleFlowLayout.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SimpleFlowLayout.h"

@interface SimpleFlowLayout ()
@property (nonatomic, strong) NSMutableArray* insertedIndexPaths;
@property (nonatomic, strong) NSMutableArray* deletedIndexPaths;
@end

@implementation SimpleFlowLayout
-(void)prepareLayout{
    SMLOG(@"");
    _insertedIndexPaths = [@[]mutableCopy];
    _deletedIndexPaths = [@[]mutableCopy];
}




- (void)prepareForCollectionViewUpdates:(NSArray*)updates {
    SMLOG(@"");
    [super prepareForCollectionViewUpdates:updates];
    for (UICollectionViewUpdateItem *updateItem in updates) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertedIndexPaths addObject:
             updateItem.indexPathAfterUpdate];
        }
        else if (updateItem.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deletedIndexPaths addObject:updateItem.indexPathBeforeUpdate];
        }
    }
}


- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath*)itemIndexPath
{
    SMLOG(@"");
 //   if ([self.insertedIndexPaths containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        CGRect visibleRect = (CGRect){
            .origin = self.collectionView.contentOffset,
            .size = self.collectionView.bounds.size
        };
        attributes.center = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        attributes.alpha = 0.0f;
        attributes.transform3D = CATransform3DMakeScale(0.6f, 0.6f, 1.0f);
        return attributes;
//    } else {
//        return
//        [super initialLayoutAttributesForAppearingItemAtIndexPath: itemIndexPath];
//    }
}
- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath*)itemIndexPath
{
    SMLOG(@"");
//    if ([self.deletedIndexPaths containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        CGRect visibleRect = (CGRect){
            .origin = self.collectionView.contentOffset,
            .size = self.collectionView.bounds.size
        };
        attributes.center = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        attributes.alpha = 0.0f;
        attributes.transform3D = CATransform3DMakeScale(1.3f, 1.3f, 1.0f);
        return attributes;
//    }
//    else {
//        return [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
//    }
}

- (void)finalizeCollectionViewUpdates {
    SMLOG(@"");
    [self.insertedIndexPaths removeAllObjects];
    [self.deletedIndexPaths removeAllObjects];
}
@end
