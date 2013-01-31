//
//  SplitViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SplitViewController.h"


@interface SplitViewController ()

@end

@implementation SplitViewController

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
    self.presentsWithGesture = YES;
    self.delegate = self.viewControllers[1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
