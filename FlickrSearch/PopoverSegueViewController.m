//
//  PopoverSegueViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "PopoverSegueViewController.h"

@interface PopoverSegueViewController ()

@end

@implementation PopoverSegueViewController

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
    self.contentSizeForViewInPopover = CGSizeMake(500.0, 500.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
