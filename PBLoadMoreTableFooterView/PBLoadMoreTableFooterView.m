//
//  PBLoadMoreTableFooterView.m
//  LoadMoreExample
//
//  Created by NikkO RomanoT on 5/23/55 BE.
//  Copyright (c) 2555 NikkO Laboratory. All rights reserved.
//

#import "PBLoadMoreTableFooterView.h"

#define indicatorSize 60

@interface PBLoadMoreTableFooterView()

@property (nonatomic, strong) UILabel *loadMoreLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIButton *loadMoreButton;
@property (nonatomic) PBLoadMoreState state;
@property (nonatomic) BOOL hasMore;

@end

@implementation PBLoadMoreTableFooterView
@synthesize loadMoreLabel = _loadMoreLabel;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize state = _state;
@synthesize delegate = _delegate;
@synthesize hasMore = _hasMore;
@synthesize loadMoreButton = _loadMoreButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setup];
        [self addSubview:self.loadMoreButton];
        [self addSubview:self.loadMoreLabel];    
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void) refresh {
    if ([_delegate respondsToSelector:@selector(pbLoadMoreSetLoadMoreText:)]) {
        _loadMoreLabel.text = [_delegate pbLoadMoreSetLoadMoreText:self];
    } else {
        _loadMoreLabel.text = @"Load More...";
    }
    
}

//lazy instantiation
- (UILabel *)loadMoreLabel {
    if (!_loadMoreLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:17.0f];
		label.textColor = [UIColor blackColor];
		//label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		//label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
        _loadMoreLabel = label;
    }
    return _loadMoreLabel;
}

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0, self.frame.size.width, self.frame.size.height)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setAdjustsImageWhenHighlighted:YES];
        [button addTarget:self action:@selector(loadMoreTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        _loadMoreButton = button;
    }
    return _loadMoreButton;
}

- (UIActivityIndicatorView *) activityIndicatorView {
    if (!_activityIndicatorView) {
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(self.frame.size.width - (indicatorSize + 10),self.frame.size.height/2 - indicatorSize/2 , indicatorSize, indicatorSize);
        _activityIndicatorView = view;
    }
    return _activityIndicatorView;
}

- (void) setDelegate:(id<PBLoadMoreDelegate>)delegate {
    _delegate = delegate;
    [self refresh];
}

- (void)loadMoreTouchUpInside:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(pbLoadMoreDidSelectLoadMore:)]) {
        [_delegate pbLoadMoreDidSelectLoadMore:self];
    }
    [_activityIndicatorView startAnimating];
    [_loadMoreLabel setTextColor:[UIColor grayColor]];
    [_loadMoreButton setUserInteractionEnabled:NO];
}

- (void)pbLoadMoreDataSourceDidFinishLoading:(UITableView *)tableView {
    //in case you want to do something when loading is done
    [_activityIndicatorView stopAnimating];
    [self shouldShowLoadMore:tableView];
    [_loadMoreLabel setTextColor:[UIColor blackColor]];
    [_loadMoreButton setUserInteractionEnabled:YES];
    [self refresh];
}

- (void)shouldShowLoadMore:(UITableView *)tableView {
    if ([_delegate respondsToSelector:@selector(pbLoadMoreHasMoreData:)]) {
        if (![_delegate pbLoadMoreHasMoreData:self]) {
            //remove from tableView
            [tableView setTableFooterView:nil];
        }
    }
}

@end
