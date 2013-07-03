//
//  CompartirClipBoard.m
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ShareClipBoard.h"

static ShareClipBoard *instance;

@implementation ShareClipBoard

+(ShareClipBoard *) getInstance {
    if (instance == nil) {
        instance = [[ShareClipBoard alloc] init];
    }
    return instance;
}

-(void) copyStringToClipBoard:(NSString *) string {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
}

@end
