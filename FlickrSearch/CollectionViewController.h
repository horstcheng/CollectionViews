//
//  ViewController.h
//  FlickrSearch
//
//  Created by Fahim Farook on 24/7/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController
@property (nonatomic, strong) SmileViewControllerCompletion completionUserIsDone;
@property (nonatomic, strong) SmileViewControllerCompletion completionUserCancelled;
@end
