DROP TABLE IF EXISTS livre;
DROP TABLE IF EXISTS contenu;
DROP TABLE IF EXISTS est_de;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS etat_commande;
DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS vetement;
DROP TABLE IF EXISTS date_arrivage;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS taille;
DROP TABLE IF EXISTS panier;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS type_vetements;

CREATE TABLE type_vetement(
   id_type_vetement COUNTER,
   libelle_type_vetement VARCHAR(50),
   PRIMARY KEY(id_type_vetement)
);

CREATE TABLE couleur(
   id_couleur COUNTER,
   libelle_couleur VARCHAR(50),
   PRIMARY KEY(id_couleur)
);

CREATE TABLE panier(
   id_panier COUNTER,
   total DECIMAL(15,2),
   PRIMARY KEY(id_panier)
);

CREATE TABLE taille(
   id_taille COUNTER,
   libelle_taille VARCHAR(50),
   PRIMARY KEY(id_taille)
);

CREATE TABLE fournisseur(
   id_fournisseur COUNTER,
   libelle_fournisseur VARCHAR(50),
   PRIMARY KEY(id_fournisseur)
);

CREATE TABLE date_heure(
   id_date DATETIME,
   PRIMARY KEY(id_date)
);

CREATE TABLE note(
   id_note COUNTER,
   valeur_note VARCHAR(50),
   PRIMARY KEY(id_note)
);

CREATE TABLE vetement(
   id_vetement COUNTER,
   nom_vetement VARCHAR(50),
   descriptif VARCHAR(100),
   prix_de_base DECIMAL(15,2) NOT NULL,
   id_type_vetement INT NOT NULL,
   PRIMARY KEY(id_vetement),
   FOREIGN KEY(id_type_vetement) REFERENCES type_vetement(id_type_vetement)
);

CREATE TABLE utilisateur(
   id_utilisateur COUNTER,
   username VARCHAR(50),
   mot_de_passe VARCHAR(50),
   est_actif LOGICAL,
   adresse_mail VARCHAR(50),
   role VARCHAR(255),
   id_panier INT NOT NULL,
   PRIMARY KEY(id_utilisateur),
   FOREIGN KEY(id_panier) REFERENCES panier(id_panier)
);

CREATE TABLE etat_commande(
   id_etat_commande COUNTER,
   libelle_etat VARCHAR(50),
   id_utilisateur INT,
   PRIMARY KEY(id_etat_commande),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE commentaire(
   id_commentaire COUNTER,
   texte VARCHAR(255),
   id_utilisateur INT NOT NULL,
   id_note INT NOT NULL,
   PRIMARY KEY(id_commentaire),
   UNIQUE(id_utilisateur),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur),
   FOREIGN KEY(id_note) REFERENCES note(id_note)
);

CREATE TABLE commande(
   id_commande COUNTER,
   date_commande DATE,
   id_etat_commande INT NOT NULL,
   id_panier INT NOT NULL,
   PRIMARY KEY(id_commande),
   UNIQUE(id_panier),
   FOREIGN KEY(id_etat_commande) REFERENCES etat_commande(id_etat_commande),
   FOREIGN KEY(id_panier) REFERENCES panier(id_panier)
);

CREATE TABLE est_de(
   id_vetement INT,
   id_couleur INT,
   id_taille INT,
   stock INT,
   PRIMARY KEY(id_vetement, id_couleur, id_taille),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_couleur) REFERENCES couleur(id_couleur),
   FOREIGN KEY(id_taille) REFERENCES taille(id_taille)
);

CREATE TABLE est_contenu_dans(
   id_vetement INT,
   id_panier INT,
   quantite_vetement VARCHAR(50),
   PRIMARY KEY(id_vetement, id_panier),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_panier) REFERENCES panier(id_panier)
);

CREATE TABLE livre(
   id_vetement INT,
   id_fournisseur INT,
   id_date DATETIME,
   quantite_arrivage INT,
   PRIMARY KEY(id_vetement, id_fournisseur, id_date),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_fournisseur) REFERENCES fournisseur(id_fournisseur),
   FOREIGN KEY(id_date) REFERENCES date_heure(id_date)
);

CREATE TABLE est_posté_le(
   id_date DATETIME,
   id_commentaire INT,
   PRIMARY KEY(id_date, id_commentaire),
   FOREIGN KEY(id_date) REFERENCES date_heure(id_date),
   FOREIGN KEY(id_commentaire) REFERENCES commentaire(id_commentaire)
);

CREATE TABLE ligne_commande(
   id_vetement INT,
   id_commande INT,
   quantite_vetement_commande VARCHAR(50),
   PRIMARY KEY(id_vetement, id_commande),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE concerne(
   id_vetement INT,
   id_commentaire INT,
   PRIMARY KEY(id_vetement, id_commentaire),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_commentaire) REFERENCES commentaire(id_commentaire)
);



# user (id,username, password, role, est_actif, pseudo, email)
# commande (id, date_achat, #user_id, #etat_id)
# ligne_commande ( #commande_id , #article_id , prix_unit, quantite)
# panier (id, date_ajout,  #user_id , #article_id, prix_unit, quantite)
# etat (id, libelle )
