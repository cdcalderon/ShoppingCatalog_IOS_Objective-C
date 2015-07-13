//
//  TableCategoriesViewController.h
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 6/28/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryWS.h"
#import "CategoryDAO.h"

@interface TableCategoriesViewController : UITableViewController
{
    CategoryWS *categoryWS;
    CategoryDAO * categoryDAO;
}

@property (strong, nonatomic) NSArray *categories;

@end
