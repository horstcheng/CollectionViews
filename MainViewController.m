//
//  MainViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "CollectionViewController.h"
#import "PageViewController.h"
#import "PopoverViewController.h"
#import "SplitViewController.h"

static NSString* kSegueMainToCollection = @"segueMainToCollection";
static NSString* kSegueMainToPage = @"segueMainToPage";
static NSString* kSegueMainToPopover = @"segueMainToPopover";
static NSString* kSegueMainToSplit = @"segueMainToSplit";

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueMainToCollection]){
        CollectionViewController* cvc = segue.destinationViewController;
        cvc.completionUserIsDone = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToPage]){
        PageViewController* pvc = segue.destinationViewController;
        pvc.completionUserIsDone = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToPopover]){
        PopoverViewController* pvc = segue.destinationViewController;
        pvc.completion = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToSplit]){
        SplitViewController* svc = segue.destinationViewController;
        svc.completion = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
}

- (IBAction)collectionViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToCollection sender:self];
}
- (IBAction)pageViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToPage sender:self];
}
- (IBAction)popoverViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToPopover sender:self];
}
- (IBAction)splitViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToSplit sender:self];
}
- (IBAction)backButtonHandler:(id)sender {
    self.completion(nil, self);
}





#pragma mark Implements UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController{
    SMLOG(@"");
}

//- (BOOL)splitViewController:(UISplitViewController *)svc
//   shouldHideViewController:(UIViewController *)vc
//              inOrientation:(UIInterfaceOrientation)orientation{
//    SMLOG(@"");
//    return NO;
//}


- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc{
    
    SMLOG(@"");
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button{
    
    SMLOG(@"");
}

@end
