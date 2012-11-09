//
//  MSGDetailViewController.h
//  MessageBoard
//
//  Created by Daniel Trujillo on 11/6/12.
//  Copyright (c) 2012 DTRUPENN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSGDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextView *body;
@end
