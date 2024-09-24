CREATE DATABASE ca_isabella;

CREATE TABLE `clienti` (
  `CodClienti` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(30) DEFAULT NULL,
  `Cognome` varchar(50) NOT NULL,
  `CodFiscale` varchar(20) DEFAULT NULL,
  `Indirizzo` varchar(100) DEFAULT NULL,
  `Citta` varchar(100) DEFAULT NULL,
  `Stato` varchar(50) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Valutazione` varchar(1000) DEFAULT NULL,
  `Cap` varchar(6) NOT NULL,
  PRIMARY KEY (`CodClienti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `agenzie` (
  `NomeAgenzia` varchar(20) NOT NULL,
  `Commissione` TINYINT UNSIGNED NOT NULL,
  `Colore` enum ('Arancio', 'Giallo', 'Blu', 'Verde', 'Rosso', 'Grigio', 'Nero') NOT NULL,
  PRIMARY KEY (`NomeAgenzia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `camere` (
  `NomeCamera` varchar(30) NOT NULL UNIQUE,
  `NumPostiLetto` tinyint(4) NOT NULL,
  `BagnoInCamera` tinyint(1) NOT NULL,
  `IdCamera` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IdCamera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prenotazioni` (
  `NumPrenotazione` int(11) NOT NULL AUTO_INCREMENT,
  `CodCliente` int(11) NOT NULL,
  `DataPrenotazione` date NOT NULL,
  `DataCheckin` date NOT NULL,
  `DataCheckout` date NOT NULL,
  `NumPersone` tinyint(4) NOT NULL,
  `Prezzo` decimal(5,2) DEFAULT NULL,
  `Acconto` decimal(5,2) DEFAULT NULL,
  `NumPreAgenzia` int(11) DEFAULT NULL,
  `Pagato` tinyint(1) NOT NULL,
  `Agenzia` varchar(20) NOT NULL,
  `StatoPrenotazione` enum('Confermata','Cancellata') NOT NULL,
  `nota` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`NumPrenotazione`),
  FOREIGN KEY (`CodCliente`) REFERENCES `clienti`(`CodClienti`),
  FOREIGN KEY (`Agenzia`) REFERENCES `agenzie`(`NomedAgenzia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `disponibilitacamere` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,  
  `CodPrenotazione` int(11) NOT NULL,
  `Data` date NOT NULL,
  `TipoCamera` varchar(30) NOT NULL,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`TipoCamera`) REFERENCES `camere`(`NomeCamera`),
  FOREIGN KEY (`CodPrenotazione`) REFERENCES `prenotazioni`(`NumPrenotazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `spese` (
`IdSpesa` int(11) NOT NULL AUTO_INCREMENT,
`Descrizione` varchar(100) NOT NULL,
`Importo` decimal(5,2) DEFAULT NULL,
`PrenotazioneId` int(11) NOT NULL,
PRIMARY KEY (`IdSpesa`),
FOREIGN KEY (`PrenotazioneId`) REFERENCES `prenotazioni`(`NumPrenotazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `fatture` (
`IdFattura` int(11) NOT NULL AUTO_INCREMENT,
`NumFattura` int(11) NOT NULL,
`DataFattura` date NOT NULL,
`Importo` decimal(5,2) DEFAULT NULL,
`PrenotazioneId` int(11) NOT NULL,
PRIMARY KEY (`IdFattura`),
FOREIGN KEY (`PrenotazioneId`) REFERENCES `prenotazioni`(`NumPrenotazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
