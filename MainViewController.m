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

static NSString* kSegueMainToCollection = @"segueMainToCollection";
static NSString* kSegueMainToPage = @"segueMainToPage";

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
        CollectionViewController* vc = segue.destinationViewController;
        vc.completionUserIsDone = ^(NSError* error, id sender){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToPage]){
        
    }
}

- (IBAction)collectionViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToCollection sender:self];
}
- (IBAction)pageViewButtonHandler:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToPage sender:self];
}

@end
