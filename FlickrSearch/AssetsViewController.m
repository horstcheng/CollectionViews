//
//  AssetsViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/31/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsViewController.h"
#import "AssetsViewControllerCell.h"
#import "AssetsCollectionViewCellContent.h"


#define SM_USE_NSOPERATIONS 1


@interface AssetsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) NSOperationQueue* operationQueue;
@property (nonatomic, strong) NSMutableArray* assetsKeys;
@property (nonatomic, strong) NSMutableDictionary* assets;
@property (nonatomic, strong) ALAssetsLibrary* library;
@property (nonatomic) dispatch_queue_t updateQueue;
@property (nonatomic, strong) NSMutableArray* duplicateTitles;
@property (nonatomic, strong) NSMutableArray* duplicateURLs;
@end


@implementation AssetsViewController

#pragma mark UIKit methods
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeClass];
    
#if defined(SM_USE_NSOPERATIONS)
    NSBlockOperation* inspectAssetsOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self inspectAssets];
    }];
    
    [self.operationQueue addOperation:inspectAssetsOperation];
#else
    
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Custom class methods
- (IBAction)backButtonHandler:(id)sender {
    self.completion(nil, self);
}



-(void)initializeClass{
    
    self.operationQueue = [[NSOperationQueue alloc]init];
    self.operationQueue.name = @"com.webshots.smile";
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    
    self.assetsKeys = [@[]mutableCopy];
    self.assets = [@{}mutableCopy];
    self.library = [[ALAssetsLibrary alloc]init];
    self.updateQueue = dispatch_queue_create("com.webshot.smile.assetqueue", NULL);
    self.duplicateTitles = [@[]mutableCopy];
}

-(void)inspectAssets{
    __block NSMutableArray* groups = [@[]mutableCopy];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                    if (group) {
                                        NSString* groupName = [group valueForProperty:ALAssetsGroupPropertyName];
                                        if([groupName isEqualToString:@"Camera Roll"] ||
                                           [groupName isEqualToString:@"Smile"]){
                                            SMLOG(@"Adding %@", groupName);
                                            [groups addObject:group];
                                        }
                                        else{
                                            SMLOG(@"\tSkipping %@", groupName);
                                        }
                                    }
                                    else{
                                        [self inspectAssetGroups:groups];
                                    }
                                }
                              failureBlock:^(NSError *error) {
                                  SMLOG(@"User has blocked access to photos:");
                              }];
    
    
}



-(void)inspectAssetGroups:(NSMutableArray*)groups{
    
    for (ALAssetsGroup* group in groups){
        __block NSUInteger countAll = 0;
        __block NSUInteger countPhotos = 0;
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result){
                countAll++;
                if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    countPhotos++;
                    NSURL* url = [result defaultRepresentation].url;
                    NSString* urlString = url.absoluteString;
                    NSString* fileName = [result defaultRepresentation].filename;
                    UIImage* thumbnailImage = [UIImage imageWithCGImage:result.thumbnail];
                    AssetsCollectionViewCellContent* content = [[AssetsCollectionViewCellContent alloc ]init];
                    content.titleString = fileName;
                    content.thumbnailImage = thumbnailImage;
                    [self.assetsKeys addObject:urlString];
                    self.assets[urlString] = content;
                }
            }
            else{
                SMLOG(@"Loaded %d photos and %d assets total", countPhotos, countAll);
//                [self.operationQueue addOperationWithBlock:^{
//                    [self findDuplicateTitles];
//                }];
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [self refreshUI];
                }];
            }
            
            if(*stop == YES){
                SMLOG(@"stop is true");
            }
        }];
    }
}


-(void)findDuplicateTitles{
    SMLOG(@"Looking for duplicate image titles");
//    [self.duplicateTitles removeAllObjects];
//    NSString* lastTitle = nil;
//    for(NSString* key in self.assetsKeys){
//        AssetsCollectionViewCellContent* content = self.assets[key];
//        NSString* title = content.titleString;
//        SMLOG(@"comparing %@ to %@", content.titleString, lastTitle);
//        if([content.titleString compare:lastTitle] == NSOrderedSame){
//            SMLOG(@"Found duplicate image title:%@", content.titleString);
//            [self.duplicateTitles addObject:content.titleString];
//        }
//        lastTitle = [NSString stringWithFormat:@"%@", title];
//    }
}

-(void)findDuplicateURLS{
    
}



-(void)refreshUI{
//    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        [self.collectionView reloadData];
        self.statusLabel.text = @"Finished loading images";
//    }];
}

#pragma mark Implements UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.assetsKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AssetsViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetsViewControllerCell" forIndexPath:indexPath];
    NSString* key = self.assetsKeys[indexPath.item];
    AssetsCollectionViewCellContent* content = self.assets[key];
    cell.title.text = content.titleString;
    cell.imageView.image = content.thumbnailImage;
    return cell;
    
}

#pragma mark Implements UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SMLOG(@"");
}


@end
