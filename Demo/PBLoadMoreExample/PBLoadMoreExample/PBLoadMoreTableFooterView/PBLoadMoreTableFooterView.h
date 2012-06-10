//
//  PBLoadMoreTableFooterView.h
//  LoadMoreExample
//
//  Created by NikkO RomanoT on 5/23/55 BE.
//  Copyright (c) 2555 NikkO Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
	PBLoadMoreNormal = 0,
	PBLoadMoreLoading,	
} PBLoadMoreState;

@protocol PBLoadMoreDelegate;

@interface PBLoadMoreTableFooterView : UIView

@property (nonatomic, weak) id <PBLoadMoreDelegate> delegate;

- (void)pbLoadMoreDataSourceDidFinishLoading:(UITableView *)tableView;

@end


@protocol PBLoadMoreDelegate <NSObject>

- (BOOL) pbLoadMoreHasMoreData:(PBLoadMoreTableFooterView *)view;
- (void) pbLoadMoreDidSelectLoadMore:(PBLoadMoreTableFooterView *)view;
- (NSString *) pbLoadMoreSetLoadMoreText:(PBLoadMoreTableFooterView *)view;

@end
