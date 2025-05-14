import SwiftUI
import ElegantEmojiPicker

@available(iOS 14.0, *)
struct SwiftUIDemoView: View {
    @State private var selectedEmoji: Emoji? = nil
    @State private var isEmojiPickerPresented: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text("SwiftUI Demo")
                .font(.title)

            if let emoji = selectedEmoji {
                Text(emoji.emoji)
                    .font(.system(size: 50))
            } else {
                Text("No emoji selected")
                    .font(.headline)
            }

            Button(action: {
                isEmojiPickerPresented.toggle()
            }) {
                Text(selectedEmoji == nil ? "Pick an Emoji" : "Change Emoji")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .emojiPicker(
            isPresented: $isEmojiPickerPresented,
            selectedEmoji: $selectedEmoji,
            configuration: ElegantConfiguration(
                showRandom: false,
                persistSkinTones: true),
            localization: ElegantLocalization(
                searchFieldPlaceholder: "SwiftUI Search")
        )
    }
}

@available(iOS 14.0, *)
struct SwiftUIDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDemoView()
    }
} 
