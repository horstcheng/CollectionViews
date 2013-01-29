//
//  ModelController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSString *searchTerm;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
@end
