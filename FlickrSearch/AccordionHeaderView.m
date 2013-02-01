//
//  AccordionHeaderView.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 2/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "AccordionHeaderView.h"

@implementation AccordionHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (IBAction)buttonHandler:(id)sender {
    SMLOG(@"");
    if(self.completion){
        self.completion();
    }
}


@end
