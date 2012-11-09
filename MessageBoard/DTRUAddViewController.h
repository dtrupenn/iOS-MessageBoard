//
//  DTRUAddViewController.h
//  MessageBoard
//
//  Created by Daniel Trujillo on 11/7/12.
//  Copyright (c) 2012 DTRUPENN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTRUAddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *bodyInput;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;


@end
