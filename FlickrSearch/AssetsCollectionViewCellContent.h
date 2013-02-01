//
//  AssetsCollectionViewCellContent.h
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/31/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsCollectionViewCellContent : NSObject
@property (nonatomic, strong) NSString* titleString;
@property (nonatomic, strong) NSString* dimensionsString;
@property (nonatomic, strong) UIImage* thumbnailImage;
@property (nonatomic, strong) UIImage* fullScreenImage;
@property (nonatomic, strong) UIImage* fullResolutionImage;
@end
