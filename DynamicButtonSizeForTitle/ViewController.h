//
//  ViewController.h
//  DynamicButtonSizeForTitle
//
//  Created by AITL on 3/11/14.
//  Copyright (c) 2014 Adit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeedClass.h"
#import "FeedView.h"
#import "MWFeedParser.h"
@interface ViewController : UIViewController<RSSFeedDelegate,MWFeedParserDelegate>
{

    __weak IBOutlet UIScrollView *MainScrollView;
    __weak IBOutlet UIScrollView *SubDetailScrollView;
    float buttonSize;
    
    
    
    MWFeedParser *feedParser;

	
	// Displaying
	NSArray *itemsToDisplay;

    
}


@property(nonatomic,strong)	NSMutableArray *parsedItems;

@end
