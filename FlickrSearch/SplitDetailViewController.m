//
//  SplitDetailViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SplitDetailViewController.h"
#import "MainViewController.h"

static NSString* kSegueSplitDetailToMain = @"segueSplitDetailToMain";

@interface SplitDetailViewController ()

@end

@implementation SplitDetailViewController

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
    if([segue.identifier isEqualToString:kSegueSplitDetailToMain]){
        UINavigationController* nc = segue.destinationViewController;
        MainViewController* mvc =  nc.viewControllers[0];
        mvc.completion = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
}

- (IBAction)showButtonViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueSplitDetailToMain sender:self];
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
