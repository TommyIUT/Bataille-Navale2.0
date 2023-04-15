
protocol IleProtocol
{
    /**
    * Le nom de l'île.
    * nom : IleProtocol -> string
    **/
    var nom : String { get } 
    /**
    * La taille fixe/initiale de l'île prédéfinie à 4 cases.
    * taille : IleProtocol -> Int = 4
    **/
    var taille : Int { get } 
    /**
    * Ensembles des positions fixes de l'île.
    * positionsIle : IleProtocol -> {(lig:Int, col:Int)}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    var positions : [(lig:Int, col:Int)] { get }
    /**
    * Fonction de création d'une île.
    * creer : id : Int x taille : Int x positions : {(lig : Int, col: Int)} -> IleProtocol
    * taille = 4 
    * positions : ensemble des coordonées fixes/initiales de l'île.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    init(id: String, positions: [(lig: Int, col: Int)]) 
}
  
  struct Ile : IleProtocol{

    /**
    * Le nom de l'ile.
    * nom : IleProtocol -> string
    **/
    public private(set) var nom : String

    /**
    * La taille fixe de l'île prédéfini à 4 cases.
    * taille : IleProtocol -> Int
    * taille = 4
    **/
    public let taille : Int = 4

    /**
    * Ensembles des positions fixes/initiales de l'île.
    * positions : IleProtocol -> {(lig:Int, col:Int)}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public private(set) var positions : [(lig:Int, col:Int)] 

    /**
    * Fonction de création d'une île.
    * creer : id : Int x taille : Int x positions : {(lig : Int, col: Int)} -> IleProtocol
    * taille = 4 
    * positions : ensemble des coordonées initiales de l'île.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public init(id: String, positions: [(lig: Int, col: Int)]){
      self.nom = id
      self.positions = positions
    }

  }


