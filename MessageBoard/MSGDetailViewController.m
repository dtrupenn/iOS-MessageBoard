//
//  MSGDetailViewController.m
//  MessageBoard
//
//  Created by Daniel Trujillo on 11/6/12.
//  Copyright (c) 2012 DTRUPENN. All rights reserved.
//

#import "MSGDetailViewController.h"

@interface MSGDetailViewController ()
- (void)configureView;
@end

@implementation MSGDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.body.text = [self.detailItem objectForKey:@"body"];
        self.text.text = [self.detailItem objectForKey:@"title"];

        //Somehow turns created_at time to NSDate
        NSString *testDate = [self.detailItem objectForKey:@"created_at"];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSNumber *day = [f numberFromString:[testDate substringWithRange:NSMakeRange(8, 2)]];
        NSNumber *month = [f numberFromString:[testDate substringWithRange:NSMakeRange(5, 2)]];
        NSNumber *year = [f numberFromString:[testDate substringWithRange:NSMakeRange(0, 4)]];
        NSNumber *hour = [f numberFromString:[testDate substringWithRange:NSMakeRange(11, 2)]];
        NSNumber *min = [f numberFromString:[testDate substringWithRange:NSMakeRange(14, 2)]];
        NSNumber *sec = [f numberFromString:[testDate substringWithRange:NSMakeRange(17, 2)]];
        [components setDay:[day intValue]];
        [components setMonth:[month intValue]];
        [components setYear:[year intValue]];
        [components setHour:[hour intValue]];
        [components setMinute:[min intValue]];
        [components setSecond:[sec intValue]];
        NSDate *myDate = [calendar dateFromComponents:components];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        self.time.text = [dateFormatter stringFromDate:myDate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
