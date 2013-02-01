//
//  ViewController.m
//  FlickrSearch
//
//  Created by Fahim Farook on 24/7/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//
// API Key - 2738538d006c93bf91120fbfa537b8a7
#import <MessageUI/MessageUI.h>
#import "CollectionViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"
#import "FlickrPhotoHeaderView.h"
#import "FlickrPhotoViewController.h"
#import "SimpleFlowLayout.h"
#import "PinchLayout.h"
#import "StackedGridLayout.h"
#import "CoverFlowLayout.h"

static const CGFloat kMinScale = 1.0f;
static const CGFloat kMaxScale = 3.0f;

@interface CollectionViewController () <UITextFieldDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    MFMailComposeViewControllerDelegate,
    StackedGridLayoutDelegate>

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIView *collectionViewContainer;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *layoutSelectionControl;
@property (nonatomic, weak) IBOutlet UICollectionView* currentPinchCollectionView;

@property (nonatomic, strong) NSMutableDictionary *searchResults;
@property (nonatomic, strong) NSMutableArray *searches;
@property (nonatomic, strong) Flickr *flickr;
@property (nonatomic) BOOL sharing;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout1;
@property (nonatomic, strong) SimpleFlowLayout* layout2;
@property (nonatomic, strong) StackedGridLayout* layout3;
@property (nonatomic, strong) CoverFlowLayout* layout4;

@property (nonatomic, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;
@property (nonatomic, strong) UIPinchGestureRecognizer* pinchOutGestureRecognizer;

@property (nonatomic, strong) NSIndexPath* currentPinchedItem;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    SMLOG(@"");
    [super viewDidLoad];
    
//	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
	UIImage *navBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27.0f, 27.0f, 27.0f, 27.0f)];
	[self.toolbar setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
	UIImage *shareButtonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f)];
	[self.shareButton setBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
	UIImage *textFieldImage = [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
	[self.textField setBackground:textFieldImage];
    
	self.searches = [@[] mutableCopy];
	self.searchResults = [@{} mutableCopy];
	self.flickr = [[Flickr alloc] init];
	self.selectedPhotos = [@[] mutableCopy];
    
    self.layout1 = [[UICollectionViewFlowLayout alloc] init];
    self.layout1.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout1.headerReferenceSize = CGSizeMake(0.0f, 90.0f);
    
    self.layout2= [[SimpleFlowLayout alloc]init];
    self.layout2.scrollDirection = UICollectionViewScrollDirectionVertical;

    self.layout3 = [[StackedGridLayout alloc]init];
    self.layout3.headerHeight = 90.0;
    
    self.layout4 = [[CoverFlowLayout alloc]init];
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    self.pinchOutGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinchOutGesture:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [self layoutSelectionTapped:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)shareButtonTapped:(id)sender {
    SMLOG(@"");
    UIBarButtonItem *shareButton = (UIBarButtonItem *)sender;
    if (!self.sharing) {
        self.sharing = YES;
        [shareButton setStyle:UIBarButtonItemStyleDone];
        [shareButton setTitle:@"Done"];
        [self.collectionView setAllowsMultipleSelection:YES];
    } else {
        self.sharing = NO;
        [shareButton setStyle:UIBarButtonItemStyleBordered];
        [shareButton setTitle:@"Share"];
        [self.collectionView setAllowsMultipleSelection:NO];
		
        if ([self.selectedPhotos count] > 0) {
            [self showMailComposerAndSend];
        }
		
        for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        [self.selectedPhotos removeAllObjects];
    }
}
- (IBAction)exitButtonTapped:(id)sender {
    exit(0);
}

- (IBAction)layoutSelectionTapped:(id)sender {
    SMLOG(@"");
    switch (self.layoutSelectionControl.selectedSegmentIndex) {
        case 0:
        default: {
            self.collectionView.collectionViewLayout = self.layout1;
            [self.collectionView removeGestureRecognizer:self.longPressGestureRecognizer];
            [self.collectionView removeGestureRecognizer:self.pinchOutGestureRecognizer];
        }
            break;
        case 1: {
            self.collectionView.collectionViewLayout = self.layout2;
            [self.collectionView addGestureRecognizer:self.longPressGestureRecognizer];
            [self.collectionView addGestureRecognizer:self.pinchOutGestureRecognizer];
        }
            break;
        case 2: {
            self.collectionView.collectionViewLayout = self.layout3;
            [self.collectionView removeGestureRecognizer:self.longPressGestureRecognizer];
            [self.collectionView removeGestureRecognizer:self.pinchOutGestureRecognizer];
        }
            break;
        case 3: {
            self.collectionView.collectionViewLayout = self.layout4;
            [self.collectionView removeGestureRecognizer:self.pinchOutGestureRecognizer];
            [self.collectionView removeGestureRecognizer:self.longPressGestureRecognizer];
        }
            break;
    }
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero animated:NO];
}


-(void)ViewControllerDelegateUserIsDone:(SmileViewControllerCompletion)completion{
    completion(nil, self);
}
-(void)ViewControllerDelegateUserCancelled:(SmileViewControllerCompletion)completion{
    completion(nil, self);    
}

- (IBAction)backButtonHandler:(id)sender {
    self.completionUserIsDone(nil, self);
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark UIGestureRecognizers
// We are going to delete an item with a long press
-(void)handleLongPressGesture:(UILongPressGestureRecognizer*)recognizer{
    if(recognizer.state == UIGestureRecognizerStateRecognized){
        CGPoint tapPoint = [recognizer locationInView:self.collectionView];
        NSIndexPath* item = [self.collectionView indexPathForItemAtPoint:tapPoint];
        if(item){
            NSString* searchTerm = self.searches[item.item];
            [self.searches removeObjectAtIndex:item.item];
            [self.searchResults removeObjectForKey:searchTerm];
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:@[item]];
            } completion:nil];
        }
    }
}

- (void)handlePinchOutGesture: (UIPinchGestureRecognizer*)recognizer
{
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint pinchPoint = [recognizer locationInView:self.collectionView];
        NSIndexPath *pinchedItem = [self.collectionView indexPathForItemAtPoint:pinchPoint];
        if (pinchedItem) {
            self.currentPinchedItem = pinchedItem;

            PinchLayout *layout = [[PinchLayout alloc] init];
            layout.itemSize = CGSizeMake(200.0f, 200.0f);
            layout.minimumInteritemSpacing = 20.0f;
            layout.minimumLineSpacing = 20.0f;
            layout.sectionInset = UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f);
            layout.headerReferenceSize = CGSizeMake(0.0f, 90.0f);
            layout.pinchScale = 0.0f;
            self.currentPinchCollectionView.collectionViewLayout = layout;
            self.currentPinchCollectionView.backgroundColor = [UIColor clearColor];
            self.currentPinchCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleHeight;
            [self.collectionViewContainer addSubview:self.currentPinchCollectionView];
            self.currentPinchCollectionView.frame = self.collectionView.frame;
            
            UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchInGesture:)];
            [_currentPinchCollectionView addGestureRecognizer:recognizer];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.currentPinchedItem) {
            CGFloat theScale = recognizer.scale;
            theScale = MIN(theScale, kMaxScale);
            theScale = MAX(theScale, kMinScale);
            CGFloat theScalePct = (theScale - kMinScale) / (kMaxScale - kMinScale);
            PinchLayout *layout = (PinchLayout*)_currentPinchCollectionView.collectionViewLayout;
            layout.pinchScale = theScalePct;
            layout.pinchCenter = [recognizer locationInView:self.collectionView];
            self.collectionView.alpha = 1.0f - theScalePct;
        }
    }
    else {
        if(self.currentPinchedItem){
            PinchLayout *layout = (PinchLayout*)_currentPinchCollectionView.collectionViewLayout;
            layout.pinchScale = 1.0f;
            self.collectionView.alpha = 0.0f;
        }
    }
}

- (void)handlePinchInGesture: (UIPinchGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan){
        self.collectionView.alpha = 0.0f;
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged){
        CGFloat theScale = 1.0f / recognizer.scale;
        theScale = MIN(theScale, kMaxScale);
        theScale = MAX(theScale, kMinScale);
        CGFloat theScalePct = 1.0f - ((theScale - kMinScale) / (kMaxScale - kMinScale));
        PinchLayout *layout = (PinchLayout*)self.currentPinchCollectionView.collectionViewLayout;
        layout.pinchScale = theScalePct; layout.pinchCenter = [recognizer locationInView:self.collectionView];
        self.collectionView.alpha = 1.0f - theScalePct;
    }
    else {
        self.collectionView.alpha = 1.0f;
        [self.currentPinchCollectionView removeFromSuperview];
        self.currentPinchedItem = nil;
    }
}






#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    SMLOG(@"");
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if (results && [results count] > 0) {
            if (![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %d photos matching %@", [results count],searchTerm);
                [self.searches addObject:searchTerm];
                self.searchResults[searchTerm] = results;
			}
			dispatch_async(dispatch_get_main_queue(), ^{
                // RUN AFTER SEARCH HAS FINISHED
                if (self.collectionView.collectionViewLayout == self.layout2) {
                    [self.collectionView performBatchUpdates:^{
                        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:(self.searches.count-1) inSection:0]]];
                    } completion:nil];
                }
                else {
                    [self.collectionView performBatchUpdates:^{
                        [self.collectionView insertSections: [NSIndexSet indexSetWithIndex:0]];
                    } completion:nil];
                }
			});
		} else {
			NSLog(@"Error searching Flickr: %@", error.localizedDescription);
		}
	}];
	
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    SMLOG(@"");
    if (cv == self.collectionView) {
        if(cv.collectionViewLayout == self.layout2){
            return self.searches.count;
        }
        else{
            NSString *searchTerm = self.searches[section];
            return [self.searchResults[searchTerm] count];
        }
    }
    else if (cv == self.currentPinchCollectionView){
        NSString *searchTerm = self.searches[self.currentPinchedItem.item];
        return [self.searchResults[searchTerm] count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)cv {
    SMLOG(@"");
//    if (cv == self.collectionView) {
//        return [self.searches count];
//    }
    
    if(cv == self.collectionView) {
        if(cv.collectionViewLayout == self.layout2){
            return 1; // we will only show one photo per section
        }
        
        else {
            return self.searches.count;
        }
    }
    else if (cv == self.currentPinchCollectionView) {
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SMLOG(@"");
    FlickrPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoCell" forIndexPath:indexPath];
    FlickrPhoto *photo = nil;
    if (cv == self.collectionView) {
        if(cv.collectionViewLayout == self.layout2){
            NSString *searchTerm = self.searches[indexPath.item];
            photo = self.searchResults[searchTerm][0];
        }
        else{
            NSString *searchTerm = self.searches[indexPath.section];
            photo = self.searchResults[searchTerm][indexPath.item];
        }
    }
    else if (cv == self.currentPinchCollectionView) {
        NSString *searchTerm = self.searches[self.currentPinchedItem.item];
        photo = self.searchResults[searchTerm][indexPath.item];
    }
    cell.photo = photo;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SMLOG(@"");
    FlickrPhotoHeaderView *headerView = [cv dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FlickrPhotoHeaderView" forIndexPath:indexPath];
    NSString *searchTerm = nil;
    if (cv == self.collectionView) {
        searchTerm = self.searches[indexPath.section];
    }
    else if (cv == self.currentPinchCollectionView) {
        searchTerm = self.searches[self.currentPinchedItem.item];
    }
    [headerView setSearchText:searchTerm];
    return headerView;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SMLOG(@"");
	if (self.sharing) {
		NSString *searchTerm = self.searches[indexPath.section];
		FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.item];
		[self.selectedPhotos addObject:photo];
	}
    else {
        FlickrPhoto *photo = nil;
        if (cv == self.collectionView) {
            if(cv.collectionViewLayout == self.layout2){
                NSString *searchTerm = self.searches[indexPath.item];
                photo = self.searchResults[searchTerm][0];
            }
            else{
                NSString *searchTerm = self.searches[indexPath.section];
                photo = self.searchResults[searchTerm][indexPath.item];
            }
        }
        else if (cv == self.currentPinchCollectionView){
            NSString *searchTerm = self.searches[self.currentPinchedItem.item];
            photo = self.searchResults[searchTerm][indexPath.item];
        }
		[self performSegueWithIdentifier:@"ShowFlickrPhoto" sender:photo];
		[self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
	}
}

- (void)collectionView:(UICollectionView *)cv didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    SMLOG(@"");
	if (self.sharing) {
		NSString *searchTerm = self.searches[indexPath.section];
		FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.item];
		[self.selectedPhotos removeObject:photo];
	}
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SMLOG(@"");
    FlickrPhoto *photo = nil;
    if (cv == self.collectionView) {
        if(cv.collectionViewLayout == self.layout2){
            NSString *searchTerm = self.searches[indexPath.item];
            photo = self.searchResults[searchTerm][0];
        }
        else{
            NSString *searchTerm = self.searches[indexPath.section];
            photo = self.searchResults[searchTerm][indexPath.item];
        }
    }
    else if (cv == self.currentPinchCollectionView){
        NSString *searchTerm = self.searches[self.currentPinchedItem.item];
        photo = self.searchResults[searchTerm][indexPath.item];
    }
    
    CGSize retval = photo.thumbnail.size.width > 0.0f ? photo.thumbnail.size : CGSizeMake(100.0f, 100.0f);
    retval.height += 35.0f;
    retval.width += 35.0f;
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl insetForSectionAtIndex:(NSInteger)section {
    SMLOG(@"");
    if (cvl == self.layout4) {
        NSString *searchTerm = self.searches[section];
        NSArray *results = self.searchResults[searchTerm];
        FlickrPhoto *firstPhoto = results[0];
        CGSize firstItemSize = firstPhoto.thumbnail.size;
        firstItemSize.height += 35.0f;
        firstItemSize.width += 35.0f;
        FlickrPhoto *lastPhoto = results[results.count - 1];
        CGSize lastItemSize = lastPhoto.thumbnail.size;
        lastItemSize.height += 35.0f;
        lastItemSize.width += 35.0f;
        return UIEdgeInsetsMake(0.0f,
                                (cv.bounds.size.width - firstItemSize.width) / 2.0f, 0.0f,
                                (cv.bounds.size.width - lastItemSize.width) / 2.0f);
    }
    else {
        return UIEdgeInsetsMake(50.0f, 20.0f, 50.0f, 20.0f);
    }
    return UIEdgeInsetsZero;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowFlickrPhoto"]) {
        FlickrPhotoViewController *flickrPhotoViewController = segue.destinationViewController;
        flickrPhotoViewController.flickrPhoto = sender;
    }
}

- (void)showMailComposerAndSend {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
		
        [mailer setSubject:@"Check out these Flickr Photos"];
		
        NSMutableString *emailBody = [NSMutableString string];
        for( FlickrPhoto *flickrPhoto in self.selectedPhotos) {
            NSString *url = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:@"m"];
            [emailBody appendFormat:@"<div><img src='%@'></div><br>",url];
        }
		
        [mailer setMessageBody:emailBody isHTML:YES];
		
        [self presentViewController:mailer animated:YES completion:^{}];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failure"
                                                        message:@"Your device doesn't support in-app email"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:^{}];
}


#pragma Implements StackedGridLayoutDelegate
- (NSInteger)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
   numberOfColumnsInSection:(NSInteger)section{
    return 3;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
   itemInsetsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.0, 0.0, 00.0, 00.0);
}

- (CGSize)collectionView:(UICollectionView*)cv layout:(UICollectionViewLayout*)cvl
    sizeForItemWithWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{

    NSString* searchTerm = self.searches[indexPath.section];
    FlickrPhoto* photo = self.searchResults[searchTerm][indexPath.item];
    CGSize picSize = photo.thumbnail.size.width > 0.0f ? photo.thumbnail.size : CGSizeMake(100.0f, 100.0f);
//    picSize.height += 35.0;
//    picSize.width += 35.0;
    CGSize retval = CGSizeMake(width, picSize.height * width / picSize.width);
    return retval;
}

@end
