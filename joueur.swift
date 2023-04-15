
protocol JoueurProtocol{
  
    /**
    * L'identifiant du joueur.
    * id : JoueurProtocol -> Int
    **/
    var id : Int { get } 
    /**
    * Le nom du Joueur
    * nom : JoueurProtocol -> String
    **/
    var nom : String { get }
  
    /**
    * Fonction de création d'un joueur.
    * creer : id : Int x nom : String -> JoueurProtocol
    * Le nom à rentrer dans la fonction doit contenir uniquement des lettres
    **/
    init(id: Int) 
  }
  
  struct Joueur : JoueurProtocol{

    /**
    * L'identifiant du Joueur.
    * id : JoueurProtocol -> Int
    **/
    public private(set) var id : Int

    /**
    * Le nom du joueur.
    * nom : JoueurProtocol -> String
    **/
    public private(set) var nom : String

    
    /**
    * Fonction de création d'un joueur.
    * creer : id : Int x nom : String -> JoueurProtocol
    * Le nom à rentrer dans la fonction doit contenir uniquement des lettres
    **/
    public init(id: Int){
      self.id = id
      print("Joueur \(self.id), veuillez écrire votre nom. ")
      if let nomJ = readLine(){
        self.nom = nomJ
      }else{
        self.nom = "j\(self.id)"
      }
    }

    
  }

