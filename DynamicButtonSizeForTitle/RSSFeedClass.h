//
//  RSSFeedClass.h
//  Unicabi
//
//  Created by AITL on 3/8/14.
//
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@class RSSFeedDelegate;

@protocol RSSFeedDelegate <NSObject>

-(void)setRSSFeedData:(NSArray*)contentArray;

@end
@interface RSSFeedClass : UIViewController<MWFeedParserDelegate>{
    MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;



}
@property(nonatomic,strong)id<RSSFeedDelegate>delegate;


-(void)LoadFeed:(NSString*)feedUrl;

@end
