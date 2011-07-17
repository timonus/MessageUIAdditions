// MessageUI + TJAdditions
// Automatically implementing all the default delegate callbacks so you don't have to
// By Tim Johnsen

#import "MessageUI + TJAdditions.h"

#pragma mark -
#pragma mark MFMailComposeViewController

@implementation MFMailComposeViewController (TJAdditions)

#pragma mark -
#pragma mark Class Methods

+ (void)presentInViewController:(UIViewController *)viewController withSubject:(NSString *)subject messageBody:(NSString *)messageBody isHTML:(BOOL)isHTML {
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	
	[controller setSubject:subject];
	[controller setMessageBody:messageBody isHTML:isHTML];
	[controller setMailComposeDelegate:controller];
	
	[viewController presentModalViewController:controller animated:YES];
	[controller release];
}

+ (void)presentInViewController:(UIViewController *)viewController withToRecipients:(NSArray *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody isHTML:(BOOL)isHTML {
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	
	[controller setSubject:subject];
	[controller setMessageBody:messageBody isHTML:isHTML];
	[controller setMailComposeDelegate:controller];
	[controller setToRecipients:recipients];
	
	[viewController presentModalViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[[controller parentViewController] dismissModalViewControllerAnimated:YES];
}

@end

#pragma mark -
#pragma mark MFMessageComposeViewController

@implementation MFMessageComposeViewController (TJAdditions)

#pragma mark -
#pragma mark Class Methods

+ (void)presentInViewController:(UIViewController *)viewController withBody:(NSString *)body {
	MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	
	[controller setBody:body];
	[controller setDelegate:self];
	
	[controller setMessageComposeDelegate:controller];
	
	[viewController presentModalViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	[[controller parentViewController] dismissModalViewControllerAnimated:YES];
}

@end
