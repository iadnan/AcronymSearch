//
//  ASSearchViewController.h
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/22/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ASSearchViewController : UITableViewController<UISearchBarDelegate>

@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)NSArray *meanings;

@end

