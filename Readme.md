# tijo MessageUI Additions

The tijo MessageUI framework additions are two categories on `MFMailComposeViewController` and `MFMessageComposeViewController` respectively that do a few things:

1. Implement the `MFMailComposeViewController` and `MFMessageComposeViewController` delegate callbacks within the classes themselves
2. Implement class methods for production of self-delegating instances of `MFMailComposeViewController` and `MFMessageComposeViewController`
3. Add a convenient class method for producing a feedback view controller for collecting feedback from users of your App.

This makes it so that, rather than worrying about creating a message or mail compose delegate that handles the callbacks for these, you can simply call one method to present a MessageUI view controller and it will dismiss itself when ready. The feedback view controller is cool if you want to add a user feedback button in the about screen of your App, it provides the App version and device it was running on along with any user feedback in a pre-built `MFMailComposeViewController`.