//
//  webView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/5/23.
//

import SwiftUI
import WebKit

//struct WebView2: View {
//    var url: String
//    var body: some View {
//        WebView(url: "\(url)")
//    }
//
//}

struct TaskSwipeGesture: View {
    @State var update = false
    let urlWeb: String
    var body: some View {
#if os(iOS)
        WebView(url: urlWeb)
#elseif os(macOS)
        WebView(request: URLRequest(url: URL(string: urlWeb)!))
#endif
    }
}

struct refreshhelper: View {
    @Binding var update: Bool
    var body: some View {
        Text("loading...")
            .onAppear() {
                update = false
            }
    }
}

#if os(iOS)

class MyScrollViewDelegate: NSObject {
    weak var webView: WKWebView?
}

extension MyScrollViewDelegate: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        printLocation(for: scrollView, label: "will begin dragging")
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        printLocation(for: scrollView, label: "will end dragging")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking {
            printLocation(for: scrollView, label: "is tracking")
        }
    }
    
    private func printLocation(for scrollView: UIScrollView, label: String) {
        if let webView = webView {
            print("\(label) \(scrollView.panGestureRecognizer.location(in: webView))")
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: String
    let scrollViewDelegate = MyScrollViewDelegate()

    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        scrollViewDelegate.webView = webView
        webView.scrollView.delegate = scrollViewDelegate
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: URL(string: url)!)
        uiView.load(request)
    }
}

#elseif os(macOS)

struct WebView: NSViewRepresentable {

    let request: URLRequest

    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.load(request)
    }
}

#endif
