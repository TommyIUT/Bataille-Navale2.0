
protocol BateauProtocol{
    /**
    * L'identifiant du bateau.
    * id : BateauProtocol -> Int
    **/
    var id : Int { get } 
    /**
    * La taille initiale du bateau.
    * taille : BateauProtocol -> Int
    * 1 <= taille <= 4 
    **/
    var taille : Int { get }
    /**
    * Etat du bateau, coulé ou non. Vrai si le bateau est coulé.
    * estcoule : BateauProtocol -> Bool
    * nbPositionsTouche == taille
    **/
    var estcoule : Bool { get }
    /**
    * Ensembles des positions fixes/initiales du bateau.
    * positionsBat : BateauProtocol -> {(lig:Int, col:Int)}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    var positionsBat : [(lig:Int, col:Int)?] { get }
    /**
    * Les positions touchées du bateau.
    * positionsTouche : BateauProtocol -> {(lig:Int, col:Int)|Vide}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * un couple lig,col est une position existante dans positionsBat.
    **/
    var positionsTouche : [(lig:Int, col:Int)?] { get set }
    /**
    * Les positions restantes non touchées du bateau.
    * positionsRestantes : BateauProtocol -> {(lig:Int, col:Int)|Vide}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * un couple lig,col est une position existante dans positionsBat.
    **/
    var positionsRestantes : [(lig: Int, col: Int)?] { get set }
  
  
    /**
    * Fonction de création d'un bateau.
    * creer : id : Int x taille : Int x positions : {(lig : Int, col: Int)} -> BateauProtocol
    * 1 < taille < 4 
    * positions : ensemble des coordonées initiales du bateau.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    init(id: Int, taille: Int, positions: [(lig: Int, col: Int)?]) 
  
    /** 
    * Touche une position non touché du bateau et met à jour celui-ci.
    * touchePosition : BateauProtocol x pos : (lig : Int, col: Int) -> BateauProtocol
    * pos est inclu dans les positions restantes (non touchées) du bateau.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    mutating func touchePosition(pos :(lig:Int, col:Int)) -> Self 
                                        
    /** 
    * Retourne vrai si la position du bateau non touché est à cette position.
    * positionTouchee : BateauProtocol x pos : (lig : Int, col: Int)
    * pos est inclu dans les positions restantes (non touchées) du bateau.
    * lig et col inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    func positionTouchee(pos :(lig:Int, col:Int)) -> Bool
  }
  
  struct Bateau : BateauProtocol{

    /**
    * L'identifiant du bateau.
    * id : BateauProtocol -> Int
    **/
    public private(set) var id : Int

    /**
    * La taille initiale du bateau.
    * taille : BateauProtocol -> Int
    * 1 <= taille <= 4 
    **/
    public private(set) var taille : Int

    /**
    * Etat du bateau, coulé ou non. Vrai si le bateau est coulé.
    * estcoule : BateauProtocol -> Bool
    * nbPositionsTouche == taille
    **/
    public var estcoule : Bool{
        return nbPositionsRestantes == 0
      }

    /**
    * Ensembles des positions fixes/initiales du bateau.
    * positionsBat : BateauProtocol -> {(lig:Int, col:Int)}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public private(set) var positionsBat : [(lig:Int, col:Int)?] 

    /**
    * Les positions touchées du bateau.
    * positionsTouche : BateauProtocol -> {(lig:Int, col:Int)|Vide}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * un couple lig,col est une position existante dans positionsBat.
    **/
    public var positionsTouche : [(lig:Int, col:Int)?] 

    /**
    * Les positions restantes non touchées du bateau.
    * positionsRestantes : BateauProtocol -> {(lig:Int, col:Int)|Vide}
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * un couple lig,col est une position existante dans positionsBat.
    **/
    public var positionsRestantes : [(lig: Int, col: Int)?] 
    private var nbPositionsTouche : Int
    private var nbPositionsRestantes : Int

    /**
    * Fonction de création d'un bateau.
    * creer : id : Int x taille : Int x positions : {(lig : Int, col: Int)} -> BateauProtocol
    * 1 < taille < 4 
    * positions : ensemble des coordonées initiales du bateau.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public init(id: Int, taille: Int, positions: [(lig: Int, col: Int)?]){
      self.id = id
      self.taille = taille
      self.positionsBat = positions
      self.positionsTouche = [(lig: Int, col: Int)?](repeating: nil,  count: taille)
      self.positionsRestantes = positions
      self.nbPositionsTouche = 0
      self.nbPositionsRestantes = self.taille
    }

    /** 
    * Touche une position non touché du bateau et met à jour celui-ci.
    * touchePosition : BateauProtocol x pos : (lig : Int, col: Int) -> BateauProtocol
    * pos est inclu dans les positions restantes (non touchées) du bateau.
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    mutating public func touchePosition(pos :(lig:Int, col:Int)) -> Self {
      for i in 0..<self.positionsRestantes.count {
        if let posNotNil = self.positionsRestantes[i] {
          if pos == posNotNil {
            self.positionsRestantes[i] = nil
            self.positionsTouche[self.taille - self.nbPositionsRestantes] = pos
            self.nbPositionsRestantes -= 1
            self.nbPositionsTouche += 1
          }
        }
      }
      return self
    }

    /** 
    * Retourne vrai si la position du bateau non touché est à cette position.
    * positionTouchee : BateauProtocol x pos : (lig : Int, col: Int)
    * pos est inclu dans les positions restantes (non touchées) du bateau.
    * lig et col inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public func positionTouchee(pos :(lig:Int, col:Int)) -> Bool{
      var retour : Bool = false
      for position in self.positionsRestantes {
        // N'est pas null
        if let posNotNil = position{
          // Vérifie la condition
          if posNotNil == pos{
            retour = true
          }
        }
      }
      return retour
    }
  }

