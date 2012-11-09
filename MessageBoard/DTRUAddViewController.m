//
//  DTRUAddViewController.m
//  MessageBoard
//
//  Created by Daniel Trujillo on 11/7/12.
//  Copyright (c) 2012 DTRUPENN. All rights reserved.
//

#import "DTRUAddViewController.h"

@interface DTRUAddViewController ()

@end

@implementation DTRUAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *data = [NSString stringWithFormat:@"message[title]=%@&message[body]=%@", _titleInput.text, _bodyInput.text];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
