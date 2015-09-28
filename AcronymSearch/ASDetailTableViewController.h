//
//  ASDetailTableViewController.h
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/27/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASLongformObject.h"

@interface ASDetailTableViewController : UITableViewController

@property(nonatomic,strong,nonnull) NSString *shortform;
@property(nonatomic,strong,nonnull) ASLongformObject *longform;

@end
