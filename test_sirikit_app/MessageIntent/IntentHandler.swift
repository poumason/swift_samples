//
//  IntentHandler.swift
//  MessageIntent
//
//  Created by POU LIN on 2023/12/13.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        if intent is INSendMessageIntent ||
            intent is INSearchForMediaIntent ||
            intent is INSetMessageAttributeIntent {
            return MsgIntentHandler()
        }
        
        if intent is SearchToolIntent {
            return SearchToolHandler()
        }
        
        return self
    }
}
