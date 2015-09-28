//
//  ASDetailTableViewController.m
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/27/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import "ASDetailTableViewController.h"

@interface ASDetailTableViewController ()

@end

@implementation ASDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return 3;
    }else{
        return self.longform.variations.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.section == 0){
        static NSString *CellIdentifier = @"NewCell";
         cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        if([indexPath row] == 0){
            cell.textLabel.text = @"Long Form";
            cell.detailTextLabel.text = self.longform.longform;
        }else
            if([indexPath row] == 1) {
                cell.textLabel.text = @"Since";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.longform.since];
            }else
                if([indexPath row] == 2) {
                    cell.textLabel.text = @"Occurences";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.longform.freq];
                }
    }else{
        static NSString *CellIdentifier = @"NewCell2";
        cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        // Display meaning in the table cell
        ASLongformObject *longform = [self.longform.variations objectAtIndex:indexPath.row];
        cell.textLabel.text = longform.longform;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Since: %@, Occurences: %@",longform.since,longform.freq];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = self.shortform;
            break;
        case 1:
            sectionName = @"Variations";
            break;
    }
    return sectionName;
}

@end
