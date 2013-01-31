//
//  PageViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PageViewControllerCompletion)(NSError* error, id sender);


@interface PageViewController : UIViewController
@property (nonatomic, strong) PageViewControllerCompletion completionUserIsDone;
@end
