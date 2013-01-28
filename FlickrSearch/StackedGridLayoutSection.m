//
//  StackedGridLayoutSection.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "StackedGridLayoutSection.h"

@interface StackedGridLayoutSection ()
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) UIEdgeInsets itemInsets;
@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, strong) NSMutableArray* columnHeights;
@property (nonatomic, strong) NSMutableDictionary* indexToFrameMap;
@end

@implementation StackedGridLayoutSection
-(id)initWithOrigin:(CGPoint)origin
              width:(CGFloat)width
            columns:(NSInteger)columns
         itemInsets:(UIEdgeInsets)itemInsets{
    self = [super init];
    if(self){
        _frame = CGRectMake(origin.x, origin.y, width, 0.0);
        _itemInsets = itemInsets;
        _columnWidth = floorf(width / columns);
        _columnHeights = [@[]mutableCopy];
        _indexToFrameMap = [@{}mutableCopy];
        for(NSInteger i = 0; i < columns; i++){
            [self.columnHeights addObject:@(0.0)];
        }
    }
    return self;
}


-(CGRect)frame{
    return _frame;
}

-(CGFloat)columnWidth{
    return  _columnWidth;
}

-(NSInteger)numberOfItems{
    return _indexToFrameMap.count;
}

-(void)addItemOfSize:(CGSize)size forIndex:(NSInteger)index{
    __block CGFloat shortestColumnHeight = CGFLOAT_MAX;
    __block NSUInteger shortestColumnIndex = 0;

    [_columnHeights enumerateObjectsUsingBlock: ^(NSNumber *height, NSUInteger idx, BOOL *stop) {
        CGFloat thisColumnHeight = [height floatValue];
        if (thisColumnHeight < shortestColumnHeight) {
            shortestColumnHeight = thisColumnHeight;
            shortestColumnIndex = idx;
        }
    }];

    CGRect frame = (CGRect){
        .origin.x = _frame.origin.x + (_columnWidth * shortestColumnIndex) + _itemInsets.left,
        .origin.y = _frame.origin.y + shortestColumnHeight + _itemInsets.top,
        .size = size
    };
    
    _indexToFrameMap[@(index)] = [NSValue valueWithCGRect:frame];

    if (CGRectGetMaxY(frame) > CGRectGetMaxY(_frame)) {
        _frame.size.height = (CGRectGetMaxY(frame) - _frame.origin.y) + _itemInsets.bottom;
    }
    
    [_columnHeights replaceObjectAtIndex:shortestColumnIndex
                              withObject:@(shortestColumnHeight + size.height + _itemInsets.bottom)];
    
}

-(CGRect)frameForItemAtIndex:(NSInteger)index{
    return [_indexToFrameMap[@(index)] CGRectValue];
}

@end