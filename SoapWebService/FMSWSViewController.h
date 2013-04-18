//
//  FMSWSViewController.h
//  SoapWebService
//
//  Created by Frank Muenchow on 18.04.13.
//  Copyright (c) 2013 Frank Muenchow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMSWSViewController : UIViewController

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;

- (void)callWebService;

@end
