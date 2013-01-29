//
//  DataViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) UIImage* image;

@end
