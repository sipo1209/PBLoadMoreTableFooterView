//
//  LoadMoreViewController.h
//  PBLoadMoreExample
//
//  Created by NikkO RomanoT on 6/10/55 BE.
//  Copyright (c) 2555 NikkO Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *loadMoreTableView;

@end
