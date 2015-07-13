//
//  TableCategoriesViewController.m
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 6/28/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import "TableCategoriesViewController.h"
#import "CategoryCell.h"
#import "CategoryBean.h"

@interface TableCategoriesViewController ()

@end

@implementation TableCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categoryWS = [[CategoryWS alloc] init];
    categoryDAO = [[CategoryDAO alloc] init];
    
    //get tot and mod values
    NSString *totalCategory = [categoryDAO daoGetTotalRecords];
    NSString *maxCategory = [categoryDAO daoGetEstModMax];
    NSString *parameters = [NSString stringWithFormat:@"tot=%@&mod=%@", totalCategory, maxCategory];
    self.categories = [categoryWS wsGetCategories:parameters];
    
    for(int i=0; i<self.categories.count; i++){
        CategoryBean *category = [self.categories objectAtIndex:i];
        //verify if exists
        BOOL exist = [categoryDAO daoExistCategory:category];
        
        if(exist){
            [categoryDAO daoUpdateCategory:category];
        } else{
            [categoryDAO daoCreateCategory:category];
        }
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CategoryCell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CategoryBean *categoryBean = [self.categories objectAtIndex:indexPath.row];
    
    cell.categoryTitleLabel.text = categoryBean.name;
    cell.category = categoryBean;
    [cell loadImage];
    
    return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
