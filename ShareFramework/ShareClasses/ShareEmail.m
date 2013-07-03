//
//  Created by elabi3.
//

#import "ShareEmail.h"

static ShareEmail *instance;

@implementation ShareEmail

+(ShareEmail *) getInstance {
    if (instance == nil) {
        instance = [[ShareEmail alloc] init];
    }
    return instance;
}

-(void) emailText:(NSString *) stringText  asunto:(NSString *) asunto  destinatarios:(NSArray *) destinatarios urlString:(NSString *) stringURL viewController:(UIViewController *) viewController {
    viewControllerClass = viewController;
    
    if ([MFMailComposeViewController canSendMail]) {
        self.mailComposer  = [[MFMailComposeViewController alloc] init];
        self.mailComposer.mailComposeDelegate = self;
        [self.mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
        
        if (asunto) {
            [self.mailComposer setSubject:asunto];
        }
        
        NSString *stringBody = @"";

        if (stringText) {
            stringBody = [NSString stringWithFormat:@"%@ %@", stringBody, stringText];
        }
        
        if (stringURL) {
            stringBody = [NSString stringWithFormat:@"%@ %@", stringBody, stringURL];
        }
        
        [self.mailComposer setMessageBody:stringBody isHTML:YES];
        
        if (destinatarios) {
            [self.mailComposer setToRecipients:destinatarios];
        }
        
        
        [viewController presentViewController:self.mailComposer animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"EmailNoAccountAlertTitle", nil) message:NSLocalizedString(@"EmailNoAccountAlertMessage", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"EmailNoAccountAlertAccept", nil) otherButtonTitles:nil];
        [alert show];
        
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(dismissAlert:) object:alert];
        [thread start];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Estado del correo:" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
            alert.message = @"Mensaje cancelado";
            break;
        case MFMailComposeResultSaved:
            alert.message = @"Mensaje guardado";
            break;
        case MFMailComposeResultSent:
            alert.message = @"Mensaje enviado";
            break;
        case MFMailComposeResultFailed:
            alert.message = @"Mensaje erróneo";
            break;
        default:
            alert.message = @"Mensaje no enviado";
            break;
    }
    
    [alert show];
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(dismissAlert:) object:alert];
    [thread start];
    
    [viewControllerClass dismissViewControllerAnimated:YES completion:nil];
}

-(void) dismissAlert: (UIAlertView *) alert{
    sleep(2);
    [alert dismissWithClickedButtonIndex:-1 animated:NO];
}


@end
