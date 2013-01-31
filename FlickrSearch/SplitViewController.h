//
//  SplitViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//  http://www.raywenderlich.com/1040/ipad-for-iphone-developers-101-uisplitview-tutorial

#import <UIKit/UIKit.h>
typedef void (^SplitViewControllerCompletion)(NSError* error, id sender);

@interface SplitViewController : UISplitViewController
@property (nonatomic, strong) SplitViewControllerCompletion completion;
@end
