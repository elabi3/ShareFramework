//
//  CompartirTwitter.m
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ShareTwitter.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

// Variable de la clase para el patron solitario
static ShareTwitter *instance;
// Array de cuentas 
static NSArray *arrayOfAccounts;

/**
 @Class ShareTwitter
 @Description clase encargada de establecer la comunicacion con el SocialFramework de Apple concretamente para gestionar el acceso a Twitter
 @Method getInstance
 @Method postToTwitterText
 @Method postToTwitterBackgroundWithAccount
 @Method startObtainingAccounts
 @Method openSettingsTwitter
 @Method getAccounts
 @Method getAccountFromUserName
 @Method createMessageWithText
 @Method sendTweetWithAccount
 **/
@implementation ShareTwitter

/**
 @Method getInstance
 @Description metodo encargardo de devolver la instancia actual de la clase
 @Return (ShareTwitter *)
 **/
+(ShareTwitter *) getInstance {
    if (instance == nil) {
        instance = [[ShareTwitter alloc] init];
    }
    return instance;
}

/**
 @Method getAccounts
 @Description metodo nos da un array con todas las cuentas configuradas en el sistema
 @Return (NSArray *)
 **/
-(NSArray *) getAccounts {
    return arrayOfAccounts;
}

/**
 @Method postToTwitterText
 @Description metodo que nos permite enviar un Tweet abriendo la ventana del sistema operativo existente para ese proposito
 @Param (NSString *) stringText - texto del tweet
 @Param (UIImage*) foto - foto del tweet
 @Param (NSString *) stringURL - url que ira en el tweet
 @Param (UIViewController *) viewController - view controller que se encargara de lanzar a la ventana 
 @Return void
 **/
-(void) postToTwitterText:(NSString *) stringText  foto:(UIImage*) foto  urlString:(NSString *) stringURL  viewController:(UIViewController *) viewController {
    // Creamos la ventana de envio del tweet
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Establecemos parametros de la ventana
    if (stringText) {
        [composeController setInitialText:stringText];
    }
    
    if (foto) {
        [composeController addImage:foto];
    }
    
    if (stringURL) {
        [composeController addURL: [NSURL URLWithString:stringURL]];
    }

    // Abrimos la ventana de envio sobre el viewController indicado para ese proposito
    [viewController presentViewController:composeController animated:YES completion:nil];
}

/**
 @Method postToTwitterBackgroundWithAccount
 @Description metodo encargado de enviar un tweet sin que aparezca ninguna venta de confirmacion ni nada por el estilo, de forma totalmente transparente al usuario
 @Param (ACAccount *) account - cuenta desde la que enviaremos el tweet
 @Param (NSString *) stringText - texto del tweet
 @Param (UIImage*) foto - foto del tweet
 @Param (NSString *)video - video del tweet
 @Param (NSString *)latitud
 @Param (NSString *)longitud
 @Param (NSString *) stringURL - url que ira en el tweet
 **/
-(void) postToTwitterBackgroundWithAccount:(ACAccount *) account text:(NSString *)stringText foto:(UIImage *)foto video:(NSString *)video latitud:(NSString *)latitud longitud:(NSString *) longitud urlString:(NSString *)stringURL {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    typedef void (^AccountReturnBlock) (BOOL, NSError *);
        
    // Bloque que se ejecuta si hemos accedido a la cuenta de Twitter del sistema
    AccountReturnBlock resultblock = ^(BOOL granted, NSError *error) {
        if (granted == YES) { //tenemos acceso a las cuentas de Twitter configuradas en el sistema
            NSArray *arrayOfAccounts = [accountStore accountsWithAccountType:accountType]; // iniciamos el array con todas las cuentas disponibles
            
            if ([arrayOfAccounts count] > 0) { // comprobamos que al menos ubiera una cuenta
                BOOL encontrada = NO;
            
                for (ACAccount *acc in arrayOfAccounts) { // buscamos la cuenta desde la que queremos enviar para comprobar que aun esta configurada
                    if ([account.identifier isEqualToString:acc.identifier]) {
                        encontrada = YES;
                        // Preparamos el mensaje
                        NSDictionary *message = [self createMessageWithText:stringText latitud:latitud longitud:longitud urlString:stringURL];
                        // Preparamos el request y enviamos el tweet
                        [self sendTweetWithAccount:acc message:message foto:foto];
                        break;
                    }
                }
                
                if (!encontrada) { // Lanzamos error si no la hemos encontrado entre las del sistema
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AlertViewTwitterTitle", nil) message:NSLocalizedString(@"AlertViewTwitterMessage", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"AlertViewTwitterAccept", nil) otherButtonTitles:nil, nil];
                    [alert show];
                }

            }
            
        }
    };
    
    // Acceso a la cuenta de Twitter configurada en el sistema (esto ejecuta al bloque declarado arriba)
    [accountStore requestAccessToAccountsWithType:accountType options:nil
                                  completion:resultblock];
}

/**
 @Method createMessageWithText
 @Description este metodo crear el jSON que se enviará a twitter a partir de unos parametros indicados
 @Param (NSString *) stringText
 @Param (NSString *) stringText - texto del tweet
 @Param (NSString *)latitud
 @Param (NSString *)longitud
 @Param (NSString *) stringURL - url que ira en el tweet
 @Return (NSDictionary *)
 **/
-(NSDictionary *) createMessageWithText:(NSString *) stringText latitud:(NSString *)latitud longitud:(NSString *)longitud urlString:(NSString *)stringURL {
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    
    if (stringText) {
        [dictionary setObject:stringText forKey:@"status"];
    }
    
    if (stringURL) {
        
    }
    
    if (latitud && longitud) {
        [dictionary setObject:latitud forKey:@"lat"];
        [dictionary setObject:longitud forKey:@"long"];
        
        [dictionary setObject:@"true" forKey:@"display_coordinates"];
    }
    
    return [[NSDictionary alloc] initWithDictionary:dictionary];
}

/**
 @Method sendTweetWithAccount
 @Description metodo que se encarga del envio del mensaje a twitter 
 @Param (ACAccount *) account
 @Param (NSDictionary *) message 
 @Param (UIImage *) foto
 @Return void
 **/
-(void) sendTweetWithAccount:(ACAccount *) account  message:(NSDictionary *) message  foto:(UIImage *) foto {
    // Establecemos la url a la que se enviara el mensaje
    NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
    
    if (foto) {// Si hay foto cambiamos la url
        requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update_with_media.json"];
    }
    
    // Creamos el request que haremos a twitter
    SLRequest *postRequest = [SLRequest
                              requestForServiceType:SLServiceTypeTwitter
                              requestMethod:SLRequestMethodPOST
                              URL:requestURL parameters:message];
    
    // indicamos la cuenta desde la que enviamos el mensaje al request
    postRequest.account = account;
    
    // Si hay foto la adjuntamos
    if (foto) {
        // Pasamos la foto a NSData (binario)
        NSData *imageData = UIImageJPEGRepresentation(foto, 1);
        // Añadimos la foto al request
        [postRequest addMultipartData:imageData withName:@"media[]" type:@"multipart/form-data" filename:@"fileName"];
    }
    
    // Enviamos la petion a twitter 
    [postRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse, NSError *error) { // Codigo que ejecuta al terminar el envio
        //NSLog(@"Twitter HTTP response: %i", [urlResponse statusCode]);
        //NSLog(@"Error: %@", [urlResponse allHeaderFields]);
    }];
}

/**
 @Method startObtainingAccounts
 @Description metodo encargado de cargar las cuentas que haya en el sistema 
 @Return void
 **/
-(void) startObtainingAccounts {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    typedef void (^AccountReturnBlock) (BOOL, NSError *);
    
    // Bloque que se ejecuta si hemos accedido a la cuenta de Twitter del sistema
    AccountReturnBlock resultblock = ^(BOOL granted, NSError *error) {
        if (granted == YES) {
            arrayOfAccounts = [account accountsWithAccountType:accountType];
            // Enviamos una notificacion de que ya se han consultado las cuentas del sistema, ya que esta operacion suele ser lenta
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ArrayOfAccounts" object:nil];
        }
    };
    
    // Acceso a la cuenta de Twitter configurada en el sistema
    [account requestAccessToAccountsWithType:accountType options:nil
                                  completion:resultblock];
}

/**
 @Method getAccountFromUserName
 @Description nos deuelve una cuenta para un nombre de usuario determinado
 @Param (NSString *) userName 
 @Return (ACAccount *)
 **/
-(ACAccount *) getAccountFromUserName: (NSString *) userName {
    for (ACAccount * account in arrayOfAccounts) {
        if ([account.username isEqualToString:userName]) {
            return account;
        }
    }
    return nil;
}

/**
 @Method openSettingsTwitter
 @Description permite abrir las opciones de configuracion del sistema de twitter
 @Param (UIViewController *) viewController 
 @Return void
 **/
-(void) openSettingsTwitter:(UIViewController *) viewController {
    // Iniciamos la ventana de envio de un tweet del sistema
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Eliminadmos las subviews 
    for (UIView *view in [[composeController view] subviews])
        [view removeFromSuperview];
    
    // Hacemos que aparezca sobre el viewController indicado
    [viewController presentViewController:composeController animated:YES completion:nil];
}

@end
