//
//  ViewController.m
//  DynamicButtonSizeForTitle
//
//  Created by AITL on 3/11/14.
//  Copyright (c) 2014 Adit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    	self.parsedItems = [[NSMutableArray alloc] init];
    [self LoadFeedContent];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)LoadFeedContent{
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSMutableDictionary *mutableDic=[[NSMutableDictionary alloc]init];
    
    
    NSString *RequestURL = [NSString stringWithFormat:@"%@%@", ServerApiURL,FEEDURL] ;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:ServerApiURL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:RequestURL
                                                      parameters:mutableDic];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *responseDic=(NSDictionary*)[[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] JSONValue];
        
        
        
        NSLog(@"FeedArray -%@",responseDic);
        
        NSArray *feedtitle=[responseDic valueForKey:@"posts"];
        [[SingleTon instance] setFeedContentArray:[responseDic valueForKey:@"posts"]];
        for (int i=0; i<[feedtitle count]; i++) {
            
            CGSize constraint = CGSizeMake(320 - (50 * 2), 20000.0f);
            
            CGRect textRect = [[[feedtitle objectAtIndex:i] valueForKey:@"key"] boundingRectWithSize:constraint
                                                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                                                          attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]}
                                                                                             context:nil];
            
            CGSize size1 = textRect.size;
            
            
            
            
            UIButton *titleButton=[[UIButton alloc]initWithFrame:CGRectMake(buttonSize, 0, size1.width+5, 25)];
            
            buttonSize=buttonSize+size1.width+10;
            
            [titleButton setBackgroundColor:[UIColor lightGrayColor]];
            [titleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [titleButton addTarget:self action:@selector(FeedLoadAtIndex:) forControlEvents:UIControlEventTouchUpInside];
            titleButton.tag=i;
            [titleButton setTitle:[NSString stringWithFormat:@"%@",[[feedtitle objectAtIndex:i] valueForKey:@"key"]] forState:UIControlStateNormal];
            [MainScrollView addSubview:titleButton];
            
        }
//        UIButton *btn=[[UIButton alloc] init];
//        btn.tag=0;
//        [self FeedLoadAtIndex:btn];

        [MainScrollView setContentSize:CGSizeMake(buttonSize+2, 25)];
        [MainScrollView setScrollEnabled:YES];
        
        

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
     
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                                         NSLog(@"Error: %@", error);
                                     }];
    [operation start];
    
}



-(void)FeedLoadAtIndex:(id)sender{
    
    [self subviewRemoveFromSuperView];
    
    [MBProgressHUD showHUDAddedTo:SubDetailScrollView animated:YES];
    NSArray *feedURL=[[SingleTon instance] FeedContentArray];
    UIButton *button=(UIButton*)sender;
    NSLog(@"Button %@",[[feedURL objectAtIndex:button.tag] valueForKey:@"url"]);
    
    
//    RSSFeedClass *rssview=[[RSSFeedClass alloc]init];
//    rssview.delegate=self;
    [self LoadFeed:[[feedURL objectAtIndex:button.tag] valueForKey:@"url"]];
    
    
}

-(void)setRSSFeedData:(NSArray *)contentArray{
    
    
    NSLog(@"All Data -%@",contentArray);
    
    
    
    
    for (int i=0; i<[contentArray count]; i++) {
        
        
        FeedView *FView=[[FeedView alloc]initWithNibName:@"FeedView" bundle:nil];
        FView.view.frame=CGRectMake(i*FView.view.frame.size.width, 0, FView.view.frame.size.width, FView.view.frame.size.height);
        
        MWFeedItem *feedObj=[contentArray objectAtIndex:i];
        FView.FeedTitle.text=feedObj.title;
        FView.detailTextField.text=feedObj.summary;
        [SubDetailScrollView addSubview:FView.view];
        
    }
    
    [SubDetailScrollView setContentSize:CGSizeMake(297*[contentArray count], SubDetailScrollView.frame.size.height)];
    [SubDetailScrollView setScrollEnabled:YES];
    SubDetailScrollView.pagingEnabled=YES;
    
    [MBProgressHUD hideHUDForView:SubDetailScrollView animated:YES];
}


-(void)subviewRemoveFromSuperView{
    
    for (UIView *subview in SubDetailScrollView.subviews) {
        [subview removeFromSuperview];
        
    }
    
    
    CGPoint scrollPoint;
    scrollPoint.y=0;
    scrollPoint.x=0;
    [SubDetailScrollView setContentOffset:scrollPoint animated:YES];
    
}

-(CGSize)returnButtonSize:(NSString*)buttonTitle{
    CGSize constraint = CGSizeMake(320 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGRect textRect = [buttonTitle boundingRectWithSize:constraint
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FONT_SIZE]}
                                                context:nil];
    
    CGSize size1 = textRect.size;
    return size1;
}




-(void)LoadFeed:(NSString*)feedUrl{
    
    
    
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];

    
	NSURL *feedURL = [NSURL URLWithString:feedUrl];
	feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
    
    
}
// Reset and reparse
- (void)refresh {
	self.title = @"Refreshing...";
    [self.parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
    
}
#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item)
        [self.parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    

    [self setRSSFeedData:self.parsedItems];
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
    if (self.parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
