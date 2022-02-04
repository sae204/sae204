DROP TABLE IF EXISTS concerne;
DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS est_posté_le;
DROP TABLE IF EXISTS livre;
DROP TABLE IF EXISTS est_contenu_dans;
DROP TABLE IF EXISTS est_de;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS commentaire;
DROP TABLE IF EXISTS etat_commande;
DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS vetement;
DROP TABLE IF EXISTS note;
DROP TABLE IF EXISTS date_heure;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS taille;
DROP TABLE IF EXISTS panier;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS type_vetement;

CREATE TABLE type_vetement(
   id_type_vetement INT AUTO_INCREMENT,
   libelle_type_vetement VARCHAR(50),
   PRIMARY KEY(id_type_vetement)
);

CREATE TABLE couleur(
   id_couleur INT AUTO_INCREMENT,
   libelle_couleur VARCHAR(50),
   PRIMARY KEY(id_couleur)
);

CREATE TABLE panier(
   id_panier INT AUTO_INCREMENT,
   total DECIMAL(15,2),
   PRIMARY KEY(id_panier)
);

CREATE TABLE taille(
   id_taille INT AUTO_INCREMENT,
   libelle_taille VARCHAR(50),
   PRIMARY KEY(id_taille)
);

CREATE TABLE fournisseur(
   id_fournisseur INT AUTO_INCREMENT,
   libelle_fournisseur VARCHAR(50),
   PRIMARY KEY(id_fournisseur)
);

CREATE TABLE date_heure(
   id_date DATETIME,
   PRIMARY KEY(id_date)
);

CREATE TABLE note(
   id_note INT AUTO_INCREMENT,
   valeur_note VARCHAR(50),
   PRIMARY KEY(id_note)
);

CREATE TABLE vetement(
   id_vetement INT AUTO_INCREMENT,
   nom_vetement VARCHAR(50),
   descriptif VARCHAR(100),
   prix_de_base DECIMAL(15,2) NOT NULL,
   id_type_vetement INT NOT NULL,
   PRIMARY KEY(id_vetement),
   FOREIGN KEY(id_type_vetement) REFERENCES type_vetement(id_type_vetement)
);

CREATE TABLE utilisateur(
   id_utilisateur INT AUTO_INCREMENT,
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
   id_etat_commande INT AUTO_INCREMENT,
   libelle_etat VARCHAR(50),
   id_utilisateur INT,
   PRIMARY KEY(id_etat_commande),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE commentaire(
   id_commentaire INT AUTO_INCREMENT,
   texte VARCHAR(255),
   id_utilisateur INT NOT NULL,
   id_note INT NOT NULL,
   PRIMARY KEY(id_commentaire),
   UNIQUE(id_utilisateur),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur),
   FOREIGN KEY(id_note) REFERENCES note(id_note)
);

CREATE TABLE commande(
   id_commande INT AUTO_INCREMENT,
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

#insert type_vetement
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Pantalons");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Jupes");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Robes");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Pulls");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Vestes et manteaux");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("T-shirt");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Accessoires");
INSERT INTO type_vetement (libelle_type_vetement) VALUES ("Short");

#insert couleur
INSERT INTO couleur (libelle_couleur) VALUES ("rouge");
INSERT INTO couleur (libelle_couleur) VALUES ("bleu");
INSERT INTO couleur (libelle_couleur) VALUES ("orange");
INSERT INTO couleur (libelle_couleur) VALUES ("jaunne");
INSERT INTO couleur (libelle_couleur) VALUES ("violet");
INSERT INTO couleur (libelle_couleur) VALUES ("rose");
INSERT INTO couleur (libelle_couleur) VALUES ("vert");
INSERT INTO couleur (libelle_couleur) VALUES ("bleu marine");
INSERT INTO couleur (libelle_couleur) VALUES ("bordeau");
INSERT INTO couleur (libelle_couleur) VALUES ("blanc");
INSERT INTO couleur (libelle_couleur) VALUES ("noir");
INSERT INTO couleur (libelle_couleur) VALUES ("marron");

#insert taille
INSERT INTO taille (libelle_taille) VALUES ("XXS");
INSERT INTO taille (libelle_taille) VALUES ("XS");
INSERT INTO taille (libelle_taille) VALUES ("S");
INSERT INTO taille (libelle_taille) VALUES ("M");
INSERT INTO taille (libelle_taille) VALUES ("L");
INSERT INTO taille (libelle_taille) VALUES ("XL");
INSERT INTO taille (libelle_taille) VALUES ("XXL");
INSERT INTO taille (libelle_taille) VALUES ("taille unique");

#insert fournisseur
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Superdry");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Lacost");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Tommy hilfiger");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Nike");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Adidas");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Roxy");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Only");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Kaporal");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Temps des cerises");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Louis viutton");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Hermès");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Gucci");
INSERT INTO fournisseur (nom_fournisseur) VALUES ("Zara");

# insert admin
INSERT INTO utilisateur (username,mot_de_passe,adresse_mail,role) VALUES ("admin1","sha256$pBGlZy6UukyHBFDH$2f089c1d26f2741b68c9218a68bfe2e25dbb069c27868a027dad03bcb3d7f69a","admin1@gmail.com","admin");
INSERT INTO utilisateur (username,mot_de_passe,adresse_mail,role) VALUES ("admin2","admin2","admin2@gmail.com","admin");


# insert vetement

INSERT INTO vetement (libelle_vetement,descriptif,prix_de_base,id_type_vetement,image) VALUES
    ('T-shirt','T-shirt ?',12.5,6,'/static/images/tshirtbleu.jpg'),
    ('Pantalons','Pantalons ?',14.5,1,'/static/images/pantalon.jpg'),
    ('Jupes','Jupes ?',15.5,2,'/static/images/jupe.jpg'),
    ('T-shirt','T-shirt ?',16,6,'/static/images/tshirtbleu.jpg'),
    ('Pantalons','Pantalons ?',17.5,1,'/static/images/pantalon.jpg'),
    ('Jupes','Jupes ?',18.5,2,'/static/images/jupe.jpg'),
    ('Pantalons','Pantalons ?',19,1,'/static/images/pantalon.jpg'),
    ('Jupes','Jupes ?',2.5,2,'/static/images/jupe.jpg'),

    ('Short','Short ?',112.99,8,'/static/images/shortnoir.jpg'),
    ('Short','Short ?',132.9,8,'/static/images/shortnoir.jpg'),
    ('Short','Short ?',12.8,8,'/static/images/shortnoir.jpg'),
    ('Pantalons','Pantalons ?',8.5,1,'/static/images/pantalon.jpg'),
    ('Accessoires','Accessoires ?',22.5,7,'/static/images/montre.jpg'),
    ('Accessoires','Accessoires ?',32.5,7,'/static/images/montre.jpg'),
    ('T-shirt','T-shirt ?',42.5,6,'/static/images/tshirtbleu.jpg')
    ;



# insert livre
# INSERT INTO livre(id_vetement,id_fournisseur ,id_date_arrivage ,quantite_arrivage) VALUES (1,1,1,20);
# INSERT INTO livre(id_vetement,id_fournisseur ,id_date_arrivage ,quantite_arrivage) VALUES (2,2,2,30);
# INSERT INTO livre(id_vetement,id_fournisseur ,id_date_arrivage ,quantite_arrivage) VALUES (2,1,3,50);
# INSERT INTO livre(id_vetement,id_fournisseur ,id_date_arrivage ,quantite_arrivage) VALUES (8,4,6,10);


SELECT * FROM fournisseur;
SELECT * FROM taille;
SELECT * FROM type_vetements;
SELECT * FROM couleur;
SELECT * FROM vetement;



SELECT vetement.id_vetement,libelle_vetement,prix_de_base,libelle_type_vetement,nom_fournisseur,libelle_couleur
             FROM vetement
             LEFT JOIN est_de ON est_de.id_vetement = vetement.id_vetement
             LEFT JOIN couleur ON couleur.id_couleur = est_de.id_couleur
             LEFT JOIN type_vetements ON type_vetements.id_type_vetement = vetement.id_type_vetement
             JOIN livre on vetement.id_vetement=livre.id_vetement
             JOIN fournisseur on fournisseur.id_fournisseur=livre.id_fournisseur;
