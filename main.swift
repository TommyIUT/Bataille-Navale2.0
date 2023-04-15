var j1 = Joueur(id: 1)
var jeu1 = Jeu(j: j1)
var j2 = Joueur(id: 2)
var jeu2 = Jeu(j: j2)

print("Choisissez la difficulté : Facile, Normal, Difficile ou Extrême (F, N, D ou E) :")
if let mode = readLine(){
  if mode == "F" {
    print("Mode Facile sélectionné")
    while !jeu1.gagne || !jeu2.gagne {
      print("\(j1.nom) Dans quel océan voulez vous tirer ? (A, P ou I)")
      if let ocean1 = readLine(){
        jeu2.tirer(ocean: ocean1)
      }
      if jeu2.gagne{
        print(j1.nom+" vous avez gagné !! GG ez")
        break
      }
      print("\(j2.nom) Dans quel océan voulez vous tirer ? (A, P ou I)")
      if let ocean2 = readLine(){
        jeu1.tirer(ocean: ocean2)
      }
      if jeu1.gagne{
        print(j2.nom+" vous avez gagné !! GG ez")
      }
    }
  } else {
    var nbTir = Int(0)
    if mode == "N"{
      print("Mode Normal sélectionné")
      nbTir = 65
    } else if mode == "D" {
      print("Mode Difficile sélectionné")
      nbTir = 50
    } else {
      // mode extrême
      print("Mode Etrême sélectionné")
      nbTir = 40
    }
    var i = Int(0)
    while !jeu1.gagne || !jeu2.gagne || i < nbTir {
      print("\(j1.nom) Dans quel océan voulez vous tirer ? (A, P ou I)")
      if let ocean1 = readLine(){
        jeu2.tirer(ocean: ocean1)
      }
      if jeu2.gagne{
        break
      }
      print("\(j2.nom) Dans quel océan voulez vous tirer ? (A, P ou I)")
      if let ocean2 = readLine(){
        jeu1.tirer(ocean: ocean2)
      }
      i += 1
    }
    if !jeu1.gagne && !jeu2.gagne {
      print("Egalité ! Aucun gagnant !")
    }
  }
}
