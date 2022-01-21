DROP  TABLE IF EXISTS vetements;
DROP  TABLE IF EXISTS typeVetements;


CREATE TABLE typeVetements(
   Id_typeVetements COUNTER,
   libelle VARCHAR(50),
   PRIMARY KEY(Id_typeVetements)
);

CREATE TABLE vetements(
   Id_vetement COUNTER,
   descriptif VARCHAR(100),
   prixDeBase DECIMAL(15,2),
   taille INT,
   dateAchat DATE,
   Id_typeVetements INT NOT NULL,
   PRIMARY KEY(Id_vetement),
   FOREIGN KEY(Id_typeVetements) REFERENCES typeVetements(Id_typeVetements)
);
