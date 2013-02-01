//
//  AssetsViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/31/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AssetsViewControllerCompletion)(NSError* error, id sender);

@interface AssetsViewController : UIViewController
@property (nonatomic, strong) AssetsViewControllerCompletion completion;
@end
