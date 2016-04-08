//
//  ViewController.m
//  DynamicButtonSizeForTitle
//
//  Created by AITL on 3/11/14.
//  Copyright (c) 2014 Adit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

    NSArray *buttonTitles;

}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    buttonTitles = [NSArray arrayWithObjects:@"MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN",@"MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN,MD ADIT HASAN",nil];
    [self loadButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)loadButtons {

    UIView *tempView = self.mainScrollView;
    CGFloat height = 0.0;
    for (int i=0; i<[buttonTitles count]; i++) {
        
        CGSize size = [Helper sizeByStringContent:[buttonTitles objectAtIndex:i]];
        UIButton *titleButton=[[UIButton alloc]initWithFrame:CGRectZero];
        titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [titleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [titleButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        titleButton.tag=i;
        [titleButton setTitle:[NSString stringWithFormat:@"%@",[buttonTitles objectAtIndex:i]] forState:UIControlStateNormal];
        [Helper setConstraintsToView:tempView modifyItem:titleButton scrollview:self.mainScrollView fitheight:size.height];
        [self.mainScrollView addSubview:titleButton];
        height = height + size.height;
        tempView = titleButton;
        titleButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, height)];
    [self.mainScrollView setScrollEnabled:YES];

}


 




@end
