//
//  MainViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MainViewControllerCompletion)(NSError* error, id sender);

@interface MainViewController : UIViewController
@property (nonatomic, strong) MainViewControllerCompletion completion;
@end
