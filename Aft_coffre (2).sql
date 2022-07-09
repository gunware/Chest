-- phpMyAdmin SQL Dump
-- version 4.6.6deb4+deb9u2
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Sam 09 Juillet 2022 à 09:26
-- Version du serveur :  10.1.48-MariaDB-0+deb9u2
-- Version de PHP :  7.0.33-0+deb9u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `fxserver`
--

-- --------------------------------------------------------

--
-- Structure de la table `Aft_coffre`
--

CREATE TABLE `Aft_coffre` (
  `id` int(11) NOT NULL,
  `position` longtext NOT NULL,
  `rotation` text NOT NULL,
  `password` text NOT NULL,
  `type` text NOT NULL,
  `whitelist` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `Aft_coffre`
--

INSERT INTO `Aft_coffre` (`id`, `position`, `rotation`, `password`, `type`, `whitelist`) VALUES
(21, '{\"x\":-43.39735794067383,\"y\":6425.5361328125,\"z\":31.00127792358398}', '-0.9991955468413556', 'Non defini', 'chestbasic', 'craftbar'),
(22, '{\"x\":-1795.8734130859376,\"y\":428.00689697265627,\"z\":131.75918579101563}', '-0.9907616348401352', '3333', 'small', 'no'),
(23, '{\"x\":-1187.3604736328126,\"y\":-1397.71337890625,\"z\":10.0240774154663}', '-0.7764798269017121', '1111', 'medium', 'no');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Aft_coffre`
--
ALTER TABLE `Aft_coffre`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Aft_coffre`
--
ALTER TABLE `Aft_coffre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
