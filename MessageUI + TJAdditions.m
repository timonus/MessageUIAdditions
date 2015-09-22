// MessageUI + TJAdditions
// Automatically implementing all the default delegate callbacks so you don't have to
// By Tim Johnsen

#import "MessageUI + TJAdditions.h"

#warning Fill in your email
#define FEEDBACK_RECIPIENT @"you@yourdomain.com"		// make this the email you'd like to receive feedback at

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
	
    [viewController presentViewController:controller animated:YES completion:nil];
	[controller release];
}

+ (void)presentInViewController:(UIViewController *)viewController withToRecipients:(NSArray *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody isHTML:(BOOL)isHTML {
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	
	[controller setSubject:subject];
	[controller setMessageBody:messageBody isHTML:isHTML];
	[controller setMailComposeDelegate:controller];
	[controller setToRecipients:recipients];
	
    [viewController presentViewController:controller animated:YES completion:nil];
	[controller release];
}

+ (void)presentFeedbackEmailViewControllerInViewController:(UIViewController *)viewController {
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *deviceModel = [[UIDevice currentDevice] model];
	NSString *deviceOSVersion = [[UIDevice currentDevice] systemVersion];
	
	[MFMailComposeViewController presentInViewController:viewController withToRecipients:[NSArray arrayWithObject:FEEDBACK_RECIPIENT] subject:[NSString stringWithFormat:@"%@ Feedback", appName] messageBody:[NSString stringWithFormat:@"<br><p><font color = \"gray\" size = 2><i>%@ %@ on %@ running iOS %@</i></font></p>", appName, appVersion, deviceModel, deviceOSVersion] isHTML:YES];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
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
	[controller setMessageComposeDelegate:controller];
	
	[controller setMessageComposeDelegate:controller];
	
    [viewController presentViewController:controller animated:YES completion:nil];
	[controller release];
}

#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
