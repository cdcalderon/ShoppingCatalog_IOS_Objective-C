//
//  CategoryCell.m
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 7/7/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import "CategoryCell.h"
#import "Constants.h"

@implementation CategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadImage{
    int x = (280/ 2) - 18;
    int y = (50 / 2) - 18;
    
    activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, 37, 37)];
                [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                [activity setHidesWhenStopped: YES];
                [activity startAnimating];
                
                [self.categoryImage addSubview:activity];
    
   //verify if Image exist
                NSString *urlImage = [NSString stringWithFormat:@"%@%@", [self getDBPath], self.category.image];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if([fileManager fileExistsAtPath:urlImage]){
                    [activity stopAnimating];
                    //load image locally
                    [self.categoryImage setImage:[UIImage imageWithContentsOfFile:urlImage]];
                    self.categoryImage.contentMode = UIViewContentModeScaleAspectFit;
                    self.categoryImage.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
                } else {
                    NSString *urlImage = [NSString stringWithFormat:@"%@%@", URL_IMAGES, self.category.image];
                    //download image from url
                NSURL *url = [NSURL URLWithString:urlImage];
                    if(connection != nil){connection = nil;} // in case we are downloading a second image
                    if(data!=nil){data = nil;}
                    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                    connection = [[NSURLConnection alloc] initWithRequest: request delegate: self];
                    
                }
                
}
-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData{
    if(data== nil){
        data=[[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) theConnection{
    //data should have data by now
    connection = nil;
    [activity stopAnimating];
    
    //save to device
    NSString *urlImage = [NSString stringWithFormat:@"%@%@", [self getDBPath], self.category.image];
    [data writeToFile:urlImage atomically:YES];
    
    //make an image view for the image
    [self.categoryImage setImage:[UIImage imageWithContentsOfFile:urlImage]];
    self.categoryImage.contentMode = UIViewContentModeScaleAspectFit;
    self.categoryImage.autoresizingMask = (UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight);
    
    data = nil;
}

-(NSString *) getDBPath{
    NSURL *urlDocument = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [NSString stringWithFormat:@"%@/", [urlDocument path]];
}

@end
