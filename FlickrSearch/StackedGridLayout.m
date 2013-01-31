//
//  StackedGridLayout.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "StackedGridLayout.h"
#import "StackedGridLayoutSection.h"

@implementation StackedGridLayout


- (void)prepareLayout {
    [super prepareLayout];

    _myDelegate = (id <StackedGridLayoutDelegate>) self.collectionView.delegate;
    _sectionData = [NSMutableArray new];
    _height = 0.0f;
    
    CGPoint currentOrigin = CGPointZero;
    NSInteger numberOfSections = self.collectionView.numberOfSections;
    for (NSInteger i = 0; i < numberOfSections; i++) {
        _height += self.headerHeight;
        currentOrigin.y = _height;
    
        NSInteger numberOfColumns = [_myDelegate collectionView:self.collectionView
                                                         layout:self
                                       numberOfColumnsInSection:i];
        numberOfColumns = 6;
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:i];
        UIEdgeInsets itemInsets = [_myDelegate collectionView:self.collectionView layout:self itemInsetsForSectionAtIndex:i];
        StackedGridLayoutSection *section = [[StackedGridLayoutSection alloc] initWithOrigin:currentOrigin
                                                                                       width:self.collectionView.bounds.size.width columns:numberOfColumns
                                                                                  itemInsets:itemInsets];
        for (NSInteger j = 0; j < numberOfItems; j++) {
            CGFloat itemWidth = (section.columnWidth - section.itemInsets.left -
                                 section.itemInsets.right);
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:j
                                                             inSection:i];
            CGSize itemSize = [_myDelegate collectionView:self.collectionView
                                                   layout:self
                                     sizeForItemWithWidth:itemWidth
                                              atIndexPath:itemIndexPath];
            
            [section addItemOfSize:itemSize forIndex:j];
        }
        
        [_sectionData addObject:section];
        _height += section.frame.size.height;
        currentOrigin.y = _height;
    }
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, _height);
}

- (UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    StackedGridLayoutSection *section = _sectionData[indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [section frameForItemAtIndex:indexPath.item];
    return attributes;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    StackedGridLayoutSection *section = _sectionData[indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
                                                                                                                  withIndexPath:indexPath];
    CGRect sectionFrame = section.frame;
    CGRect headerFrame = CGRectMake(0.0f, sectionFrame.origin.y - self.headerHeight, sectionFrame.size.width, self.headerHeight);
    attributes.frame = headerFrame;
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [@[]mutableCopy];
    
    [_sectionData enumerateObjectsUsingBlock: ^(StackedGridLayoutSection *section,
                                                NSUInteger sectionIndex,
                                                BOOL *stop) {
        CGRect sectionFrame = section.frame; CGRect headerFrame =
        CGRectMake(0.0f,
                   sectionFrame.origin.y - self.headerHeight,
                   sectionFrame.size.width, self.headerHeight);

        if (CGRectIntersectsRect(headerFrame, rect)) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
            UICollectionViewLayoutAttributes *la = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        atIndexPath:indexPath];
            [attributes addObject:la];
        }
        if (CGRectIntersectsRect(sectionFrame, rect)) {
            for (NSInteger index = 0; index < section.numberOfItems; index++)
            {
                CGRect frame = [section frameForItemAtIndex:index];
               
                if (CGRectIntersectsRect(frame, rect)) {
                    NSIndexPath *indexPath =
                    [NSIndexPath indexPathForItem:index inSection:sectionIndex];
                    UICollectionViewLayoutAttributes *la = [self layoutAttributesForItemAtIndexPath:indexPath];
                    [attributes addObject:la];
                }
            }
        }
    }];
    
    return attributes;
}


@end
