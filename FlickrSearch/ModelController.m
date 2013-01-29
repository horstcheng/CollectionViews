//
//  ModelController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

@interface ModelController ()
	
@end

@implementation ModelController
- (id)init
{
    self = [super init];
    if (self) {
        self.searchResults = [@[]mutableCopy];
    }
    return self;
}
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard{
    SMLOG(@"");
    // Return the data view controller for the given index.
    if (([self.searchResults count] == 0) || (index >= [self.searchResults count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.text = self.searchTerm;
    return dataViewController;

}
- (NSUInteger)indexOfViewController:(DataViewController *)viewController{
    SMLOG(@"");
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.searchResults indexOfObject:viewController.text];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    SMLOG(@"");
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController] - 1;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    SMLOG(@"");
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.searchResults count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}





@end
