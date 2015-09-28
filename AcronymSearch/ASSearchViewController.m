//
//  ASSearchViewController.m
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/22/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import "ASSearchViewController.h"
#import "ASAcronymSearchService.h"
#import "ASLongformObject.h"
#import "ASDetailTableViewController.h"

@interface ASSearchViewController ()

@property(nonatomic,strong) ASAcronymSearchService *service;
@property(nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation ASSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.searchBar.delegate = self;
    self.service = [[ASAcronymSearchService alloc] init];
    self.meanings = [NSArray array];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    self.HUD.labelText = @"Searching";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.HUD show:YES];
    [self.service meaningsForAcronym:searchBar.text withResponse:^(NSArray *meanings, NSError *error) {
        self.meanings = meanings;
        [self.HUD hide:NO];
        [self.tableView reloadData];
    }];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meanings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Display meaning in the table cell
    ASLongformObject *longform = [self.meanings objectAtIndex:indexPath.row];
    cell.textLabel.text = longform.longform;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Since: %@, Occurences: %@",longform.since,longform.freq];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ASLongformObject *longform = [self.meanings objectAtIndex:indexPath.row];
        ASDetailTableViewController *destViewController = segue.destinationViewController;
        destViewController.longform = longform;
        destViewController.shortform = self.searchBar.text;
    }
}

@end
