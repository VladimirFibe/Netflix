import Foundation

protocol SelfConfiguringMovieCell {
  static var identifier: String { get }
    func configure(with movie: Movie)
}
