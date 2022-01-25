CREATE TABLE type_vetement(
   id_type_vetement COUNTER,
   libelle_type_vetement VARCHAR(50),
   PRIMARY KEY(id_type_vetement)
);

CREATE TABLE couleur(
   id_couleur VARCHAR(50),
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
   PRIMARY KEY(id_fournisseur)
);

CREATE TABLE date_arrivage(
   id_date_arrivage COUNTER,
   PRIMARY KEY(id_date_arrivage)
);

CREATE TABLE vetement(
   id_vetement COUNTER,
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
   id_couleur VARCHAR(50),
   id_taille INT,
   stock VARCHAR(50),
   PRIMARY KEY(id_vetement, id_couleur, id_taille),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_couleur) REFERENCES couleur(id_couleur),
   FOREIGN KEY(id_taille) REFERENCES taille(id_taille)
);

CREATE TABLE contenu(
   id_vetement INT,
   id_panier INT,
   quantite VARCHAR(50),
   PRIMARY KEY(id_vetement, id_panier),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_panier) REFERENCES panier(id_panier)
);

CREATE TABLE livre(
   id_vetement INT,
   id_fournisseur INT,
   id_date_arrivage INT,
   quantite_arrivage INT,
   PRIMARY KEY(id_vetement, id_fournisseur, id_date_arrivage),
   FOREIGN KEY(id_vetement) REFERENCES vetement(id_vetement),
   FOREIGN KEY(id_fournisseur) REFERENCES fournisseur(id_fournisseur),
   FOREIGN KEY(id_date_arrivage) REFERENCES date_arrivage(id_date_arrivage)
);
