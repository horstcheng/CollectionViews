//
//  StackedGridLayout.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StackedGridLayoutDelegate <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
   numberOfColumnsInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
    sizeForItemWithWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
   itemInsetsForSectionAtIndex:(NSInteger)section;
@end


@interface StackedGridLayout : UICollectionViewLayout{
    __unsafe_unretained id <StackedGridLayoutDelegate> _myDelegate;
    NSMutableArray *_sectionData;
    CGFloat _height;
}
@property (nonatomic, assign) CGFloat headerHeight;
@end
