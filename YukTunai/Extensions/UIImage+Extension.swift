
extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UIImage {
    func compressImage(maxLength: Int) -> Data {
               // let tempMaxLength: Int = maxLength / 8
               let tempMaxLength: Int = maxLength
               var compression: CGFloat = 1
               guard var data = self.jpegData(compressionQuality: compression), data.count > tempMaxLength else { return self.jpegData(compressionQuality: compression)! }
               
               // 压缩大小
               var max: CGFloat = 1
               var min: CGFloat = 0
               for _ in 0..<6 {
                   compression = (max + min) / 2
                   data = self.jpegData(compressionQuality: compression)!
                   if CGFloat(data.count) < CGFloat(tempMaxLength) * 0.9 {
                       min = compression
                   } else if data.count > tempMaxLength {
                       max = compression
                   } else {
                       break
                   }
               }
               var resultImage: UIImage = UIImage(data: data)!
               if data.count < tempMaxLength { return data }
               
               // 压缩大小
               var lastDataLength: Int = 0
               while data.count > tempMaxLength && data.count != lastDataLength {
                   lastDataLength = data.count
                   let ratio: CGFloat = CGFloat(tempMaxLength) / CGFloat(data.count)
                   print("Ratio =", ratio)
                   let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                             height: Int(resultImage.size.height * sqrt(ratio)))
                   UIGraphicsBeginImageContext(size)
                   resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                   resultImage = UIGraphicsGetImageFromCurrentImageContext()!
                   UIGraphicsEndImageContext()
                   data = resultImage.jpegData(compressionQuality: compression)!
               }
               return data
           }


}
