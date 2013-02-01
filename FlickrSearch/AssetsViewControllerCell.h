//
//  AssetsViewControllerCell.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/31/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsViewControllerCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel* title;
@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@end
