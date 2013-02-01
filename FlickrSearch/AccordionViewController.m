//
//  AccordionViewController.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 2/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "AccordionViewController.h"
#import "AccordionViewCell.h"
#import "AccordionHeaderView.h"

@interface AccordionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* sectionKeys;
@property (strong, nonatomic) NSMutableDictionary *sections;
@property (nonatomic, assign) int currentlyExpandedIndex;
@property (nonatomic) bool accordionIsVisible;
@end

@implementation AccordionViewController


- (void)viewDidLoad
{
    _accordionIsVisible = YES;
    
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftGestureHandler:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightGestureHandler:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    
    [super viewDidLoad];
    
    _sectionKeys = [@[@"2012", @"2011", @"2010", @"2009", @"2008", @"2007", @"2006", @"2005", @"2004", @"2003", @"2002", @"2001", @"2000", @"1999", @"1998", @"1997", @"1996", @"1995"]mutableCopy];
    self.sections = [@{
                     _sectionKeys[0] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[1] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[2] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[3] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[4] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[5] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[6] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[7] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[8] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[9] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[10] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[11] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[12] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[13] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[14] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[15] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[16] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     _sectionKeys[17] : @[@"January", @"February", @"Smarch", @"April", @"May", @"June", @"July", @"August", @"October", @"November", @"December"],
                     }mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonHandler:(id)sender {
    self.completion(nil, self);
}


-(void)swipeLeftGestureHandler:(id)sender{
    SMLOG(@"Swiped Left");
    if(self.accordionIsVisible == NO){
        [UIView animateWithDuration:0.25
                            animations:^{
                                //self.tableView.alpha = 1.0f;
                                CGRect newFrame = self.tableView.frame;
                                newFrame.origin = CGPointMake(newFrame.origin.x - newFrame.size.width, 0);
                                self.tableView.frame = newFrame;
                                self.accordionIsVisible = YES;
                            }
                            completion:^(BOOL finished){
                                
                            }];
    }
}
-(void)swipeRightGestureHandler:(id)sender{
    SMLOG(@"Swiped Right");
    if(self.accordionIsVisible){
        [UIView animateWithDuration:0.25
                         animations:^{
                             //                         self.tableView.alpha = 0.0f;
                             CGRect newFrame = self.tableView.frame;
                             newFrame.origin = CGPointMake(newFrame.origin.x + newFrame.size.width, 0);
                             self.tableView.frame = newFrame;
                             self.accordionIsVisible = NO;
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }
}

-(void)openAccordionAtIndex:(int) index {
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSString* key = self.sectionKeys[self.currentlyExpandedIndex];
    NSArray* array = self.sections[key];
    int sectionCount = array.count;
    
    for(int i = 0; i < sectionCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.currentlyExpandedIndex];
        [indexPaths addObject:indexPath];
    }
    
    self.currentlyExpandedIndex = -1;
    
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationTop];
    
    self.currentlyExpandedIndex = index;
    
    key = self.sectionKeys[self.currentlyExpandedIndex];
    array = self.sections[key];
    sectionCount = array.count;

    [indexPaths removeAllObjects];
    for(int i = 0; i < sectionCount; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.currentlyExpandedIndex];
        [indexPaths addObject:indexPath];
    }
    
    double delayInSeconds = 0.15;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    });
    
    [self.tableView endUpdates];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.currentlyExpandedIndex == section) {
        NSString* key = self.sectionKeys[section];
        NSArray* array = self.sections[key];
        return array.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccordionViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AccordionViewCell"];
    if(cell == nil) return [[UITableViewCell alloc]init];
    
    NSString* key = self.sectionKeys[indexPath.section];
    NSArray* array = self.sections[key];
    NSString* title = array[indexPath.row];
    cell.title.text = title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AccordionHeaderView* headerView = [[[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    [headerView.button setTitle:self.sectionKeys[section]
                       forState:UIControlStateNormal];
    headerView.completion = ^{
        SMLOG(@"");
        [self openAccordionAtIndex:section];
    };
    return headerView;
}

                                    
@end
