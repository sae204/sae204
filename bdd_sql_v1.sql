CREATE TABLE type_vetements(
   Id_typeVetements COUNTER,
   libelle_type_vetement VARCHAR(50),
   PRIMARY KEY(Id_typeVetements)
);

CREATE TABLE couleur(
   id_couleur VARCHAR(50),
   libelle_couleur VARCHAR(50),
   PRIMARY KEY(id_couleur)
);

CREATE TABLE panier(
   Id_panier COUNTER,
   date_ajout DATE,
   total DECIMAL(15,2),
   PRIMARY KEY(Id_panier)
);

CREATE TABLE role(
   Id_role COUNTER,
   libelle_role VARCHAR(50),
   PRIMARY KEY(Id_role)
);

CREATE TABLE taille(
   Id_taille COUNTER,
   libelle_taille VARCHAR(50),
   PRIMARY KEY(Id_taille)
);

CREATE TABLE fournisseur(
   Id_fournisseur COUNTER,
   PRIMARY KEY(Id_fournisseur)
);

CREATE TABLE date_arrivage(
   Id_date_arrivage COUNTER,
   PRIMARY KEY(Id_date_arrivage)
);

CREATE TABLE vetements(
   Id_vetement COUNTER,
   descriptif VARCHAR(100),
   prixDeBase DECIMAL(15,2) NOT NULL,
   Id_typeVetements INT NOT NULL,
   PRIMARY KEY(Id_vetement),
   FOREIGN KEY(Id_typeVetements) REFERENCES type_vetements(Id_typeVetements)
);

CREATE TABLE commande(
   Id_commande COUNTER,
   date_commande DATE,
   Id_panier INT NOT NULL,
   PRIMARY KEY(Id_commande),
   UNIQUE(Id_panier),
   FOREIGN KEY(Id_panier) REFERENCES panier(Id_panier)
);

CREATE TABLE utilisateur(
   Id_utilisateur COUNTER,
   username VARCHAR(50),
   mot_de_passe VARCHAR(50),
   est_actif LOGICAL,
   adresse_mail VARCHAR(50),
   Id_role INT NOT NULL,
   Id_panier INT NOT NULL,
   PRIMARY KEY(Id_utilisateur),
   FOREIGN KEY(Id_role) REFERENCES role(Id_role),
   FOREIGN KEY(Id_panier) REFERENCES panier(Id_panier)
);

CREATE TABLE est_de(
   Id_vetement INT,
   id_couleur VARCHAR(50),
   Id_taille INT,
   stock VARCHAR(50),
   PRIMARY KEY(Id_vetement, id_couleur, Id_taille),
   FOREIGN KEY(Id_vetement) REFERENCES vetements(Id_vetement),
   FOREIGN KEY(id_couleur) REFERENCES couleur(id_couleur),
   FOREIGN KEY(Id_taille) REFERENCES taille(Id_taille)
);

CREATE TABLE Asso_8(
   Id_vetement INT,
   Id_panier INT,
   quantite VARCHAR(50),
   PRIMARY KEY(Id_vetement, Id_panier),
   FOREIGN KEY(Id_vetement) REFERENCES vetements(Id_vetement),
   FOREIGN KEY(Id_panier) REFERENCES panier(Id_panier)
);

CREATE TABLE livre(
   Id_vetement INT,
   Id_fournisseur INT,
   Id_date_arrivage INT,
   quantite_arrivage INT,
   PRIMARY KEY(Id_vetement, Id_fournisseur, Id_date_arrivage),
   FOREIGN KEY(Id_vetement) REFERENCES vetements(Id_vetement),
   FOREIGN KEY(Id_fournisseur) REFERENCES fournisseur(Id_fournisseur),
   FOREIGN KEY(Id_date_arrivage) REFERENCES date_arrivage(Id_date_arrivage)
);
