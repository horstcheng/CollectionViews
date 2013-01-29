//
//  DataViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DataViewController

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
    SMLOG(@"");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    SMLOG(@"");
    self.pageNumberLabel.text = self.text;
    self.imageView.image = self.image;
}

-(void)setImage:(UIImage *)image{
    SMLOG(@"");
    self.imageView.image = self.image;
}

@end
