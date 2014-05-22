//
//  ViewController.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "ViewController.h"
#import "MessageBubbleController.h"
#import "MessageBubbleCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) MessageBubbleController *messageBubbleController;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSArray *sampleMessages;

- (IBAction)addMessage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.messageBubbleController = [[MessageBubbleController alloc] init];
	self.messageBubbleController.collectionViewSize = self.collectionView.bounds.size;
	self.messages = [NSMutableArray array];
	
	NSString *sampleMessagesPath = [[NSBundle mainBundle] pathForResource:@"Messages" ofType:@"plist"];
	self.sampleMessages = [NSArray arrayWithContentsOfFile:sampleMessagesPath];
	
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
}

- (IBAction)addMessage:(id)sender
{
	int randomIndex = rand() % self.sampleMessages.count ;
	NSString *randomMessage = self.sampleMessages[ randomIndex ];
	[self.messages addObject:randomMessage];
	[self.collectionView reloadData];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.messages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *message = (indexPath.row < self.messages.count) ? self.messages[ indexPath.row ] : nil;
	MessageBubbleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"messageCell" forIndexPath:indexPath];
	if (message && cell) {
		UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
		MessageBubbleViewModel *viewModel = [self.messageBubbleController viewModelForSentMessage:message];
		[cell setViewModel:viewModel];
		cell.gradientOffset = (-self.collectionView.contentOffset.y + attributes.frame.origin.y);
	}
	
	return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *message = self.messages[ indexPath.row ];
	MessageBubbleViewModel *viewModel = [self.messageBubbleController viewModelForSentMessage:message];
	return [viewModel.layoutSpec cellSize];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	for (MessageBubbleCell *cell in self.collectionView.visibleCells) {
		cell.gradientOffset = (-self.collectionView.contentOffset.y + cell.frame.origin.y);
	}
}

@end
