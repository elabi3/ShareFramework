ShareFramework
==============

ShareFramework helps you to share content with others apps in iOS

<h2>Frameworks</h2>
 You need to import the following frameworks to your project.

 - MessageUI.framework
 - Social.framework
 - Accounts.framework


<h2>Add to your project</h2>

 - Copy in your project the following classes
 https://github.com/elabi3/ShareFramework/tree/master/ShareFramework/ShareClasses

 - Method 1:
   You can access to these class from everywhere in your project.
   Add to your "Supporting Files/{name}-Prefix.pch": #import "ShareHeaders.h"
 
 - Method 2:
   Add #import "ShareHeaders.h" to the class that you need

<h2>Overview</h2>

Class Name and description of each operation.

<table>
	<tbody>
		<tr>
			<th colspan="2">ShareClipBoard</th>
		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareClipBoard.m">copyStringToClipBoard</a></td>
    			<td>Copy the content of a NSString passed like argument to clipboard</td>
  		</tr>
		<tr>
			<th colspan="2">ShareEmail</th>
		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareEmail.m">emailText</a></td>
    			<td>Open de Email windows in-App. You can specify the email address, subject, and other parameters</td>
  		</tr>
		<tr>
			<th colspan="2">ShareFacebook</th>
		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareFacebook.m">postToFacebookText</a></td>
    			<td>Open the System Facebook Windows with or without content</td>
  		</tr>
		<tr>
			<th colspan="2">ShareOpen</th>
		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openSafariURLFromString</a></td>
  			<td>Open the url passed like an NSString in Safari app</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openChromeURLFromString</a></td>
  			<td>Open the url passed like an NSString in Google Chrome app</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openOperaMiniURLFromString</a></td>
  			<td>Open the url passed like an NSString in Opera Mini app</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openSearchChromeFromString</a></td>
  			<td>Search in Google the text passed like NSString and show you the result in Google Chrome app</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openPhoneNumberFromString</a></td>
  			<td>Open the Phone app with the number given like a NSString, not testing if is a valid number</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">openMessage</a></td>
  			<td>Open the Message app</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareOpen.m">existChrome</a></td>
  			<td>Check if the Google Chrome app is installed in the device</td>
  		</tr>
		<tr>
			<th colspan="2">ShareTwitter</th>
		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">postToTwitterText</a></td>
  			<td>Open the twitter system window</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">postToTwitterBackgroundWithAccount</a></td>
  			<td>Post a tweet in background (without show the system twitter window)</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">startObtainingAccounts</a></td>
  			<td>Obtain the twitter accounts configured in the System, is important do this action before "getAccounts" or "GetAccountFromUserName"</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">openSettingsTwitter</a></td>
  			<td>Open a system windows that let you go to the Twitter Settings, you must pass your current ViewController for present the window</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">getAccounts</a></td>
  			<td>Get all twitter accounts configured in the current device</td>
  		</tr>
		<tr>
			<td><a href="https://github.com/elabi3/ShareFramework/blob/master/ShareFramework/ShareClasses/ShareTwitter.m">getAccountFromUserName</a></td>
  			<td>Get a twitter account, in the device, which name is equal to the NSString passed like argument </td>
		</tr>
	</tbody>
</table>


<h2>Creator</h2>

Abimael Barea Puyana 
 - email: elabi3@gmail.com
 - twitter: @elabi3


