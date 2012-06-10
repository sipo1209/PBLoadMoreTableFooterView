//
//  LoadMoreViewController.m
//  PBLoadMoreExample
//
//  Created by NikkO RomanoT on 6/10/55 BE.
//  Copyright (c) 2555 NikkO Laboratory. All rights reserved.
//

#import "LoadMoreViewController.h"
#import "PBLoadMoreTableFooterView.h"

@interface LoadMoreViewController () <PBLoadMoreDelegate> 

@property (nonatomic,strong) NSMutableArray *animalArray;
@property (nonatomic,strong) PBLoadMoreTableFooterView *loadMoreFooterView;

@end

@implementation LoadMoreViewController
@synthesize loadMoreTableView = _loadMoreTableView;
@synthesize animalArray = _animalArray;
@synthesize loadMoreFooterView = _loadMoreFooterView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setAnimalArray:[NSMutableArray arrayWithObjects:@"dog",@"cat",@"elephant",@"monkey",@"frog", nil]];
    PBLoadMoreTableFooterView *loadMoreView = [[PBLoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [loadMoreView setBackgroundColor:[UIColor lightGrayColor]];
    loadMoreView.delegate = self;
    [[self loadMoreTableView] setTableFooterView:loadMoreView];
    [self setLoadMoreFooterView:loadMoreView];
}

- (void)viewDidUnload
{
    [self setLoadMoreTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.animalArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"loadMoreCell";
    UITableViewCell *cell = [_loadMoreTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.animalArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row %3 == 0) {
        [cell setBackgroundColor:[UIColor brownColor]];
    }
    else if (indexPath.row %3 == 1) {
        [cell setBackgroundColor:[UIColor colorWithRed:252.0/255.0 green:194.0/255.0 blue:0 alpha:1.0]];
    }
}

#pragma tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL) pbLoadMoreHasMoreData:(PBLoadMoreTableFooterView *)view {
    return YES;
}

- (void) pbLoadMoreDidSelectLoadMore:(PBLoadMoreTableFooterView *)view {
    //load data
    [self performSelector:@selector(fakeLoadData) withObject:nil afterDelay:1.0f];
}

- (NSString *) pbLoadMoreSetLoadMoreText:(PBLoadMoreTableFooterView *)view {
    return @"Load More Animals";
}
     
- (void) fakeLoadData {
    [self.loadMoreFooterView pbLoadMoreDataSourceDidFinishLoading:self.loadMoreTableView];
    [self.animalArray addObjectsFromArray:[NSArray arrayWithObjects:@"Penguin",@"Lion",@"Tiger", nil]];
    [_loadMoreTableView reloadData];
}


@end
