
  protocol OceanProtocol{

    /**
    * Le nom de l'Océan
    * nom : oceanProtocol -> String
    **/
    var nom : String {get}
    
    /**
    * La taille initiale de l'océan.
    * taille : oceanProtocol -> (lig:Int, col:Int)
    * lig, col >= 5 et <=8
    **/
    var taille : (lig:Int, col:Int) {get}

    /**
    * L'île appartenant à cet océan
    * ile : oceanProtocol -> IleProtocol
    * Les coordonnées de l'île doivent appartenir aux coordonnées de l'océan
    **/
    var ile : IleProtocol {get}

    /**
    * Le nombre de bateaux restants dans l'océan.
    * nbBatRestant : oceanProtocol -> Int
    * nBatRestant <= 5
    **/
    var nbBatRestant : Int {get}

    /**
    * Le nombre de initial de bateaux dans l'océan.
    * nbBatTotal : oceanProtocol -> Int
    * nBatTotal <= 5
    **/
    var nbBatTotal : Int {get}

    /**
    * Le nombre de bateaux coulés dans cet océan.
    * nbBatCoule : oceanProtocol -> Int
    * nBatCoule <= 5
    **/
    var nbBatCoule : Int {get} 

    /**
    * Tous les bateaux dans l'océan.
    * bateaux : oceanProtocol -> {BateauProtocol|Vide}
    **/
    var bateaux : [BateauProtocol?] {get}

    /**
    * Tous les bateaux coulés de l'océan.
    * batCoules : oceanProtocol -> {BateauProtocol|Vide}
    **/
    var batCoules : [BateauProtocol?] {get}
    
    /**
    * Toutes les positions occupées par des bateaux dans l'océan
    * posOqp : oceanProtocol -> {(lig:Int, col:Int)|Vide}
    **/
    var posOqp : [(lig:Int, col:Int)?] {get}

    /**
    * Toutes les positions occupées par des iles dans l'océan
    * posOqpIle : oceanProtocol -> {(lig:Int, col:Int)}
    **/
    var posOqpIle : [(lig:Int, col:Int)] {get}
  
    /**
    * Fonction de création d'un océan.
    * init : (nom:String) -> oceanProtocol
    * Crée l'océan en fonction de son nom (seule l'initiale est nécessaire : "A","P" ou "I")
    * Les océans sont les suivants :
    *    — l’océan atlantique de taille 6 × 7 ;
    *    — l’océan pacifique de taille 7 × 8 ;
    *    — l’océan Indien de taille 5 × 6.
    * nom = "A" ou "P" ou "I"
    * Crée automatiquement l'île associée à l'océan :
    * — une île des açores pour l’océan atlantique ;
    * — Hawaï pour l’océan pacifique ;
    * — La réunion pour l’océan Indien.
    **/
    init(nom:String)
  
    /**
    * Vérifie s'il y a une position non touchée d'un bateau sur la ligne.
    * oqpLigne : oceanProtocol x Int x Int -> Bool 
    * lig est inclue dans les emplacements possibles de l'océan.
    * Renvoie vrai s'il y a un bateau sur la ligne et qu'il n'y a pas d'île entre le bateau et la position.
    **/
    func oqpLigne(lig: Int,col:Int) -> Bool 
  
    /**
    * Place un bateau
    * placeBateau : oceanProtocol x Int -> oceanProtocol
    * 1<=taille<=4
    * Les coordonnées à rentrer ensuite doivent être adjacentes 
    * Les coordonnées à saisir doivent être inférieure à self.taille 
    * Les coordonnées à rentrer ne doivent appartenir à aucune île ou aucun bateau déjà placé
    * Renvoie vrai si le bateau est bien placé
    **/
    mutating func PlaceBateau(taille:Int, id:Int) -> Bool 

    /**
    * Vérifie s'il y a une position non touché d'un bateau sur la colonne.
    * oqpColonne : oceanProtocol x Int x Int -> Bool
    * col est inclue dans les emplacements possibles de l'océan.
    * Renvoie vrai s'il y a un bateau sur la colonne et qu'il n'y a pas d'île entre le bateau et la position.
    **/
    func oqpColonne(lig: Int, col: Int) -> Bool 
  
    /**
    * Vérifie s'il y a une position non touchée d'un bateau sur la position
    * oqpPosition : oceanProtocol x pos : (lig : Int, col: Int) -> Bool
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles de l'océan. 0 <= lig, col <= self.taille 
    * Renvoie vrai s'il y a un bateau sur la position
    **/
    func oqpPosition(pos : (lig : Int, col: Int)) -> Bool
  
    /**
    * Tire sur la position.
    * tirer : oceanProtocol x pos : (lig : Int, col: Int) -> OceanProtocol x ResTir
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * Renvoie si un bateau est coulé, touché, en vue ou a l'eau.
    **/
    mutating func tirer(pos: (lig: Int, col: Int)) -> ResTir
  
    /**
    * bateau : JeuProtocol x pos: (lig : Int, col : Int) -> BateauProtocol|Vide
    * Revoie un bateau ou non qui se trouve sur la position donnée en paramettre
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    func bateau(pos:(lig:Int, col:Int)) -> BateauProtocol?
  }
  
  
  struct Ocean : OceanProtocol{

    /**
    * Le nom de l'Océan
    * nom : oceanProtocol -> String
    **/
    public private(set) var nom : String 

    /**
    * La taille initiale de l'océan.
    * taille : oceanProtocol -> (lig:Int, col:Int)
    * lig, col >= 5 et <=8
    **/
    public private(set) var taille : (lig:Int, col:Int)

    /**
    * L'île appartenant à cet océan
    * ile : oceanProtocol -> IleProtocol
    * Les coordonnées de l'île doivent appartenir aux coordonnées de l'océan
    **/
    public private(set) var ile : IleProtocol 

    /**
    * Le nombre de bateaux restants dans l'océan.
    * nbBatRestant : oceanProtocol -> Int
    **/
    public private(set) var nbBatRestant : Int

    /**
    * Le nombre de initial de bateaux.
    * nbBatTotal : oceanProtocol -> Int
    **/
    public var nbBatTotal : Int 

    /**
    * Le nombre de bateaux coulés dans cet océan.
    * nbBatCoule : oceanProtocol -> Int
    **/
    public var nbBatCoule : Int 

    /**
    * Tous les bateaux dans l'océan.
    * bateaux : oceanProtocol -> BateauProtocol
    **/
    public private(set) var bateaux : [BateauProtocol?]

    /**
    * Tous les bateaux coulés de l'océan.
    * batCoules : oceanProtocol -> {BateauProtocol|Vide}
    **/
    public private(set) var batCoules : [BateauProtocol?]

    /**
    * Toutes les positions occupées par des bateaux dans l'océan
    * posOqp : oceanProtocol -> {(lig:Int, col:Int)|Vide}
    **/
    public private(set) var posOqp : [(lig:Int, col:Int)?]

    /**
    * Toutes les positions occupées par des iles dans l'océan
    * posOqpIle : oceanProtocol -> {(lig:Int, col:Int)|Vide}
    **/
    public private(set) var posOqpIle : [(lig:Int, col:Int)]
    
    /**
    * Fonction de création d'un océan.
    * init : (nom:String) -> oceanProtocol
    * Crée l'océan en fonction de son nom (seule l'initiale est nécessaire : "A","P" ou "I")
    * nom = "A" ou "P" ou "I"
    * Crée automatiquement l'île associée à l'océan.
    **/
    public init(nom:String){
      let n = nom

      switch n {
      case "A":
        self.taille = (6, 7)
        self.nom="Atlantique"
        // Place l'île
        let acores : IleProtocol = Ile(id:"Açores",positions:[(lig: 0, col: 0), (lig: 0, col: 0) , (lig: 1, col: 0) , (lig: 1, col: 1)])
        self.posOqpIle=acores.positions
        self.ile=acores
      
      case "P":
        self.taille = (7, 8)
        self.nom="Pacifique"
        // Place l'île        
        let hawaii : IleProtocol = Ile(id:"Hawaii",positions:[(lig: 4, col: 5), (lig: 4, col: 6) , (lig: 4, col: 7) , (lig: 3, col: 7)])
        self.posOqpIle=hawaii.positions
        self.ile=hawaii
  
      default:
        // c'est l'océan indien  
        self.nom="Indien"
        self.taille = (5, 6)
        // Place l'île        
        let reunion : IleProtocol = Ile(id:"Réunion",positions:[(lig: 2, col: 2), (lig: 2, col: 3) , (lig: 2, col: 4) , (lig: 2, col: 1)])
        self.posOqpIle=reunion.positions
        self.ile=reunion
      }

      self.posOqp = [(lig: Int, col: Int)?](repeating: nil,  count: 13)
      self.batCoules = [BateauProtocol?](repeating: nil,  count: 5)
      self.bateaux = [BateauProtocol?](repeating: nil,  count: 5)
      self.nbBatTotal = Int(0)
      self.nbBatRestant = Int(0)
      self.nbBatCoule = Int(0)
      
    }

    /**
    * Vérifie s'il y a une position non touchée d'un bateau sur la ligne.
    * oqpLigne : oceanProtocol x Int -> Bool 
    * lig est inclue dans les emplacements possibles de l'océan.
    * Renvoie vrai s'il y a un bateau sur la ligne et qu'il n'y a pas d'île entre le bateau et la position.
    **/
    public func oqpLigne(lig: Int, col: Int) -> Bool {
    // Cherche si il y a une île sur la ligne
    // Si il y en a une, récupère sa colonne
    var colIle: Int? = nil
    for i in posOqpIle {
      if i.lig == lig {
        colIle = i.col
        break
      }
    }
  
    var res = false
    for pos in posOqp {
      if let oqlLig = pos?.lig, let oqlCol = pos?.col {
        if colIle == nil {
          if oqlLig == lig {
            res = true
            break
          }
        } else {
          // Verifie qu'il n'y a pas l'ile entre la position et le bateau
          if oqlLig == lig && ((colIle! > oqlCol && colIle! > col) || (colIle! < oqlCol && colIle! < col)) {
            res = true
            break
          }
        }
      }
    }
  
    return res
  }
    
    /**
    * Vérifie s'il y a une position non touché d'un bateau sur la colonne.
    * oqpColonne : oceanProtocol x Int -> Bool
    * col est inclue dans les emplacements possibles de l'océan.
    * Renvoie vrai s'il y a un bateau sur la colonne et qu'il n'y a pas d'île entre le bateau et la position.
    **/
    public func oqpColonne(lig: Int, col: Int) -> Bool {
    // Cherche si il y a une île sur la colonne
    // Si il y en a une, récupère sa ligne
    var ligIle: Int? = nil
    for i in posOqpIle {
      if lig == i.lig {
        ligIle = i.lig
        break
      }
    }
  
    var res = false
    for pos in posOqp {
      if let oqCol = pos?.col, let oqLig = pos?.lig {
        if ligIle == nil {
          if oqCol == col {
            res = true
            break
          }
        } else {
          // Verifie qu'il n'y a pas l'ile entre la position et le bateau
          if oqCol == col && ((ligIle! > oqLig && ligIle! > lig) || (ligIle! < oqLig && ligIle! < lig)) {
            res = true
            break
          }
        }
      }
    }
  
    return res
  }

    /**
    * Vérifie s'il y a une position non touché d'un bateau sur la position
    * oqpPosition : JeuProtocol x pos : (lig : Int, col: Int) -> Bool
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * Renvoie vrai s'il y a un bateau sur la position
    **/
    public func oqpPosition(pos : (lig : Int, col: Int)) -> Bool {
      var res : Bool = false
      for posi in self.posOqp{
        if let oqlLig = posi?.lig , let oqlCol = posi?.col{
          if oqlLig == pos.lig , oqlCol == pos.col {
            res = true
          }
        }
      }
      return res
    }
  
    private func estEnvue(pos : (lig : Int, col : Int)) -> ResTir{
      var res : ResTir = ResTir.aleau
      // on vérifie si bateau sur ligne ou colonne
      if oqpLigne(lig: pos.lig, col: pos.col) || oqpColonne(lig: pos.lig, col: pos.col){
        // si oui -> envue
        res = ResTir.envue
      }
      return res
    }

    

    /**
    * Tire sur la position.
    * tirer : JeuProtocol x pos : (lig : Int, col: Int) -> JeuProtocol x ResTir
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    * Renvoie si un bateau est coulé, touché, en vue ou a l'eau.
    **/
    mutating public func tirer(pos: (lig: Int, col: Int)) -> ResTir{
      // je cherche s'il y a un bateau sur la position
      var res : ResTir = .aleau
      if oqpPosition(pos: pos){
        if let id = idxBateau(pos: pos){ 
        // est-ce que la position n'a pas été touchée
        if self.bateaux[id]!.positionTouchee(pos: pos) == true{
          // si oui
          // on touche la position
          var _ : BateauProtocol = self.bateaux[id]!.touchePosition(pos: pos)
          // on vérifie si le bateau est touché ou coulé
          if self.bateaux[id]!.estcoule == true{
            res = .coule
            self.batCoules[self.nbBatCoule] = self.bateaux[id]
            self.nbBatRestant -= 1
            self.nbBatCoule += 1
          }
          else{
            res = .touche
          }
        }
        // si non (position bateau déjà touchée)
        else {
          res = estEnvue(pos: pos)
        }
      }
      }
      // sinon (pas de bateau sur la position)
      else {
        res = estEnvue(pos: pos)
      }
      return res
  }

    
    /**
    * bateau : JeuProtocol x pos: (lig : Int, col : Int) -> BateauProtocol|Vide
    * Revoie un bateau ou non qui se trouve sur la position donnée en paramettre
    * pos : un couple de lig, col 
    * lig et col sont inclues dans les emplacements possibles du jeu. 0 <= lig, col <= tailleDuJeu 
    **/
    public func bateau(pos:(lig:Int, col:Int)) -> BateauProtocol? {
      var res : BateauProtocol? = nil
      for bat in self.bateaux {
        for posB in bat!.positionsRestantes{
          if let pLig = posB?.lig , let pCol = posB?.col{
            if pLig == pos.lig , pCol == pos.col{
              res = bat
            }
          }
        }
      }
      return res
    }
    
    private func idxBateau(pos:(lig:Int, col:Int)) -> Int? {
      var i = Int(0)
      for bateau in self.bateaux {
          for position in bateau!.positionsBat {
              if position!.lig == pos.lig && position!.col == pos.col {
                return i
              }
          }
        i += 1
      }
      return nil
    }

    func inputInt(message: String, max : Int = 19) -> Int{
      var reponse : String? = nil
      var rep : Int? = nil
      repeat{
          print(message)
          reponse = readLine()
          if let reponse = reponse{
              rep = Int(reponse)
          }
      } while (reponse == nil) || (rep == nil) || ((rep! < 0) || (rep! > max))
      return rep!
  }
    
    /**
    * Place un bateau
    * placeBateau : oceanProtocol x Int -> oceanProtocol
    * 1<=taille<=4
    * Les coordonnées à rentrer ensuite doivent être adjacentes ET alignées
    * Les coordonnées à saisir doivent être inférieure à self.taille 
    * Les coordonnées à rentrer ne doivent appartenir à aucune île ou aucun bateau déjà placé
    * Renvoie vrai si le bateau a bien été placé
    **/
    mutating public func PlaceBateau(taille:Int, id:Int) -> Bool{
      var positions = [(lig:Int, col:Int)](repeating: (0, 0), count: taille)
      var place : Bool = false
      while (!place){
        place = true
        // Récupère les positions
        var msg = "Saisissez la première ligne du bateau (de 0 à \(self.taille.lig - 1)) :"
        positions[0].lig = inputInt(message: msg)
        msg = "Saisissez la première colonne du bateau (de 0 à \(self.taille.col - 1)):"
        positions[0].col = inputInt(message: msg)
        // test si c'est sur une ile
        for posi in self.posOqpIle{
          if posi == (lig:positions[0].lig, col:positions[0].col) {
            place = false
          }
        }
        // test si cest déja occupé par un bateau
        for posi in self.posOqpIle{
          if posi == (lig:positions[0].lig, col:positions[0].col) {
            place = false
          }
        }
        // test si la position est dans l'ocean
        // lig
        if positions[0].lig < 0 || positions[0].lig > self.taille.lig{
          place = false
        }
        //col
        if positions[0].col < 0 || positions[0].col > self.taille.col{
          place = false
        }
        if taille > 1 && place == true {
          msg = "Vers quelle direction souhaitez-vous que votre bateau aille (N, S, E, O)?"
          print(msg)
          var reponse : String? = nil
          reponse = readLine()
          let direction : String = reponse!
          var i = Int(1)
            switch direction {
            case "E":
              while i < taille {
                positions[i].lig = positions[i-1].lig 
                positions[i].col = positions[i-1].col + 1
                // test si c'est sur une ile
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si cest déja occupé par un bateau
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si la position est dans l'ocean
                // lig
                if positions[i].lig < 0 || positions[i].lig > self.taille.lig{
                  place = false
                }
                //col
                if positions[i].col < 0 || positions[i].col > self.taille.col{
                  place = false
                }
                
                i += 1 
              }
            
            case "S":
              while i < taille {
                positions[i].lig = positions[i-1].lig + 1
                positions[i].col = positions[i-1].col
                // test si c'est sur une ile
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si cest déja occupé par un bateau
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si la position est dans l'ocean
                // lig
                if positions[i].lig < 0 || positions[i].lig > self.taille.lig{
                  place = false
                }
                //col
                if positions[i].col < 0 || positions[i].col > self.taille.col{
                  place = false
                }
              
                i += 1
              }

            case "O":
              while i < taille {
                positions[i].lig = positions[i-1].lig 
                positions[i].col = positions[i-1].col - 1
                // test si c'est sur une ile
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si cest déja occupé par un bateau
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si la position est dans l'ocean
                // lig
                if positions[i].lig < 0 || positions[i].lig > self.taille.lig{
                  place = false
                }
                //col
                if positions[i].col < 0 || positions[i].col > self.taille.col{
                  place = false
                }
                
                i += 1
              }
              
            default:
              // c'est le Nooooooord
              while i < taille {
                positions[i].lig = positions[i-1].lig - 1
                positions[i].col = positions[i-1].col
                // test si c'est sur une ile
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si cest déja occupé par un bateau
                for posi in self.posOqpIle{
                  if posi == (lig:positions[i].lig, col:positions[i].col) {
                    place = false
                  }
                }
                // test si la position est dans l'ocean
                // lig
                if positions[i].lig < 0 || positions[i].lig > self.taille.lig{
                  place = false
                }
                //col
                if positions[i].col < 0 || positions[i].col > self.taille.col{
                  place = false
                }
                
                i += 1
              }
              
            }
          
        }
      }
    
      if place{
        let pos = positions
        let Bateau : BateauProtocol = Bateau(id: id, taille: taille, positions: pos)
        self.nbBatTotal += 1
        self.nbBatRestant += 1
      
        // Récupère l'indice du tableau bateau pour insérer le bateau
        var j = Int(0)
        while self.bateaux[j] != nil{
          j += 1
        }
        self.bateaux[j]=Bateau
      
        // Récupere l'indice du tableau des positions pour insérer les nouvelles positions
        j=0
        while self.posOqp[j] != nil{
          j += 1
        }
        for pos in Bateau.positionsBat{
          self.posOqp[j]=pos
          j += 1
        }
      }
      return place
    }
  }


