import UIKit

final class FileStorage {
    static func downloadImage(link: String, completion: @escaping (UIImage?) -> Void) {
        let fileName = String(link.split(separator: "/").last ?? "name")
        if let image = UIImage(contentsOfFile: fileInDocumetsDirectory(fileName: fileName)) {
            completion(image)
        } else if let url = URL(string: link) {
            let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
            downloadQueue.async {
                if let data = NSData(contentsOf: url) {
                    saveFileLocally(data, fileName: fileName)
                    DispatchQueue.main.async {
                        completion(UIImage(data: data as Data))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }

    static func saveFileLocally(_ fileData: NSData, fileName: String) {
        let docUrl = getDocumentsURL().appendingPathComponent(fileName, isDirectory: false)
        print(docUrl)
        fileData.write(to: docUrl, atomically: true)
    }

    static func saveImageLocally(_ image: UIImage, fileName: String) {
        guard let data = image.jpegData(compressionQuality: 1.0) as? NSData else { return }
        saveFileLocally(data, fileName: fileName)
    }

    static func getDocumentsURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }

    static func fileInDocumetsDirectory(fileName: String) -> String {
        getDocumentsURL().appendingPathComponent(fileName).path
    }

    static func fileExistsAtPath(_ path: String) -> Bool {
        FileManager.default.fileExists(atPath: fileInDocumetsDirectory(fileName: path))
    }
}
