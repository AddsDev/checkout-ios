//
//  WebView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import SwiftUI
import WebKit

struct CheckoutWebView: UIViewRepresentable {
    let url: String
    @Binding var showWebView: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        return wkWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: CheckoutWebView
        
        init(_ parent: CheckoutWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .other {
                if let urlStr = navigationAction.request.url?.absoluteString, urlStr == RETURN_URL || urlStr == CANCEL_URL {
                    parent.showWebView = false
                    decisionHandler(.cancel)
                    return
                }
            }
            
            decisionHandler(.allow)
        }
    }
}

#Preview {
    Group {
        @State var showWebView = false
        CheckoutWebView(url: "https:\\\\checkout-test.placetopay.com\\spa\\session\\2627760\\915e2581ccc90fa22c79fa640577b84d", showWebView: $showWebView)
    }
}
