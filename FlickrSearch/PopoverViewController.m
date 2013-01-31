//
//  PopoverViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//  dismissPopoverAnimated:
// http://www.raywenderlich.com/1056/ipad-for-iphone-developers-101-uipopovercontroller-tutorial

#import "PopoverViewController.h"
#import "ColorPickerTableViewController.h"

@interface PopoverViewController () <UIPopoverControllerDelegate, ColorPickerTableViewControllerDelegate>
@property (nonatomic, strong) ColorPickerTableViewController *colorPicker;
@property (nonatomic, strong) UIPopoverController *colorPickerPopover;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *showCustomPopoverButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation PopoverViewController

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


- (IBAction)showCustomPopoverButtonHandler:(id)sender {
    if (self.colorPicker == nil) {
        self.colorPicker = [[ColorPickerTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _colorPicker.delegate = self;
        self.colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
    }
    
    
    [self.colorPickerPopover setPassthroughViews:@[self.containerView]];
    [self.colorPickerPopover presentPopoverFromRect:self.showCustomPopoverButton.frame
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionRight
                                           animated:YES];
}

- (IBAction)doneButtonHandler:(id)sender {
    self.completion(nil, self);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if(self.colorPickerPopover){
        [self.colorPickerPopover dismissPopoverAnimated:NO];

        [self.colorPickerPopover presentPopoverFromRect:self.showCustomPopoverButton.frame
                                                 inView:self.view
                               permittedArrowDirections:UIPopoverArrowDirectionRight
                                               animated:YES];
        
    }
}

#pragma mark Implements UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    
    return YES;
}




#pragma mark Implements ColorPickerTableViewController
- (void)colorSelected:(NSString *)color{
    if ([color compare:@"Red"] == NSOrderedSame) {
        self.nameLabel.textColor = [UIColor redColor];
    } else if ([color compare:@"Green"] == NSOrderedSame) {
        self.nameLabel.textColor = [UIColor greenColor];
    } else if ([color compare:@"Blue"] == NSOrderedSame){
        self.nameLabel.textColor = [UIColor blueColor];
    }
    [self.colorPickerPopover dismissPopoverAnimated:YES];
}

@end

