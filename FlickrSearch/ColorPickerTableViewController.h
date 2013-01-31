//
//  ColorPickerTableViewController.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerTableViewControllerDelegate
- (void)colorSelected:(NSString *)color;
@end


@interface ColorPickerTableViewController : UITableViewController
@property (nonatomic, weak) id<ColorPickerTableViewControllerDelegate> delegate;
@end