// Protocols

protocol PlayerProtocol {
    var name: String { get set }
    var lives: Int { get set }
}

extension PlayerProtocol {
    var lives: Int {
        0
    }
}

protocol MultiPlayerGameProtocol {
    var players: [PlayerProtocol] { get set }
    
    mutating func start()
    func didChooseContinue(player: PlayerProtocol)
    func gameOver()
}

protocol PlatformGameProtocol {
    var player1: PlayerProtocol { get set }
    var player2: PlayerProtocol? { get set }
    
    mutating func start()
    func didChooseContinue(player: PlayerProtocol)
    func gameOver()
}

extension PlatformGameProtocol {
    func didChooseContinue(player: PlayerProtocol) {}
}

class SuperMarioWorld: PlatformGameProtocol {
    var player1: PlayerProtocol
    var player2: PlayerProtocol?
    
    init(player1: PlayerProtocol, player2: PlayerProtocol) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func start() {
        player1.lives = 3
        player2?.lives = 3
        // iniciaria jogo
    }
    
    func didChooseContinue(player: PlayerProtocol) {
        // reiniciaria o jogo de onde parou
    }
    
    func gameOver() {
        // voltar para tela inicial
    }
}

struct FinalFight3: PlatformGameProtocol {
    var player1: PlayerProtocol
    var player2: PlayerProtocol?
    
    init(player1: PlayerProtocol, player2: PlayerProtocol) {
        self.player1 = player1
        self.player2 = player2
    }
    
    mutating func start() {
        player1.lives = 3
        player2?.lives = 3
        // iniciaria jogo
    }
    
    func didChooseContinue(player: PlayerProtocol) {
        // reiniciaria o jogo de onde parou
    }
    
    func gameOver() {
        // voltar para tela inicial
    }
}

class TicTacToe: PlatformGameProtocol {
    var player1: PlayerProtocol
    var player2: PlayerProtocol?
    
    init(player1: PlayerProtocol, player2: PlayerProtocol) {
        self.player1 = player1
        self.player2 = player2
    }

    func start() {
        // limpa o tabuleiro
    }
    
    func gameOver() {
        // mostra o nome do vencedor
    }
}
