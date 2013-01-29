//
//  ViewController.h
//  FlickrSearch
//
//  Created by Fahim Farook on 24/7/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ViewControllerCompletion)(NSError* error, id sender);


@interface CollectionViewController : UIViewController
@property (nonatomic, strong) ViewControllerCompletion completionUserIsDone;
@property (nonatomic, strong) ViewControllerCompletion completionUserCancelled;
@end
