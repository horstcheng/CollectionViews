//
//  ViewController.h
//  FlickrSearch
//
//  Created by Fahim Farook on 24/7/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^CollectionViewControllerCompletion)(NSError* error, id sender);


@interface CollectionViewController : UIViewController
@property (nonatomic, strong) CollectionViewControllerCompletion completionUserIsDone;
@property (nonatomic, strong) CollectionViewControllerCompletion completionUserCancelled;
@end
