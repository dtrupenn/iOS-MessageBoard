//
//  MSGMasterViewController.m
//  MessageBoard
//
//  Created by Daniel Trujillo on 11/6/12.
//  Copyright (c) 2012 DTRUPENN. All rights reserved.
//

#import "MSGMasterViewController.h"

#import "MSGDetailViewController.h"

@interface MSGMasterViewController () {
    NSMutableArray *_objects;
    NSArray *_msgs;
    NSMutableData *_data;
}
@end

@implementation MSGMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;

    //Added code
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *msgs = _objects[indexPath.row];
    cell.textLabel.text = [msgs objectForKey:@"title"];
    NSString *testDate = [msgs objectForKey:@"created_at"];
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
    cell.detailTextLabel.text = [dateFormatter stringFromDate:myDate];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
else if ([[segue identifier] isEqualToString:@"addMsg"]) {
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

/**
 * Here are the NSURLConnectionDataDelegate methods that handle the callbacks.
 * This is mostly primarily and three step process, assuming you get no errors.
 *
 * 1. You receive a response.
 * 2. You receive any number of pieces of data.
 * 3. The connection finishes loading. That is, you are ready to use the combined pieces of data.
 */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _objects = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    //Keeps fucking up for some reason
    //_objects = [msgs objectForKey:@""];
    [self.tableView reloadData];
    NSLog(@"%@", _objects);

    
//    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
//    [f setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSString *testDate = @"2012-11-05T00:18:49Z";
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    NSNumber *day = [f numberFromString:[testDate substringWithRange:NSMakeRange(8, 2)]];
//    NSNumber *month = [f numberFromString:[testDate substringWithRange:NSMakeRange(5, 2)]];
//    NSNumber *year = [f numberFromString:[testDate substringWithRange:NSMakeRange(0, 4)]];
//    NSNumber *hour = [f numberFromString:[testDate substringWithRange:NSMakeRange(11, 2)]];
//    NSNumber *min = [f numberFromString:[testDate substringWithRange:NSMakeRange(14, 2)]];
//    NSNumber *sec = [f numberFromString:[testDate substringWithRange:NSMakeRange(17, 2)]];
//    [components setDay:[day intValue]];
//    [components setMonth:[month intValue]];
//    [components setYear:[year intValue]];
//    [components setHour:[hour intValue]];
//    [components setMinute:[min intValue]];
//    [components setSecond:[sec intValue]];
//    NSDate *myDate = [calendar dateFromComponents:components];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    NSString *myDateString = [dateFormatter stringFromDate:myDate];
//    NSLog(@"%@", myDateString);
}


- (IBAction)reload:(id)sender {
    NSLog(@"Reload");
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}
@end
