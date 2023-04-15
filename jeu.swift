
  protocol JeuProtocol{
    
    /**
    * Le nombre de bateaux restants.
    * nbBatRestant : JeuProtocol -> Int
    **/
    var nbBatRestant : Int {get}
    /**
    * Le nombre de bateaux total.
    * nbBatTotal : JeuProtocol -> Int
    **/
    var nbBatTotal : Int {get}
    /**
    * Le nombre de bateaux coulés.
    * nbBatCoule : JeuProtocol -> Int
    **/
    var nbBatCoule : Int {get} 
    
    /**
    * Etat du jeu.
    * gagne : JeuProtocol -> Bool
    * Vrai si la partie est gagnée.
    * nbBatCoule == nbBatTotal ou nbBatRestant == 0
    **/
    var gagne : Bool {get}

    /**
    * Les 3 océans du jeu: Atlantique, Pacifique et Indien
    * oceans : JeuProtocol -> [OceanProtocol]
    **/
    var oceans : [OceanProtocol] {get}

    /**
    * Le joueur assigné à ce jeu
    * oceans : JeuProtocol -> JoueurProtocol
    **/
    var joueur : JoueurProtocol {get}
  
    /**
    * Fonction de création d'un jeu.
    * jouer : (j: JoueurProtocol) -> JeuProtocol
    * Crée le jeu et les 3 océans avec leurs îles respectives
    **/
    init(j : JoueurProtocol)
  
    /**
    * Tire dans un des océans du jeu
    * tirer : JeuProtocol x ocean: String -> JeuProtocol x ResTir
    * Ocean correspond à un des océans du jeu: ocean = A , P ou I
    * Renvoie si un bateau est coulé, touché, en vue ou a l'eau.
    **/
    mutating func tirer(ocean: String)

    /**
    * Place un bateau dans un des océans du jeu
    * ajtBateau : JeuProtocol x taille: String x id: String -> JeuProtocol x Bool
    * La taille du bateau est comprise entre 1 et 4
    **/
    mutating func ajtBateau(taille: Int, id: Int) 
    
  }
  
  
  struct Jeu : JeuProtocol{

    /**
    * Le nombre de bateaux restants.
    * nbBatRestant : JeuProtocol -> Int
    **/
    public private(set) var nbBatRestant : Int

    /**
    * Le nombre de bateaux totals.
    * nbBatTotal : JeuProtocol -> Int
    **/
    public var nbBatTotal : Int 
    
    /**
    * Le nombre de bateaux coulés.
    * nbBatCoule : JeuProtocol -> Int
    **/
    public var nbBatCoule : Int 

    /**
    * Etat du jeu.
    * gagne : JeuProtocol -> Bool
    * Vrai si la partie est gagné.
    * nbBatCoule == nbBatTotal ou nbBatRestant == 0
    **/
    public var gagne : Bool

    /**
    * Les 3 océans du jeu: Atlantique, Pacifique et Indien
    * oceans : JeuProtocol -> [OceanProtocol]
    **/
    public var oceans : [OceanProtocol] 
    
    /**
    * Le joueur assigné à ce jeu
    * oceans : JeuProtocol -> JoueurProtocol
    **/
    public var joueur : JoueurProtocol 
  
    /**
    * Fonction de création d'un jeu.
    * jouer : (j: JoueurProtocol) -> JeuProtocol
    * Crée le jeu et les 3 océans avec leurs îles respectives
    **/
    public init(j: JoueurProtocol){
      self.gagne = false
      self.joueur = j
      //Crée les oceans
      let ocean0 : OceanProtocol = Ocean(nom: "A")
      let ocean1 : OceanProtocol = Ocean(nom: "P")
      let ocean2 : OceanProtocol = Ocean(nom: "I")
      self.oceans = [ocean0, ocean1, ocean2]
      
      //Placement des bateaux
      self.nbBatRestant = Int(5)
      self.nbBatTotal = Int(5)
      self.nbBatCoule = Int(0)
      print("Bienvenue \(j.nom), veuillez placer vos bateaux")
      self.ajtBateau(taille: 4, id:0)
      self.ajtBateau(taille: 3, id:1)
      self.ajtBateau(taille: 3, id:2)
      self.ajtBateau(taille: 2, id:3)
      self.ajtBateau(taille: 1, id:4)
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
    * Tire dans un des océans du jeu
    * tirer : JeuProtocol x ocean: String -> JeuProtocol x ResTir
    * Ocean correspond à un des océans du jeu: ocean = A , P ou I
    * Renvoie si un bateau est coulé, touché, en vue ou a l'eau.
    **/
    mutating public func tirer(ocean: String) {
      let o = ocean

      switch o {
      case "A":
        let lig = inputInt(message: "Donnez une ligne comprise entre 0 et \(self.oceans[0].taille.lig - 1)")
        let col = inputInt(message: "Donnez une colonne comprise entre 0 et \(self.oceans[0].taille.col - 1)")
        let res = self.oceans[0].tirer(pos: (lig: lig,col: col))
        tirRes(resultat: res)
      
      case "P":
        let lig = inputInt(message: "Donnez une ligne comprise entre 0 et \(self.oceans[1].taille.lig - 1)")
        let col = inputInt(message: "Donnez une colonne comprise entre 0 et \(self.oceans[1].taille.col - 1)")
        let res = self.oceans[1].tirer(pos: (lig: lig,col: col))
        tirRes(resultat: res)
      
      case "I":
        let lig = inputInt(message: "Donnez une ligne comprise entre 0 et \(self.oceans[2].taille.lig - 1)")
        let col = inputInt(message: "Donnez une colonne comprise entre 0 et \(self.oceans[2].taille.col - 1)")
        
        let res = self.oceans[2].tirer(pos: (lig: lig, col: col))
        tirRes(resultat: res)
      
      default:
          print("Cet océan n'existe pas voyons")
      }

      
    }

    /**
    * En fonction d'un ResTir, 
    * Cette fonction va gérer l'affichage du résultat 
    * et aussi les variables servant à compter les bateaux 
    * Annonce la victoire si il ne reste plus de bateau
    **/
    mutating public func tirRes(resultat: ResTir){
      let r = resultat
      switch r{
      case .touche: print("Touché !")
      case .coule: 
        self.nbBatRestant -= 1
        self.nbBatCoule += 1
        print("Coulé !")
        if self.nbBatRestant == 0{
          self.gagne = true
        }else{
          print("Il reste encore \(self.nbBatRestant) bateaux à couler")
        }
      case .envue: print("En vue !")
      case .aleau: print("À l'eau !")
      }
    }

    /**
    * Place un bateau dans un des océans du jeu
    * ajtBateau : JeuProtocol x taille: String x id: String -> JeuProtocol x Bool
    * La taille du bateau est comprise entre 1 et 4
    * L'utilisateur doit écrire soit A soit P soit I pour choisir l'océan
    **/
    mutating public func ajtBateau(taille: Int, id: Int){
      var place : Bool = false
      while place == false {
        print("Vous allez placer un bateau de taille \(taille)")
        print("Dans quel océan voulez-vous placer votre bateau ? (A, P ou I)")
        var reponse : String? = nil
        reponse = readLine()
        let idb = id
        switch reponse {
        case "A":
          place=self.oceans[0].PlaceBateau(taille: taille, id: idb)
        case "P":
          place=self.oceans[1].PlaceBateau(taille: taille, id: idb)
        case "I":
          place=self.oceans[2].PlaceBateau(taille: taille, id: idb)
        default:
          print("Cet océan n'existe pas voyons")
        }
      }
      
      
    }
    
  }

