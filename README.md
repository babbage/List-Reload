Sample project to demonstrate SwiftUI's lazy loading behaviour in a ForEach when the `.equatable()` modifier is used, and more particularly the lack of lazy loading when it is not.

> NOTE: As of Xcode 16, every SwiftUI view is wrapped in an AnyView *in debug builds only*—[info via Curt Clifton from Apple on Mastodon](https://indieweb.social/@curtclifton/113273571392595819). This is stated to speed switching between previews, simulator, and device, but subverts some List optimizations when running in Debug mode. Wrapping in Equatable, as demonstrated in these examples, is stated to be likely to make performance worse in release builds as it introduces an extra view in the hierarchy for every row. The new debug behaviour meanwhile can be disabled by setting a custom build setting: `SWIFT_ENABLE_OPAQUE_TYPE_ERASURE=NO`

The project will automatically populate a Core Data store for the app with 6,500 items on first launch. In `List_ReloadApp.swift`, set the scenario you want to see by setting the `ContentViewA()` to the B, C or D variants. 

The expected behaviour is described in brief documentation at the top of each of those files, and is:

**ContentViewA:**
With the ForEach called with a subview RowView for each item, the RowView body init method will be called 6,500 times, once for each item in the Core Data store, even though only around 17 rows will initially be displayed.

**ContentViewB:**
Simplifying the RowView content, and removing the NavigationView and NavigationLink does not change anything, the RowView body is still called 6,500 times, once for each item in the Core Data store.

**ContentViewC:**
Moving the full contents of the origincal RowView to be directly inside the ForEach reduces the nuumber of times the body is rendered to around 38 times, when 17 rows are being displayed.

**ContentViewD:**
Making RowView Equatable and specifying .equatable() within the ForEach enables the use of a subview while still getting the correct lazy loading behaviour of the ForEach: only 18 row bodies are evaluated on initial launch, just the views that are initially dispalyed on the screen.

**ContentViewE:**
With RowView Equatable and specifying .equatable() within the ForEach, the correct lazy loading behaviour of the ForEach is still observed with a more complex view that is within a NavigationView: only 18 row bodies are evaluated on initial launch, just the views that are initially dispalyed on the screen.

**ContentViewF:**
An Equatable view can't have an @ObservedObject variable. However, by wrapping the contents of RowView in a RowViewContent view, RowView can be equatable leading to only 18 rows initially being rendered, while RowViewContent can continue to have an @ObservedObject where this is desirable.


All scenarios seen on both iPhone 15 Pro Max physical device on iOS 18 plus iPhone 16 Pro simulator on iOS 18.1.
