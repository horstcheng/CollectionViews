//
//  PopoverViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PopoverViewControllerCompletion)(NSError* error, id sender);

@interface PopoverViewController : UIViewController
@property (nonatomic, strong) PopoverViewControllerCompletion completion;
@end
