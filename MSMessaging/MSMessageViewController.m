//
//  MSMessageViewController.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/24/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageViewController.h"

@interface MSMessageViewController () <MSMessageInputToolbarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSLayoutConstraint *keyboardConstraint;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MSMessageInputToolbar *messageInputToolbar;

- (void)sendPressed:(id)sender;

- (void)closeKeyboard:(id)sender;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation MSMessageViewController

+ (MSMessageInputViewModel *)defaultMessageInputViewModel
{
	MSMessageInputViewModel *viewModel = [[MSMessageInputViewModel alloc] init];
	viewModel.messageTextViewContentInset = UIEdgeInsetsMake(5.f, 3.f, 3.f, 0.f);
	viewModel.sendButtonContentEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, 2.5f, -2.f);
	viewModel.contentInset = UIEdgeInsetsMake(8.f, 8.f, 8.f, 8.f);
	viewModel.messageTextViewCornerRadius = 5.f;
	viewModel.messageTextViewBorderWidth = 0.5f;
	viewModel.messageTextViewBackgroundColor = [UIColor colorWithWhite:1 alpha:0.825f];
	viewModel.messageTextViewBorderColor = [UIColor colorWithWhite:0.5f alpha:0.4f];
	viewModel.messageTextViewFont = [UIFont systemFontOfSize:16];
	viewModel.messageTextViewFontColor = [UIColor darkTextColor];
	viewModel.sendButtonFont = [UIFont boldSystemFontOfSize:17.f];
	
	return viewModel;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.translatesAutoresizingMaskIntoConstraints = NO;
	if (!self.messageInputViewModel) {
		self.messageInputViewModel = [MSMessageViewController defaultMessageInputViewModel];
	}
	
	self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
	[self.collectionView registerClass:[MSMessageBubbleCell class] forCellWithReuseIdentifier:@"messageCell"];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.alwaysBounceVertical = YES;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.contentInset = UIEdgeInsetsMake(6.f, 0.f, 0.f, 0.f);
	[self.view addSubview:self.collectionView];

	self.messageInputToolbar = [[MSMessageInputToolbar alloc] init];
	[self.messageInputToolbar setViewModel:self.messageInputViewModel];
	self.messageInputToolbar.delegate = self;
	[self.view addSubview:self.messageInputToolbar];
		
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.messageInputToolbar action:@selector(endEditing:)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (void)setMaxKeyboardLayoutGuide:(id<UILayoutSupport>)maxKeyboardLayoutGuide
{
	_maxKeyboardLayoutGuide = maxKeyboardLayoutGuide;
	
	NSDictionary *views = @{
		@"collectionView" : self.collectionView,
		@"messageInputToolbar" : self.messageInputToolbar
	};
	
	self.keyboardConstraint = [NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.messageInputToolbar attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
	NSLayoutConstraint *maxKeyboardConstraint = [NSLayoutConstraint constraintWithItem:self.messageInputToolbar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.f constant:self.maxKeyboardLayoutGuide.length - [UIApplication sharedApplication].statusBarFrame.size.height];
	
	[self.view addConstraint:self.keyboardConstraint];
	[self.view addConstraint:maxKeyboardConstraint];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[messageInputToolbar]|" options:0 metrics:nil views:views]];

	UIEdgeInsets contentInset = self.collectionView.contentInset;
	contentInset.top += _maxKeyboardLayoutGuide.length;
	contentInset.bottom += self.messageInputToolbar.intrinsicContentSize.height;
	self.collectionView.contentInset = contentInset;
	
	UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
	scrollIndicatorInsets.top += _maxKeyboardLayoutGuide.length;
	scrollIndicatorInsets.bottom += self.messageInputToolbar.intrinsicContentSize.height;
	self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (void)reloadData
{
	[self.collectionView reloadData];
}

- (void)sendPressed:(id)sender
{
	[self.messageInputToolbar clearInputText];
}

- (void)closeKeyboard:(id)sender
{
	[self.messageInputToolbar endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	UIViewAnimationCurve animationCurve;
	NSTimeInterval animationDuration;
	CGRect keyboardRect;
	
	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
	
	void (^animations)(void) = ^{
		self.keyboardConstraint.constant = keyboardRect.size.height;
		
		[self.view layoutIfNeeded];

		UIEdgeInsets contentInset = self.collectionView.contentInset;
		contentInset.bottom += keyboardRect.size.height;
		self.collectionView.contentInset = contentInset;
		
		UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
		scrollIndicatorInsets.bottom += keyboardRect.size.height;
		self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
		
		NSInteger numItems = [self.collectionView numberOfItemsInSection:0];
		if (numItems) {
			NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:(numItems - 1) inSection:0];
			[self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
		}
	};
	
	[UIView animateWithDuration:animationDuration delay:0.f options:(animationCurve << 16) animations:animations completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	UIViewAnimationCurve animationCurve;
	NSTimeInterval animationDuration;
	CGRect keyboardRect;
	
	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
		
	void (^animations)(void) = ^{
		self.keyboardConstraint.constant = 0.f;
				
		[self.view layoutIfNeeded];

		UIEdgeInsets contentInset = self.collectionView.contentInset;
		contentInset.bottom -= keyboardRect.size.height;
		self.collectionView.contentInset = contentInset;
		
		UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
		scrollIndicatorInsets.bottom -= keyboardRect.size.height;
		self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
	};
	
	[UIView animateWithDuration:animationDuration delay:0.f options:(animationCurve << 16) animations:animations completion:nil];
}

#pragma mark MessageInputToolbarDelegate

- (void)messageInputToolbarDidChangeText:(MSMessageInputToolbar *)messageInputToolbar
{
	[messageInputToolbar scrollToCaret];
}

- (void)messageInputToolbar:(MSMessageInputToolbar *)messageInputToolbar didSendMessageText:(NSString *)messageText
{
	[self.messageInputToolbar clearInputText];
	[self.delegate messageViewController:self didSendMessageText:messageText];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.delegate sizeForItemAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	for (MSMessageBubbleCell *cell in self.collectionView.visibleCells) {
		cell.gradientOffset = (-self.collectionView.contentOffset.y + cell.frame.origin.y);
	}
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.delegate messageCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MSMessageBubbleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"messageCell" forIndexPath:indexPath];
	if (cell) {
		UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
		MSMessageBubbleViewModel *viewModel = [self.delegate messageBubbleViewModelAtIndexPath:indexPath];
		[cell setViewModel:viewModel];
		cell.gradientOffset = (-self.collectionView.contentOffset.y + attributes.frame.origin.y);
	}
	
	return cell;
}

@end
