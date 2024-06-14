import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let window = NSApplication.shared.windows.first {
      window.setContentSize(NSSize(width: 1200, height: 800)) // Set your initial window size here
      window.minSize = NSSize(width: 1200, height: 800) // Set your minimum window size here
//      window.maxSize = NSSize(width: 1920, height: 1080) // Set your maximum window size here
    }
    super.applicationDidFinishLaunching(aNotification)
  }
}
