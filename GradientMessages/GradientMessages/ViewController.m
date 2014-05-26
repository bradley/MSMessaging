//
//  ViewController.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "ViewController.h"
#import "MessageViewController.h"
#import "Message.h"

@interface ViewController () <MessageViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) MessageViewController *messageViewController;
@property (nonatomic, strong) NSArray *sampleMessageStrings;

- (IBAction)addRandomMessage:(id)sender;

- (Message *)createRandomMessage;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.messages = [NSMutableArray array];
	
	NSString *sampleMessageStringsPath = [[NSBundle mainBundle] pathForResource:@"Messages" ofType:@"plist"];
	self.sampleMessageStrings = [NSArray arrayWithContentsOfFile:sampleMessageStringsPath];
}

- (void)viewWillLayoutSubviews
{
	self.messageViewController.maxKeyboardLayoutGuide = self.topLayoutGuide;
	[super viewWillLayoutSubviews];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"embedMessageViewSegue"]) {
		self.messageViewController = segue.destinationViewController;
		self.messageViewController.delegate = self;
	}
	else {
		return [super prepareForSegue:segue sender:sender];
	}
}

- (IBAction)addRandomMessage:(id)sender
{
	Message *randomMessage = [self createRandomMessage];
	[self.messages addObject:randomMessage];
	[self.messageViewController reloadData];
}

- (Message *)createRandomMessage
{
	int randomIndex = rand() % self.sampleMessageStrings.count;
	NSString *randomMessageText = self.sampleMessageStrings[ randomIndex ];
	BOOL randomIsAuthor = rand() % 2;
	return [[Message alloc] initWithMessageText:randomMessageText isAuthor:randomIsAuthor];
}

#pragma mark MessageViewControllerDelegate

- (NSUInteger)messageCount
{
	return self.messages.count;
}

- (Message *)messageAtIndexPath:(NSIndexPath *)indexPath
{
	return self.messages[ indexPath.row ];
}

- (void)messageViewController:(MessageViewController *)messageViewController didSendMessageText:(NSString *)messageText
{
	Message *message = [[Message alloc] initWithMessageText:messageText isAuthor:YES];
	[self.messages addObject:message];
	[self.messageViewController reloadData];
}

@end
