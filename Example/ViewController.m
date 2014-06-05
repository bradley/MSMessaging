//
//  ViewController.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "ViewController.h"
#import "MSMessageViewController.h"
#import "Message.h"

@interface ViewController () <MSMessageViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) MSMessageViewController *messageViewController;
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

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MSMessageBubbleViewModel *viewModel = [self messageBubbleViewModelAtIndexPath:indexPath];
	return viewModel.cellSize;
}

- (MSMessageBubbleViewModel *)messageBubbleViewModelAtIndexPath:(NSIndexPath *)indexPath;
{
	Message *message = self.messages[ indexPath.row ];
	MSMessageBubbleViewModel *viewModel = message.viewModel;
	if (!viewModel || !CGSizeEqualToSize(viewModel.containerSize, self.view.bounds.size)) {
		viewModel = message.viewModel = [[MSMessageBubbleViewModel alloc] initWithContainerSize:self.view.bounds.size messageText:message.messageText isAuthor:message.isAuthor];
	}
	return viewModel;
}

- (void)messageViewController:(MSMessageViewController *)messageViewController didSendMessageText:(NSString *)messageText
{
	Message *message = [[Message alloc] initWithMessageText:messageText isAuthor:YES];
	message.viewModel = [[MSMessageBubbleViewModel alloc] initWithContainerSize:self.view.bounds.size messageText:message.messageText isAuthor:message.isAuthor];
	[self.messages addObject:message];
	[self.messageViewController reloadData];
}

@end
