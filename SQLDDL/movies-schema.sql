-- Eric Ferguson 
-- August 1 2023
DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
USE movies;

CREATE TABLE genre (
	gId INT AUTO_INCREMENT,
    gName VARCHAR(30) NOT NULL,
    CONSTRAINT pk_genre PRIMARY KEY (gId)
);

CREATE TABLE director(
	dId INT AUTO_INCREMENT,
    dFName VARCHAR(30) NOT NULL,
    dLName VARCHAR(30) NOT NULL,
    dBDay DATE,
    CONSTRAINT pk_director PRIMARY KEY (dId)
);

CREATE TABLE rating (
	rId INT AUTO_INCREMENT,
    rName VARCHAR(5) NOT NULL,
    CONSTRAINT pk_rating PRIMARY KEY (rId)    
);

CREATE TABLE actor (
	aId INT AUTO_INCREMENT,
    aFName VARCHAR(30) NOT NULL,
    aLName VARCHAR(30) NOT NULL,
    aBDay DATE,
    CONSTRAINT pk_actor PRIMARY KEY (aId) 
);

DROP TABLE IF EXISTS movie;
CREATE TABLE movie(
	mId INT AUTO_INCREMENT,
    gId INT NOT NULL,
    dId INT,
    rId INT,
    title VARCHAR(128) NOT NULL,
    releaseDate DATE,
    CONSTRAINT pk_movies PRIMARY KEY (mId),
    CONSTRAINT fk_movie_genre FOREIGN KEY (gId) REFERENCES genre(gId),
    CONSTRAINT fk_movie_director FOREIGN KEY (dId) REFERENCES director(dId),
    CONSTRAINT fk_movie_rating FOREIGN KEY (rId) REFERENCES rating(rId)
    
);


DROP TABLE IF EXISTS castMembers;
CREATE TABLE castMembers (
	cId INT AUTO_INCREMENT,
    aId INT,
    mId INT,
    roll VARCHAR(50) NOT NULL,
    CONSTRAINT pk_castMembers PRIMARY KEY (cId),
    CONSTRAINT fk_castMembers_actor FOREIGN KEY (aId) REFERENCES actor(aId),
    CONSTRAINT fk_castMembers_movie FOREIGN KEY (mId) REFERENCES movie(mId)
);
