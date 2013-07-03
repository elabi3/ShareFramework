//
//  CompartirFacebook.m
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ShareFacebook.h"
#import <Social/Social.h>

static ShareFacebook *instance;

@implementation ShareFacebook

+(ShareFacebook *) getInstance {
    if (instance == nil) {
        instance = [[ShareFacebook alloc] init];
    }
    return instance;
}

-(void) postToFacebookText:(NSString *) stringText  foto:(UIImage *) foto urlString:(NSString *) stringURL viewController:(UIViewController *) viewController {
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if (stringText) {
        [composeController setInitialText:stringText];
    }
    
    if (foto) {
        [composeController addImage:foto];
    }
    
    if (stringURL) {
        [composeController addURL: [NSURL URLWithString:stringURL]];
    }

    [viewController presentViewController:composeController animated:YES completion:nil];
}

@end
