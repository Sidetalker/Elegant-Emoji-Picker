import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct ElegantEmojiPickerRepresentable: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedEmoji: Emoji?
    let configuration: ElegantConfiguration
    let localization: ElegantLocalization

    func makeUIViewController(context: Context) -> ElegantEmojiPicker {
        let picker = ElegantEmojiPicker(
            delegate: context.coordinator,
            configuration: configuration,
            localization: localization
        )
        return picker
    }

    func updateUIViewController(_ uiViewController: ElegantEmojiPicker, context: Context) {
        // Updates can be handled here if needed, for example, if configuration or localization could change
        // while the picker is presented. For now, we assume they are set at initialization.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ElegantEmojiPickerDelegate, UIAdaptivePresentationControllerDelegate {
        var parent: ElegantEmojiPickerRepresentable

        init(_ parent: ElegantEmojiPickerRepresentable) {
            self.parent = parent
        }

        // MARK: - ElegantEmojiPickerDelegate
        func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
            parent.selectedEmoji = emoji
        }

        // MARK: - UIAdaptivePresentationControllerDelegate
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            // Handle dismissal by swipe or other non-programmatic means
            if parent.isPresented {
                parent.isPresented = false
            }
        }
        
        // Optional delegate methods that we can leave to their default implementations for now
        // or expose further if advanced customization is needed.
        // func emojiPicker(_ picker: ElegantEmojiPicker, focusedSectionChanged to: Int, from: Int) {}
        // func emojiPicker(_ picker: ElegantEmojiPicker, searchResultFor prompt: String, fromAvailable: [EmojiSection]) -> [Emoji] {
        //     return ElegantEmojiPicker.getSearchResults(prompt, fromAvailable: fromAvailable)
        // }
        // func emojiPicker(_ picker: ElegantEmojiPicker, didStartPreview emoji: Emoji) {}
        // func emojiPicker(_ picker: ElegantEmojiPicker, didChangePreview emoji: Emoji, from: Emoji) {}
        // func emojiPicker(_ picker: ElegantEmojiPicker, didEndPreview emoji: Emoji) {}
        // func emojiPickerDidStartSearching(_ picker: ElegantEmojiPicker) {}
        // func emojiPickerDidEndSearching(_ picker: ElegantEmojiPicker) {}
        // func emojiPickerShouldDismissAfterSelection (_ picker: ElegantEmojiPicker) -> Bool { return true }
        // func emojiPicker (_ picker: ElegantEmojiPicker, loadEmojiSections withConfiguration: ElegantConfiguration, _ withLocalization: ElegantLocalization) -> [EmojiSection] {
        //     return ElegantEmojiPicker.getDefaultEmojiSections(config: withConfiguration, localization: withLocalization)
        // }
    }
}

@available(iOS 14.0, *)
struct EmojiPickerViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedEmoji: Emoji?
    var configuration: ElegantConfiguration = ElegantConfiguration()
    var localization: ElegantLocalization = ElegantLocalization()

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ElegantEmojiPickerRepresentable(
                    isPresented: $isPresented,
                    selectedEmoji: $selectedEmoji,
                    configuration: configuration,
                    localization: localization
                )
                .ignoresSafeArea(.container, edges: .bottom)
            }
    }
}

@available(iOS 14.0, *)
public extension View {
    func emojiPicker(
        isPresented: Binding<Bool>,
        selectedEmoji: Binding<Emoji?>,
        configuration: ElegantConfiguration = ElegantConfiguration(),
        localization: ElegantLocalization = ElegantLocalization()
    ) -> some View {
        self.modifier(
            EmojiPickerViewModifier(
                isPresented: isPresented,
                selectedEmoji: selectedEmoji,
                configuration: configuration,
                localization: localization
            )
        )
    }
} 